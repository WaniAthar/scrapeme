import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:scrapeme/controllers/controllers.dart';
import 'package:scrapeme/controllers/login_screen_controllers/login_widget_controller.dart';
import 'package:scrapeme/utils/scrapeme.dart';
import '../../models/models.dart';
import '../../services/services.dart';

// Define an AuthState class to handle different states
class AuthState {
  final bool isLoginLoading;
  final bool isSignupLoading;
  final bool isGoogleSignInLoading;
  final bool isAuthenticated;

  AuthState({
    required this.isLoginLoading,
    required this.isSignupLoading,
    required this.isGoogleSignInLoading,
    required this.isAuthenticated,
  });

  factory AuthState.initial() => AuthState(
      isLoginLoading: false,
      isSignupLoading: false,
      isGoogleSignInLoading: false,
      isAuthenticated: false);
}

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(this.apiService, this.cacheService, this.loginController,
      this.signupController, this.userController)
      : super(AuthState.initial());

  final ApiService apiService;
  final CacheService cacheService;
  final LoginController loginController;
  final SignupPageController signupController;
  final UserController userController;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: Scrapeme.googleClientID,
    scopes: ['email'],
  );
  Logger log = Logger();

  Future<void> handleGoogleSignIn() async {
    try {
      state = AuthState(
          isGoogleSignInLoading: true,
          isAuthenticated: false,
          isLoginLoading: false,
          isSignupLoading: false); // Set loading state
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      log.d("after sign in method call");

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        log.d("after authentication call");
        final String token = googleAuth.accessToken!;
        log.d("GOOGLE TOKEN: $token");

        Map<String, dynamic> data =
            await apiService.postRequest('/OAuth/google', {'token': token});
        log.d("after post request");

        if (data['success'] ?? false) {
          await cacheService.saveTokensToCache(
              accessToken: data['access'], refreshToken: data['refresh']);
          log.d("after saving tokens");

          state = AuthState(
              isGoogleSignInLoading: false,
              isAuthenticated: true,
              isLoginLoading: false,
              isSignupLoading: false);
        } else {
          state = AuthState(
              isLoginLoading: false,
              isSignupLoading: false,
              isGoogleSignInLoading: false,
              isAuthenticated: false);
        }
      } else {
        state = AuthState(
            isGoogleSignInLoading: false,
            isAuthenticated: false,
            isLoginLoading: false,
            isSignupLoading: false);
      }
    } catch (e) {
      log.e("Error in Google sign-in: $e");
      state = AuthState(
          isGoogleSignInLoading: false,
          isAuthenticated: false,
          isLoginLoading: false,
          isSignupLoading: false);
    }
  }

  Future<void> login() async {
    state = AuthState(
        isLoginLoading: true,
        isAuthenticated: false,
        isSignupLoading: false,
        isGoogleSignInLoading: false);

    Map<String, dynamic> data = await apiService.postRequest('/token', {
      "email": loginController.emailController.text,
      "password": loginController.passwordController.text,
    });

    if (data['access'] != null || data['refresh'] != null) {
      await cacheService.saveTokensToCache(
          accessToken: data['access'], refreshToken: data['refresh']);
      await userController.getUserProfile();
      state = AuthState(
          isLoginLoading: false,
          isAuthenticated: true,
          isSignupLoading: false,
          isGoogleSignInLoading: false);
    } else {
      state = AuthState(
          isLoginLoading: false,
          isAuthenticated: false,
          isSignupLoading: false,
          isGoogleSignInLoading: false); // Failed login
    }
  }

  Future<void> signup() async {
    state = AuthState(
        isSignupLoading: true,
        isAuthenticated: false,
        isLoginLoading: false,
        isGoogleSignInLoading: false);

    Map<String, dynamic> data = {
      'email': signupController.emailController.text.trim(),
      'name': signupController.nameController.text.trim(),
      'password': signupController.passwordController.text.trim(),
      'password2': signupController.confirmPasswordController.text.trim()
    };

    Map<String, dynamic> res = await apiService.postRequest('/signup', data);

    if (res['success'] ?? false) {
      await cacheService.saveTokensToCache(
          accessToken: res['access'], refreshToken: res['refresh']);
      await userController.getUserProfile();
      state = AuthState(
          isSignupLoading: false,
          isAuthenticated: true,
          isLoginLoading: false,
          isGoogleSignInLoading: false);
    } else {
      state = AuthState(
          isSignupLoading: false,
          isAuthenticated: false,
          isLoginLoading: false,
          isGoogleSignInLoading: false);
    }
  }
}

final authProvider = StateNotifierProvider<AuthProvider, AuthState>(
  (ref) {
    final apiService = ref.watch(apiServiceProvider);
    final signupController = ref.watch(signupPageControllerProvider);
    final loginController = ref.watch(loginControllerProvider);
    final cacheService = ref.watch(cacheServiceProvider);
    final userController = ref.watch(userProvider.notifier);

    return AuthProvider(apiService, cacheService, loginController,
        signupController, userController);
  },
);

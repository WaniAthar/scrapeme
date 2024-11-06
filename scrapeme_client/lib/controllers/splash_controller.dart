import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import '../services/services.dart';
import 'controllers.dart';

enum SplashState {
  loading,
  authenticated,
  unauthenticated,
}

class SplashController extends StateNotifier<SplashState> {
  SplashController(this.cacheService, this.apiService, this.userController)
      : super(SplashState.loading);
  Logger logger = Logger();
  final CacheService cacheService;
  final ApiService apiService;
  final UserController userController;

  Future<void> checkToken() async {
    logger.d("Checking token");
    state = SplashState.loading;
    await cacheService.fetchTokensFromCache();
    final accessToken = cacheService.accessToken;
    final refreshToken = cacheService.refreshToken;
    // logger.e(JwtDecoder.getExpirationDate(refreshToken!));
    logger.d("Access token: $accessToken Refresh token: $refreshToken");
    if (refreshToken == null || accessToken == null) {
      logger.d("Token is null");
      state = SplashState.unauthenticated;
      logger.e(state);
      return;
    }

    if (!JwtDecoder.isExpired(accessToken)) {
      logger.d("Access token is not expired");
      await userController.getUserProfile();
      state = SplashState.authenticated;
    }
    if (JwtDecoder.isExpired(refreshToken)) {
      logger.d("Refresh token is expired");
      state = SplashState.unauthenticated;
      logger.e(state);
      return;
    }

    if (JwtDecoder.isExpired(accessToken)) {
      logger.d("Access token is expired");
      try {
        logger.d("Refreshing token");
        await apiService.refreshToken();
        logger.d("Token refreshed");
        await cacheService.fetchTokensFromCache();
        await userController.getUserProfile();
        logger.d("User fetched");
        state = SplashState.authenticated;
        logger.e(state);
        return;
      } catch (e) {
        logger.e("Error refreshing token: $e");
        state = SplashState.unauthenticated;
        logger.e(state);
        return;
      }
    } else {
      state = SplashState.unauthenticated;
      logger.e(state);
      return;
    }
  }
}

final splashProvider = StateNotifierProvider<SplashController, SplashState>(
  (ref) {
    return SplashController(ref.watch(cacheServiceProvider),
        ref.watch(apiServiceProvider), ref.watch(userProvider.notifier));
  },
);

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/controllers/controllers.dart';
import 'package:scrapeme/routes/routes.dart';
import 'package:scrapeme/widgets/toast_notification.dart';
import 'package:scrapeme/widgets/widgets.dart';

import '../constants/constants.dart';

class LoginWidget extends ConsumerWidget {
  LoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = ref.watch(loginControllerProvider);
    return Container(
      width: 450,
      decoration: BoxDecoration(
        color: Colours.tertiaryColor.withOpacity(0.07),
        border: Border.all(color: Colours.tertiaryColor, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Text(
            "Start using ScrapeMe",
            style: GoogleFonts.ebGaramond(
              color: Colours.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
          child: GoogleLogin(onTap: () async {
            ref.read(authProvider.notifier).handleGoogleSignIn();
            if (ref.watch(authProvider).isAuthenticated) {
              Navigator.of(context).pushReplacementNamed(Routes.home);
              CustomToast.success("Success!", "You are now logged in");
            } else {
              CustomToast.error("Error!", "Something went wrong");
            }
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            "OR",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colours.primaryColor,
            ),
          ),
        ),
        Form(
          key: loginController.loginFormKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
                child: InputField(
                  hintText: "yourname@yourCompany.com",
                  validator: (value) => validateEmail(value),
                  controller: loginController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    debugPrint("value: $value");
                    debugPrint(
                        "controller: ${loginController.emailController.text}");
                  },
                  onFieldSubmitted: (value) => validateEmail(value),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
                child: InputField(
                  hintText: "Password",
                  isPassword: true,
                  maxLines: 1,
                  validator: (value) => validatePassword(value),
                  controller: loginController.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    debugPrint("value: $value");
                    debugPrint(
                        "controller: ${loginController.passwordController.text}");
                  },
                  onFieldSubmitted: (value) => validatePassword(value),
                ),
              ),
            ],
          ),
        ),
        ref.watch(authProvider).isLoginLoading
            ? Center(
                child: Container(
                margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
                child: const CircularProgressIndicator(
                  color: Colours.primaryColor,
                ),
              ))
            : Container(
                margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
                child: InkWell(
                  onTap: () async {
                    if (loginController.loginFormKey.currentState?.validate() ??
                        false) {
                      loginController.loginFormKey.currentState?.save();
                      await ref.read(authProvider.notifier).login();
                      if (ref.watch(authProvider).isAuthenticated) {
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.home, (route) => false);
                        }
                        CustomToast.success(
                            "Success!", "You are now logged in");
                      }
                    } else {
                      CustomToast.error("Error!", "Please fill all the fields");
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colours.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text("Continue with email",
                          style: GoogleFonts.inter(
                              color: Colours.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: "Don't have an account? ",
                style: GoogleFonts.inter(
                    color: Colours.primaryColor, fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: "Sign up",
                style: GoogleFonts.inter(
                    color: Colours.primaryColor, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(
                      context,
                      Routes.signup,
                    );
                  },
              ),
            ],
          )),
        ),
      ]),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Invalid Email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }
}

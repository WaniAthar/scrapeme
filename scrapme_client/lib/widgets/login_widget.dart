import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/controllers/controllers.dart';
import 'package:scrapeme/routes/routes.dart';
import 'package:scrapeme/widgets/widgets.dart';

import '../constants/constants.dart';

class LoginWidget extends ConsumerWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

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
          child: const GoogleLogin(),
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
        Container(
          margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
          child: InputField(
            hintText: "yourname@yourCompany.com",
            validator: (value) => validateEmail(value),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              debugPrint("value: $value");
              debugPrint("controller: ${emailController.text}");
            },
            onFieldSubmitted: (value) => validateEmail(value),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
          child: InputField(
            hintText: "Password",
            isPassword: true,
            validator: (value) => validatePassword(value),
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {
              debugPrint("value: $value");
              debugPrint("controller: ${passwordController.text}");
            },
            onFieldSubmitted: (value) => validatePassword(value),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
          child: InkWell(
            onTap: () {
              // ref.read(loginProvider.notifier).state = true;
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
                        color: Colours.white, fontWeight: FontWeight.bold)),
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
                    Navigator.pushNamed(context, Routes.signup, );
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
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})')
        .hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
    }
    return null;
  }
}

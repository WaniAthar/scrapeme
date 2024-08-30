import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/constants/constants.dart';
import 'package:scrapeme/controllers/login_screen_controllers/signup_widget_controller.dart';

import 'package:scrapeme/widgets/widgets.dart';

class SignupWidget extends ConsumerWidget {
  SignupWidget({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final validationProvider = ref.watch(signupValidationProvider);
    final signupProvider = ref.watch(signupUserProvider);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          width: 450,
          decoration: BoxDecoration(
            color: Colours.tertiaryColor.withOpacity(0.07),
            border: Border.all(color: Colours.tertiaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
              child: Text(
                "Kindly fill your details",
                style: GoogleFonts.ebGaramond(
                  color: Colours.primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
              child: InputField(
                  controller:
                      ref.read(signupPageControllerProvider).nameController,
                  validator: (value) => validationProvider.validateName(value),
                  keyboardType: TextInputType.name,
                  hintText: "Athar Wani",
                  labelText: "Name*"),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
              child: InputField(
                  validator: (value) => validationProvider.validateEmail(value),
                  controller:
                      ref.read(signupPageControllerProvider).emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "atharwani@gmail.com",
                  labelText: "Email*"),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
              child: InputField(
                  controller:
                      ref.read(signupPageControllerProvider).passwordController,
                  validator: (value) =>
                      validationProvider.validatePassword(value),
                  keyboardType: TextInputType.visiblePassword,
                  // hintText: "Athar123",
                  labelText: "Password*",
                  isPassword: true),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
              child: InputField(
                  controller: ref
                      .read(signupPageControllerProvider)
                      .confirmPasswordController,
                  validator: (value) =>
                      validationProvider.validateConfirmPassword(
                          value,
                          ref
                              .read(signupPageControllerProvider)
                              .passwordController
                              .text),
                  keyboardType: TextInputType.visiblePassword,
                  // hintText: "Athar123",
                  labelText: "Confirm Password*",
                  isPassword: true),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
              child: InkWell(
                onTap: () {
                  signupProvider.signup(context, _formKey);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colours.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text("Signup",
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
                    text: "Already have an account? ",
                    style: GoogleFonts.inter(
                        color: Colours.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: "Login",
                    style: GoogleFonts.inter(
                        color: Colours.primaryColor,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(
                          context,
                        );
                      },
                  ),
                ],
              )),
            ),
          ]),
        ),
      ),
    );
  }
}

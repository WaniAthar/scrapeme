import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/constants/constants.dart';

class SignupWidget extends ConsumerWidget {
  const SignupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            "Sign up",
            style: GoogleFonts.ebGaramond(
              color: Colours.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ]),
    );
  }
}

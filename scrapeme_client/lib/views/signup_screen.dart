import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/constants/constants.dart';
import 'package:scrapeme/controllers/controllers.dart';
import 'package:scrapeme/widgets/widgets.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      appBar: AppBar(
        titleSpacing: screenWidth * 0.1,
        title: const Text(
          'ScrapeMe',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: "Let's ", style: headerTextStyle(context)),
                  TextSpan(
                    text: " Sign You Up",
                    style: GoogleFonts.inter(
                        fontSize: 55, fontWeight: FontWeight.bold),
                  )
                ], style: headerTextStyle(context)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
              child: SignupWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/constants/constants.dart';
import 'package:scrapeme/controllers/controllers.dart';
import 'package:scrapeme/widgets/widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      appBar: AppBar(
        titleSpacing: screenWidth * 0.14,
        title: const Text(
          'ScrapeMe',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
                child: const AniamtedLandingText(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
                child: const LoginWidget(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
                width: screenWidth * 0.9,
                child: Text(
                  "ScrapeMe is an next generation AI assistant that \nhelps you to scrape data from almost any website.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ebGaramond(
                    color: Colours.primaryColor,
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}

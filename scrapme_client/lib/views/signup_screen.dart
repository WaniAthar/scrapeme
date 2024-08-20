import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapeme/constants/constants.dart';
import 'package:scrapeme/controllers/controllers.dart';
import 'package:scrapeme/widgets/widgets.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends ConsumerState<SignupScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = ref.read(loginPageControllerProvider).pageController;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      appBar: AppBar(
        titleSpacing: screenWidth * 0.14,
        title: const Text(
          'ScrapeMe',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
              child: const AniamtedLandingText(),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
              child: const SignupWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

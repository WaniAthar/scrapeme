import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapeme/controllers/controllers.dart';
import 'package:scrapeme/routes/routes.dart';

import '../constants/constants.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SplashState>(splashProvider, (previous, next) {
      if (next == SplashState.unauthenticated) {
        //Get.offAllNamed(Routes.login);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.login, (route) => false);
      } else if (next == SplashState.authenticated) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.home, (route) => false);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(splashProvider.notifier).checkToken();
    });

    return const Scaffold(
      backgroundColor: Colours.tertiaryColor,
      body: Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            strokeWidth: 6,
            color: Colours.primaryColor,
          ),
        ),
      ),
    );
  }
}

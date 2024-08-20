import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../constants/constants.dart';

class AniamtedLandingText extends StatelessWidget {
  const AniamtedLandingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FittedBox(
            child: TextAnimatorSequence(
                loop: true,
                tapToProceed: false,
                transitionTime: const Duration(seconds: 3),
                children: [
                  TextAnimator("Scrape the Web",
                      incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                        duration: const Duration(milliseconds: 150),
                      ),
                      outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(
                        duration: const Duration(milliseconds: 150),
                      ),
                      style: animationTextStyle(context)),
                  TextAnimator("Crawl the Web Data",
                      incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                        duration: const Duration(milliseconds: 150),
                      ),
                      outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(
                        duration: const Duration(milliseconds: 150),
                      ),
                      style: animationTextStyle(context)),
                  TextAnimator("Extract Content precisely",
                      incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                        duration: const Duration(milliseconds: 150),
                      ),
                      outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(
                        duration: const Duration(milliseconds: 150),
                      ),
                      style: animationTextStyle(context)),
                  TextAnimator("Harvest Data from the Web",
                      incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                        duration: const Duration(milliseconds: 150),
                      ),
                      outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(
                        duration: const Duration(milliseconds: 150),
                      ),
                      style: animationTextStyle(context)),
                  TextAnimator("Scrape easily",
                      incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                        duration: const Duration(milliseconds: 150),
                      ),
                      outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(
                        duration: const Duration(milliseconds: 150),
                      ),
                      style: animationTextStyle(context)),
                ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(text: "with", style: animationTextStyle(context)),
                TextSpan(
                    text: " ScrapeMe",
                    style: GoogleFonts.inter(
                        fontSize: 55, fontWeight: FontWeight.bold))
              ], style: animationTextStyle(context)),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle animationTextStyle(BuildContext context) {
    return GoogleFonts.ebGaramond(
      color: Colours.primaryColor,
      fontSize: 55,
      fontWeight: FontWeight.w400,
    );
  }
}

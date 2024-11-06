import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/constants/constants.dart';
import 'package:scrapeme/controllers/controllers.dart';

class GoogleLogin extends ConsumerWidget {
  const GoogleLogin({
    super.key,
    required this.onTap,
  });
  final Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authProvider).isGoogleSignInLoading;

    return GestureDetector(
      onTap: isLoading ? null : onTap, // Disable tap while loading
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical:
                isLoading ? 16 : 12), // Increase vertical padding when loading
        decoration: BoxDecoration(
          color: Colours.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              KIcons.svgGoogle,
              height: 17,
              width: 17,
            ),
            const SizedBox(width: 10),
            Text(
              "Continue with Google",
              style: GoogleFonts.inter(
                color: Colours.darkGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Show loading indicator if loading
            if (isLoading) ...[
              const SizedBox(width: 10), // Space between text and loader
              const SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: Colours.primaryColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

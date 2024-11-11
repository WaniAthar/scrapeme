import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/constants/constants.dart';

class KPrimaryButton extends StatelessWidget {
  const KPrimaryButton({super.key, required this.title, this.onPressed});
  final String title;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colours.primaryColor,
        overlayColor: Colours.backgroundColor.withOpacity(0.2),
        disabledBackgroundColor: Colours.primaryColor.withOpacity(0.2),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colours.white,
          ),
        ),
      ),
    );
  }
}

class KSecondaryButton extends StatelessWidget {
  const KSecondaryButton({super.key, this.onPressed, required this.title});
  final String title;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colours.secondaryColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colours.secondarybackgroundColor.withOpacity(0.4),
        overlayColor: Colours.secondaryColor.withOpacity(0.8),
        disabledBackgroundColor: Colours.secondaryColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colours.primaryColor,
          ),
        ),
      ),
    );
  }
}

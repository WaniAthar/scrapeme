import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import '../constants/constants.dart';

abstract class CustomToast {
  static ToastificationItem success(String message, String description) =>
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text(message,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colours.textColor)),
        description: Text(
          description,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colours.textColor),
        ),
        alignment: Alignment.topRight,
        direction: TextDirection.ltr,
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: true,
        showProgressBar: false,
      );
  static ToastificationItem error(String message, String description) =>
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text(message,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colours.textColor)),
        description: Text(
          description,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colours.textColor),
        ),
        alignment: Alignment.topRight,
        direction: TextDirection.ltr,
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: true,
        showProgressBar: false,
      );
  static ToastificationItem info(String message, String description) =>
      toastification.show(
        type: ToastificationType.info,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text(message,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colours.textColor)),
        description: Text(
          description,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colours.textColor),
        ),
        alignment: Alignment.topRight,
        direction: TextDirection.ltr,
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: true,
        showProgressBar: false,
      );
  static ToastificationItem warning(String message, String description) =>
      toastification.show(
        type: ToastificationType.warning,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text(message,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colours.textColor)),
        description: Text(
          description,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colours.textColor),
        ),
        alignment: Alignment.topRight,
        direction: TextDirection.ltr,
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: true,
        showProgressBar: false,
      );
}

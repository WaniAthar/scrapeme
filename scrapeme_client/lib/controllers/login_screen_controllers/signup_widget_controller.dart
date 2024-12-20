import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SignupPageController extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
  }
}

final signupPageControllerProvider =
    ChangeNotifierProvider<SignupPageController>(
        (ref) => SignupPageController());

class SignupValidationProvider extends ChangeNotifier {
  String? validateName(String? value) {
    if (value?.isEmpty ?? true) {
      return "Name is required";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value ?? '')) {
      return 'Invalid Email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Password is required';
    }
    if ((value?.length ?? 0) < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})')
        .hasMatch(value ?? '')) {
      return 'Password must contain at least one uppercase letter, one lowercase letter,\none number, and one special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value?.isEmpty ?? true) {
      return 'Confirm Password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}

final signupValidationProvider =
    ChangeNotifierProvider<SignupValidationProvider>(
        (ref) => SignupValidationProvider());

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final emailControllerProvider = Provider((ref) => TextEditingController());
final passwordControllerProvider = Provider((ref) => TextEditingController());

class LoginPageController extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final pageController = PageController();

  int get currentPage => pageController.page!.round();
  void forward() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void backward() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void jumpToPage(int page) {
    pageController.jumpToPage(page);
  }
}

final loginPageControllerProvider =
    ChangeNotifierProvider<LoginPageController>((ref) => LoginPageController());

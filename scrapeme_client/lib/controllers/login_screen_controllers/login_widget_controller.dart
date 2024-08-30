import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final emailControllerProvider = Provider((ref) => TextEditingController());
final passwordControllerProvider = Provider((ref) => TextEditingController());
final loginFormKeyProvider = Provider((ref) => GlobalKey<FormState>());

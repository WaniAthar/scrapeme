import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/constants/constants.dart';

class InputField extends ConsumerStatefulWidget {
  const InputField(
      {super.key,
      required this.controller,
      this.isPassword = false,
      this.hintText,
      this.labelText,
      this.icon,
      this.onTap,
      this.onChanged,
      this.validator,
      this.suffixIcon,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      required this.keyboardType,
      this.autofocus = false});
  final Function()? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final Widget? suffixIcon;
  final bool autofocus, isPassword;
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  @override
  ConsumerState<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends ConsumerState<InputField>
    with TickerProviderStateMixin {
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    if (widget.isPassword) {
      setState(() {
        isPasswordVisible = !isPasswordVisible;
      });
    }
  }

  bool visibility() {
    if (widget.isPassword) {
      return !isPasswordVisible;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: visibility(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        // contentPadding: ,
        hintStyle: GoogleFonts.inter(
            color: Colours.primaryColor.withOpacity(0.7),
            fontWeight: FontWeight.w500),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colours.primaryColor, width: 0.7),
        ),
        fillColor: Colours.secondarybackgroundColor.withOpacity(0.7),
        filled: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colours.errorColor, width: 0.7),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colours.errorColor, width: 0.7),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colours.grey, width: 0.7),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: Colours.primaryColor.withOpacity(0.6), width: 0.7),
        ),
        hintText: widget.hintText,
        labelText: widget.labelText,
        icon: widget.icon != null ? Icon(widget.icon) : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                iconSize: 20,
                onPressed: togglePasswordVisibility,
                icon: Icon(isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
                color: Colours.primaryColor,
              )
            : widget.suffixIcon,
      ),
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
    );
  }
}

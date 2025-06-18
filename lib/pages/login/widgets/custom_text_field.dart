import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

class CustomTextField extends HookWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueNotifier<bool>? obscure;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    final isObscure = obscure ?? ValueNotifier(false);

    return ValueListenableBuilder<bool>(
        valueListenable: isObscure,
        builder: (_, value, __) {
          return TextFormField(
            controller: controller,
            obscureText: isPassword ? value : false,
            keyboardType: keyboardType,
            validator: validator,
            cursorColor: Colors.deepPurple,
            style: TextStyle(color: Colors.deepPurpleAccent
            ),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.grey.shade400), // 👈 Label color
              hintStyle: TextStyle(color: Colors.deepPurpleAccent), // 👈 Hint text color
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.deepPurple, // 🎯 Dark purple border when active
                  width: 2,
                ),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                  icon: Icon(
                    value  ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => isObscure.value = !value,
              )
                  : null,
            ),
          );
        },
    );
  }
}
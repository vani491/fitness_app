import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'widgets/custom_text_field.dart';
import 'widgets/primary_button.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLoading = useState(false);
    final passwordObscure = useState(true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_background.png', // replace with your image path
              fit: BoxFit.fill,
            ),
          ),

          // Main content with safe area and padding
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "Welcome Back 👋",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // White for contrast on bg
                        ),
                      ).animate().fade().slideX(),
                      const SizedBox(height: 10),
                      Text(
                        "Login to your account",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomTextField(
                        label: "Email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: ValidationBuilder().email()
                            .required()
                            .build(),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "Password",
                        controller: passwordController,
                        isPassword: true,
                        validator: ValidationBuilder().minLength(6)
                            .required()
                            .build(),
                        obscure: passwordObscure,
                      ),
                      const SizedBox(height: 30),
                      PrimaryButton(
                        label: isLoading.value ? "Logging in..." : "Login",
                        isLoading: isLoading.value,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading.value = true;
                            await Future.delayed(2.seconds); // Simulate API
                            isLoading.value = false;
                            if (!context.mounted) return;
                            context.pushNamed('home');
                          }

                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?", style: TextStyle(
                              color: Colors.black54)),
                          TextButton(
                            onPressed: () {
                              context.pushNamed('register');
                            },
                            child: const Text("Register", style: TextStyle(
                                color: Colors.deepPurple)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

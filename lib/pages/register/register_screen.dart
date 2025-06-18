import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_validator/form_validator.dart';
import '../login/widgets/custom_text_field.dart';

class RegisterPage extends HookWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    // Obscure states
    final passwordObscure = useState(true);
    final confirmPasswordObscure = useState(true);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_background.png',
              // replace with your image path
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    color: Colors.white.withOpacity(0.9),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Create Account",
                              style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Name
                            CustomTextField(
                              label: 'Full Name',
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator:
                                  ValidationBuilder().minLength(3).build(),
                            ),
                            const SizedBox(height: 16),

                            // Email
                            CustomTextField(
                              label: 'Email',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: ValidationBuilder().email().build(),
                            ),
                            const SizedBox(height: 16),

                            // Password
                            CustomTextField(
                              label: 'Password',
                              controller: passwordController,
                              isPassword: true,
                              obscure: passwordObscure,
                              validator:
                                  ValidationBuilder().minLength(6).build(),
                            ),
                            const SizedBox(height: 16),

                            // Confirm Password
                            CustomTextField(
                              label: 'Confirm Password',
                              controller: confirmPasswordController,
                              isPassword: true,
                              obscure: confirmPasswordObscure,
                              validator: (value) {
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // Call your register API here
                                  debugPrint("✅ Registering...");
                                }
                              },
                              child: const Text("Register",
                                  style: TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account?",
                                    style: TextStyle(color: Colors.black54)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Login",
                                      style:
                                          TextStyle(color: Colors.deepPurple)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_farm_app/presentation/auth/cubit/login_cubit.dart';
import 'package:smart_farm_app/presentation/main_layout.dart';
import 'package:smart_farm_app/widgets/custom_button.dart';
import 'package:smart_farm_app/widgets/custom_textfield.dart';

import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, bool>(
      listener: (context, state) {
        if (state) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainLayout()),
          );
        }
      },

      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.25,
                child: Lottie.asset('assets/Animation.json', fit: BoxFit.cover),
              ),
            ),

            Center(
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),

                  borderRadius: BorderRadius.circular(20),

                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),

                child: Form(
                  key: formKey,

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Lottie.asset("assets/login.json", height: 200),

                        const SizedBox(height: 10),

                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        CustomTextField(
                          controller: email,
                          hint: "Email",
                          icon: Icons.email,
                          keyboard: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 10),

                        CustomTextField(
                          controller: password,
                          hint: "Password",
                          obscure: true,
                          icon: Icons.lock,
                        ),

                        const SizedBox(height: 20),

                        CustomButton(
                          text: "Login",
                          onTap: () {
                            if (!formKey.currentState!.validate()) return;

                            context.read<LoginCubit>().login(
                              email.text.trim(),
                              password.text.trim(),
                            );
                          },
                        ),

                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Text("Don't have an account? "),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterPage(),
                                  ),
                                );
                              },

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.green.shade100.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

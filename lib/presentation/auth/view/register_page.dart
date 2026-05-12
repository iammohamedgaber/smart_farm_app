import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_farm_app/data/models/register_model.dart';
import 'package:smart_farm_app/data/sources/auth_remote_source.dart';
import 'package:smart_farm_app/widgets/custom_button.dart';
import 'package:smart_farm_app/widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final auth = AuthRemoteSource();

  bool loading = false;

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    final model = RegisterModel(
      username: username.text.trim(),
      email: email.text.trim(),
      passwordHash: password.text.trim(),
    );

    await auth.register(model);

    setState(() => loading = false);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
                color: isDark
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white.withOpacity(0.5),

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
                      Lottie.asset("assets/register.json", height: 200),

                      const SizedBox(height: 10),

                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),

                      const SizedBox(height: 20),

                      CustomTextField(
                        controller: username,
                        hint: "Username",
                        icon: Icons.person,
                      ),

                      const SizedBox(height: 10),

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
                        text: "Register",
                        loading: loading,
                        onTap: register,
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
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
                                "Login",
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
    );
  }
}

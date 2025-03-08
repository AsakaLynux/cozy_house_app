import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../domain/services/user_service.dart';
import '../routing/routes.dart';
import 'core/themes/colors.dart';
import 'core/widget/custom_button.dart';
import 'core/widget/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  void passwordObscure() {
    setState(() {
      obscure ? obscure = false : obscure = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      title: "Username",
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      hintText: "AsakaLynux",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username can not be empty";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      title: "Password",
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscure: obscure,
                      suffixIcon: GestureDetector(
                          onTap: passwordObscure,
                          child: Icon(obscure ? Icons.lock : Icons.lock_open)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username can not be empty";
                        }
                        return null;
                      },
                    ),
                    CustomButton(
                      buttonText: "Login",
                      buttonWidth: 212,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final data = await UserService().userLogin(
                              usernameController.value.text,
                              passwordController.value.text);
                          final snackbar = SnackBar(content: Text(data));
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                          if (data.contains("Login Succesful")) {
                            if (context.mounted) {
                              context.go(Routes.main);
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

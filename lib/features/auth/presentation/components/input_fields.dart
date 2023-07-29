import 'package:flutter/material.dart';

enum InputFieldType { login, registration }

class InputFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? usernameController;
  final InputFieldType inputFieldType;

  const InputFields(
      {super.key,
      this.usernameController,
      required this.inputFieldType,
      required this.emailController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          if (inputFieldType == InputFieldType.registration)
            TextFormField(
              key: const Key('usernameField'),
              controller: usernameController,
              autofillHints: const [AutofillHints.username],
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              autocorrect: false,
              cursorHeight: 24,
              cursorColor: Colors.grey,
              decoration: const InputDecoration(
                labelText: "Username",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
          TextFormField(
            key: const Key('emailField'),
            controller: emailController,
            autofillHints: const [AutofillHints.email],
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            cursorHeight: 24,
            cursorColor: Colors.grey,
            decoration: const InputDecoration(
              labelText: "Email",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          TextFormField(
            key: const Key('passwordField'),
            controller: passwordController,
            autofillHints: const [AutofillHints.password],
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            cursorColor: Colors.grey,
            cursorHeight: 24,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: "Password",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              labelStyle: TextStyle(color: Colors.grey),
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum InputFieldType { email, password, username, message }

class GarboInputField extends StatelessWidget {
  final String labelText;
  final TextEditingController? inputController;
  final InputFieldType inputFieldType;

  const GarboInputField(
      {super.key,
      required this.labelText,
      required this.inputController,
      required this.inputFieldType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: inputController,
      autofillHints: inputFieldType == InputFieldType.username
          ? const [AutofillHints.username]
          : inputFieldType == InputFieldType.email
              ? const [AutofillHints.email]
              : const [AutofillHints.password],
      textInputAction: (inputFieldType == InputFieldType.password ||
              inputFieldType == InputFieldType.message)
          ? TextInputAction.done
          : TextInputAction.next,
      keyboardType: inputFieldType == InputFieldType.email
          ? TextInputType.emailAddress
          : inputFieldType == InputFieldType.username
              ? TextInputType.name
              : TextInputType.text,
      autocorrect: false,
      cursorHeight: 24,
      cursorColor: Colors.grey,
      obscureText: inputFieldType == InputFieldType.password ? true : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, preencha este campo';
        }
        if (inputFieldType == InputFieldType.email) {
          if (!value.contains('@')) {
            return 'Por favor, insira um email válido';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        labelStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}

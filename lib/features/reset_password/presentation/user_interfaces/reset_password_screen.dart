import 'package:app/core/blocs/application_state.dart';
import 'package:app/core/blocs/cubit_factory.dart';
import 'package:app/features/reset_password/presentation/business_components/cubit/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String code;
  const ResetPasswordScreen({super.key, required this.code});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ResetPasswordCubit resetPasswordCubit = CubitFactory.resetPasswordCubit;
  final TextEditingController newPasswordController = TextEditingController();

  void _onUpdatePassword() {
    final newPassword = newPasswordController.text.trim();

    // Add your password validation logic here if needed

    if (newPassword.isNotEmpty) {
      resetPasswordCubit.updatePassword(widget.code, newPassword);
      // Call the updatePassword method of the AuthUseCase
      // to update the user's password in Firebase Authentication

      // Show success message or navigate to a confirmation screen
    } else {
      // Show error message for invalid or mismatched passwords
      print('Passwords do not match or are invalid.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ApplicationState>(
      bloc: resetPasswordCubit,
      listener: (context, state) {
        // TODO: implement listener
        if (state is ResetPasswordSuccessState) {
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: BackButton(
                  color: Colors.grey,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  'Escolha uma nova senha',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text('Insira uma nova senha para sua conta',
                        style: TextStyle(color: Colors.grey, fontSize: 18)),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: const Key('passwordFieldResetPassword'),
                      controller: newPasswordController,
                      autofillHints: const [AutofillHints.password],
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.grey,
                      cursorHeight: 24,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: "Nova Senha",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () => _onUpdatePassword(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(8.0),
                          backgroundColor: Colors.cyan,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Atualizar Senha')),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:app/core/blocs/cubit_factory.dart';
import 'package:app/core/navigator/application_routes.dart';
import 'package:app/features/auth/presentation/business_components/auth_cubit.dart';
import 'package:app/features/auth/presentation/components/button.dart';
import 'package:app/features/auth/presentation/components/header.dart';
import 'package:app/features/auth/presentation/components/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final authCubit = CubitFactory.authCubit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AuthCubit, AuthStatus>(
          bloc: authCubit,
          listener: (context, state) {
            // Listen to state changes here, and perform navigation
            // or show snackbar based on authentication status.
            if (state == AuthStatus.registered) {
              // Navigate to the next screen after successful authentication.
              // Example: return HomePage();
              _navigateToLoginScreen();
            }
          },
          builder: (context, state) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.cyan,
                    Colors.red,
                    Colors.yellow,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Header(),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: InputFields(
                              inputFieldType: InputFieldType.registration,
                              usernameController: usernameController,
                              emailController: emailController,
                              passwordController: passwordController,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Button(
                            onPressed: () => _signIn(),
                            text: 'Registar',
                            isLoading: state == AuthStatus.registering,
                          ),
                          TextButton(
                            onPressed: () => _navigateToLoginScreen(),
                            child: const Text(
                              'Já possui uma conta? Clique aqui!',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _signIn() {
    authCubit.registerWithEmailAndPassword(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  void _navigateToLoginScreen() {
    Navigator.of(context).pop();
  }
}

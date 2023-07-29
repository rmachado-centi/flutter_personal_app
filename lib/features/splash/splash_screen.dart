import 'package:app/core/blocs/cubit_factory.dart';
import 'package:app/core/navigator/application_routes.dart';
import 'package:app/features/auth/presentation/business_components/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authCubit = CubitFactory.authCubit;

  @override
  void initState() {
    authCubit.checkAuthentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStatus>(
      bloc: authCubit,
      listener: (context, state) {
        if (state == AuthStatus.authenticated) {
          // User is authenticated, navigate to the home screen
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context)
                .pushReplacementNamed(ApplicationRoutes.homeScreen);
          });
        } else {
          // User is not authenticated, navigate to the login screen
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context)
                .pushReplacementNamed(ApplicationRoutes.authScreen);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white, // Set your desired background color
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Garbo',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

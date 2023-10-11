import 'dart:async';
import 'dart:developer';

import 'package:app/core/blocs/cubit_factory.dart';
import 'package:app/core/constants/application_constants.dart';
import 'package:app/core/navigator/application_routes.dart';
import 'package:app/features/auth/presentation/business_components/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authCubit = CubitFactory.authCubit;

  StreamSubscription<Map>? _branchSub;

  @override
  void initState() {
    authCubit.checkAuthentication();
    listenBranchSDKLinks();
    super.initState();
  }

  @override
  void dispose() {
    _branchSub?.cancel();
    super.dispose();
  }

  void listenBranchSDKLinks() async {
    _branchSub = FlutterBranchSdk.initSession().listen((data) {
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        // This code will execute when a Branch link is clicked
        // Retrieve the link params from 'data' and navigate to the right page
        // Example: Navigator.of(context).pushNamed(data['\$deeplink_path']);
        if (data.containsKey('\$deeplink_path')) {
          if (data['\$deeplink_path'] == branchIOResetPasswordKey &&
              data.containsKey('oobCode')) {
            Navigator.of(context).pushNamed(
                ApplicationRoutes.resetPasswordScreen,
                arguments: data['oobCode']);
          }
        }
        log('Branch link clicked');
      }
    }, onError: (error, stacktrace) {
      log('Branch error: $error');
    });
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
      child: const Scaffold(
        backgroundColor: Colors.white, // Set your desired background color
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

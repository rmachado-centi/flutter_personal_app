import 'package:app/core/blocs/application_cubit_observer.dart';
import 'package:app/core/navigator/router_navigator.dart';
import 'package:app/features/auth/presentation/user_interfaces/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = ApplicationCubitObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garbo',
      theme: ThemeData(
          fontFamily: GoogleFonts.getFont('Libre Baskerville').fontFamily,
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyText2: TextStyle(
              color: Colors.black54,
            ),
          )),
      home: const AuthScreen(),
      navigatorKey: RouterNavigator.navigatorKey,
      navigatorObservers: [RouterNavigator.routeObserver],
      onGenerateRoute: RouterNavigator.generateRoute,
    );
  }
}

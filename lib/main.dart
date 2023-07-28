import 'package:app/navigator/router_navigator.dart';
import 'package:app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
      home: const HomeScreen(),
      navigatorKey: RouterNavigator.navigatorKey,
      navigatorObservers: [RouterNavigator.routeObserver],
      onGenerateRoute: RouterNavigator.generateRoute,
    );
  }
}

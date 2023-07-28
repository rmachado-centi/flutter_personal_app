import 'package:app/navigator/application_routes.dart';
import 'package:app/screens/about_us/about_us_screen.dart';
import 'package:app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class RouterNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static final RouteObserver<ModalRoute> routeObserver =
      RouteObserver<ModalRoute>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case ApplicationRoutes.aboutUsScreen:
        return MaterialPageRoute(
          builder: (_) => const AboutUsScreen(),
          settings: settings,
        );

      case ApplicationRoutes.contactsScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
    }
  }
}

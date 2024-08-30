import 'package:flutter/material.dart';
import 'package:scrapeme/views/views.dart';

 class Routes {
  static const String login = '/';
  static const String home = '/home';
  static const String setting = '/setting';
  static const String about = '/about';
  static const String profile = '/profile';
  static const String signup = '/signup';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen(),);
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/setting':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }

   static Map<String, WidgetBuilder> get routes => {
        '/': (_) => const LoginScreen(),
        '/home': (_) => HomeScreen(),
        '/setting': (_) => SettingsScreen(),
        '/about': (_) => AboutScreen(),
        '/profile': (_) => ProfileScreen(),
        '/signup': (_) => SignupScreen(),
      };
}

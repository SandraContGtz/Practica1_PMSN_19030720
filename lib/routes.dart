import 'package:flutter/material.dart';
import 'package:psmna10/screens/Register_screen.dart';
import 'package:psmna10/screens/dashboard_screen.dart';
import 'package:psmna10/screens/login_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/login': (BuildContext context) => const LoginScreen(),
  };
}

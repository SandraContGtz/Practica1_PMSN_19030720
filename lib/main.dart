import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/provider/color_provider.dart';
import 'package:psmna10/provider/flags_provider.dart';
import 'package:psmna10/provider/theme_provider.dart';
import 'package:psmna10/routes.dart';
import 'package:psmna10/screens/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  final tema = sharedPreferences.getInt('tema') ?? 0;
  final colorApp = sharedPreferences.getString('Color') ?? '';
  runApp(MyApp(tema: tema, colorApp: colorApp));
}

class MyApp extends StatelessWidget {
  final int tema;
  final String colorApp;
  const MyApp({super.key, required this.tema, required this.colorApp});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(tema, context)),
        ChangeNotifierProvider(create: (_) => FlagsProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider(colorApp, context)),
      ],
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: theme.getthemeData(),
      routes: getApplicationRoutes(),
      //home: LoginScreen(),
      home: OnboardingPage(),
    );
  }
}

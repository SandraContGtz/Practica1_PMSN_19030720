import 'package:flutter/material.dart';
import 'package:psmna10/screens/Register_screen.dart';
import 'package:psmna10/screens/add_post_screen.dart';
import 'package:psmna10/screens/dashboard_screen.dart';
import 'package:psmna10/screens/events_list_screen.dart';
import 'package:psmna10/screens/events_screen.dart';
import 'package:psmna10/screens/list_popular_videos.dart';
import 'package:psmna10/screens/list_events.dart';
import 'package:psmna10/screens/login_screen.dart';
import 'package:psmna10/screens/theme_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/theme': (BuildContext context) => const ThemeChoose(),
    '/add': (BuildContext context) => AddPostScreen(),
    '/popular': (BuildContext context) => const ListPopularVideos(),
    '/events': (BuildContext context) => CalendarEvents(),
    '/eventsList': (BuildContext context) => const EventList(),
  };
}

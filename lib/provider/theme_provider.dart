import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:psmna10/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;

  ThemeProvider(int tema, BuildContext context) {
    setthemeData(tema, context);
    //_themeData = StylesSettings.lightTheme(context);
  }
  getthemeData() => this._themeData;
  setthemeData(int? caso, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (caso) {
      case 1:
        _themeData = StylesSettings.darkTheme(context);
        sharedPreferences.setInt('tema', 1);
        await sharedPreferences.setBool('is_dark', true);
        break;
      case 2:
        _themeData = StylesSettings.lightTheme(context);
        sharedPreferences.setInt('tema', 2);
        await sharedPreferences.setBool('is_light', true);
        break;
      default:
        _themeData = StylesSettings.lightTheme(context);
        sharedPreferences.setInt('tema', 2);
        await sharedPreferences.setBool('is_light', false);
        break;
    }
    notifyListeners();
  }
}

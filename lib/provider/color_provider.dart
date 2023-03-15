import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:psmna10/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorProvider with ChangeNotifier {
  Color? _ColorBar;
  ColorProvider(String appColor, BuildContext context) {
    setColorBar(appColor, context);
    //_themeData = StylesSettings.lightTheme(context);
  }
  getColorBar() => this._ColorBar;
  setColorBar(String? appColor, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (appColor) {
      case 'green':
        _ColorBar = Colors.green;
        sharedPreferences.setString('Color', 'green');
        break;
      case 'red':
        _ColorBar = Colors.red;
        sharedPreferences.setString('Color', 'red');
        break;
      case 'pink':
        _ColorBar = Colors.pink;
        sharedPreferences.setString('Color', 'pink');
        break;
      case 'yellow':
        _ColorBar = Colors.yellow;
        sharedPreferences.setString('Color', 'yellow');
        break;
      case 'blue':
        _ColorBar = Colors.blue;
        sharedPreferences.setString('Color', 'blue');
        break;
      case 'purple':
        _ColorBar = Colors.purple;
        sharedPreferences.setString('Color', 'purple');
        break;
      default:
        _ColorBar = Color.fromARGB(124, 68, 137, 255);
        sharedPreferences.setString('Color', 'blueAccent');
        break;
    }
    notifyListeners();
  }

  /*ColorProvider(String appcolor) {
    switch (appcolor) {
      case 'gree':
        _currentColor = Colors.green;
        break;
      case 'red':
        _currentColor = Colors.red;
        break;
      case 'pink':
        _currentColor = Colors.pink;
        break;
      case 'yellow':
        _currentColor = Colors.yellow;
        break;
      case 'blue':
        _currentColor = Colors.blue;
        break;
      case 'purple':
        _currentColor = Colors.purple;
        break;
      default:
        _currentColor = Color.fromARGB(124, 68, 137, 255);
        break;
    }
  }*/

  /*toggleColor(appColor) async {
    Color? _currentColor; //= Color.fromARGB(124, 68, 137, 255);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    /*if (_currentTheme == StylesApp.darkTheme()) {
      _currentTheme = ThemeData.dark();
      sharedPreferences.setString('theme', 'dark');
    } else {
      if (_currentTheme == StylesApp.lightTheme()) {
        _currentTheme = StylesApp.lightTheme();
        sharedPreferences.setString('theme', 'obscure');
      }
    }*/
    switch (appColor) {
      case 'green':
        _currentColor = Colors.green;
        sharedPreferences.setString('Color', 'green');
        break;
      case 'red':
        _currentColor = Colors.red;
        sharedPreferences.setString('Color', 'red');
        break;
      case 'pink':
        _currentColor = Colors.pink;
        sharedPreferences.setString('Color', 'pink');
        break;
      case 'yellow':
        _currentColor = Colors.yellow;
        sharedPreferences.setString('Color', 'yellow');
        break;
      case 'blue':
        _currentColor = Colors.blue;
        sharedPreferences.setString('Color', 'blue');
        break;
      case 'purple':
        _currentColor = Colors.purple;
        sharedPreferences.setString('Color', 'purple');
        break;
      default:
        _currentColor = Color.fromARGB(124, 68, 137, 255);
        sharedPreferences.setString('Color', 'blueAccent');
        break;
    }
    return _currentColor;
    notifyListeners();
  }*/
}

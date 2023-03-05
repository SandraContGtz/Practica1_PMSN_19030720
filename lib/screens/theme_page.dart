import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/provider/theme_provider.dart';

//import 'package:psmna10/screens/theme_provider.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:psmna10/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChoose extends StatefulWidget {
  const ThemeChoose({super.key});

  @override
  State<ThemeChoose> createState() => _ThemeChooseState();
}

/*void colorper(colores) {
  final settings = Provider.of<ThemeProvider>(context, listen: false);
  settings.colorper(colores);
}*/

class _ThemeChooseState extends State<ThemeChoose> {
  Color? colores;
  //final prefs = await  SharedPreferences.getInstance();
  //SharedPreferences sharedPreferences =  SharedPreferences.getInstance() as SharedPreferences;
  final texto = const Text(
    "Elige un tema",
    style: TextStyle(
      backgroundColor: Color.fromARGB(123, 223, 187, 80),
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );

  final spaceHorizont = const SizedBox(height: 20);
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    //final prefs = await  SharedPreferences.getInstance();
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    //Color colores;

    final btndark = TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 78, 77, 77),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () {
        theme.setthemeData(1, context);
      },
      child: const Text("Dark Theme"),
    );
    final btnlight = TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 244, 243, 224),
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        padding: const EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () {
        theme.setthemeData(2, context);
      },
      child: const Text("Light Theme"),
    );
    final btnGreen = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.green),
      child: const Icon(
        Icons.edit,
        size: 30,
      ),
      onPressed: () {
        colorper('green');
      },
    );
    final btnRed = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.red),
      child: const Icon(
        Icons.edit,
        size: 30,
      ),
      onPressed: () {
        colorper('red');
      },
    );
    final btnYellow = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.yellow),
      child: const Icon(
        Icons.edit,
        size: 30,
      ),
      onPressed: () {
        colorper('yellow');
      },
    );
    final btnPink = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.pink),
      child: const Icon(
        Icons.edit,
        size: 30,
      ),
      onPressed: () {
        colorper('pink');
      },
    );
    final btnPurple = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.purple),
      child: const Icon(
        Icons.edit,
        size: 30,
      ),
      onPressed: () {
        colorper('purple');
      },
    );
    final btnBlue = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.blue),
      child: const Icon(
        Icons.edit,
        size: 30,
      ),
      onPressed: () {
        colorper('blue');
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Theme'),
        backgroundColor: colores, //Color.fromARGB(255, 246, 148, 171),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            texto,
            spaceHorizont,
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.max
                  children: [
                    btndark,
                    btnlight,
                  ],
                )),
            spaceHorizont,
            const Text(
              "Selecciona un color",
              style: TextStyle(
                backgroundColor: Color.fromARGB(123, 223, 187, 80),
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            spaceHorizont,
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.max
                  children: [
                    btnGreen,
                    btnBlue,
                    btnRed,
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.max
                  children: [
                    btnPink,
                    btnPurple,
                    btnYellow,
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /*void Theme(theme) async {
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
    switch (theme) {
      case 'green':
        _currentTheme = ThemeData.dark();
        sharedPreferences.setString('theme', 'dark');
        break;
      case 'light':
        _currentTheme = ThemeData.light();
        sharedPreferences.setString('theme', 'light');
        break;
      case 'obscure':
        _currentTheme = StylesApp.obscureTheme();
        sharedPreferences.setString('theme', 'obscure');
        break;
      default:
        _currentTheme = StylesApp.darkTheme();
        sharedPreferences.setString('theme', 'dark');
        break;
    }*/
  void colorper(String colors) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (colors) {
      case 'green':
        colores = Colors.green;
        sharedPreferences.setString('colors', 'green');
        break;
      case 'red':
        colores = Colors.red;
        sharedPreferences.setString('colors', 'red');
        break;
      case 'yellow':
        colores = Colors.yellow;
        sharedPreferences.setString('colors', 'yellow');
        break;
      case 'pink':
        colores = Colors.pink;
        sharedPreferences.setString('colors', 'pink');
        break;
      case 'purple':
        colores = Colors.purple;
        sharedPreferences.setString('colors', 'purple');
        break;
      case 'blue':
        colores = Colors.blue;
        sharedPreferences.setString('colors', 'blue');
        break;
      default:
        colores = Color.fromARGB(255, 56, 55, 55);
        sharedPreferences.setString('colors', 'def');
        break;
    }
  }
}

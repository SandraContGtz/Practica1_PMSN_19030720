import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/provider/theme_provider.dart';
import 'package:psmna10/provider/color_provider.dart';

//import 'package:psmna10/screens/theme_provider.dart';
//import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:psmna10/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChoose extends StatefulWidget {
  const ThemeChoose({super.key});

  @override
  State<ThemeChoose> createState() => _ThemeChooseState();
}

class _ThemeChooseState extends State<ThemeChoose> {
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
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    ColorProvider colorApp = Provider.of<ColorProvider>(context);
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
        colorApp.setColorBar('green', context);
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
        colorApp.setColorBar('red', context);
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
        colorApp.setColorBar('yellow', context);
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
        colorApp.setColorBar('pink', context);
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
        colorApp.setColorBar('purple', context);
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
        colorApp.setColorBar('blue', context);
      },
    );

    return Scaffold(
      appBar: AppBar(
          title: const Text('Choose Theme'),
          backgroundColor: colorApp.getColorBar()),
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
}

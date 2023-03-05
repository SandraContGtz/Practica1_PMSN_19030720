import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/provider/theme_provider.dart';
import 'package:psmna10/screens/theme_page.dart';
import 'package:psmna10/settings/styles_settings.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;

  ///var colores = ThemeChoose().

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Social TEC'),
        //backgroundColor: colores,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://static.wikia.nocookie.net/liga-mx/images/1/11/LTClogoant.png/revision/latest?cb=20200826190754&path-prefix=es'),
                ),
                accountName: Text('Sandra Contreras'),
                accountEmail: Text('19030720@itcelaya.edu.mx')),
            ListTile(
              onTap: () {},
              title: const Text('Práctica 1'),
              subtitle: const Text('Descripción de la práctica'),
              leading: const Icon(Icons.settings),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/theme');
              },
              title: const Text('Temas'),
              subtitle: const Text('Preferencias del tema'),
              leading: const Icon(Icons.settings_accessibility_rounded),
              trailing: const Icon(Icons.chevron_right),
            ),
            /*DayNightSwitcher(
                isDarkModeEnabled: isDarkModeEnabled,
                onStateChanged: (isDarkModeEnabled) {
                  isDarkModeEnabled
                      ? theme.setthemeData(StylesSettings.darkTheme(context))
                      : theme.setthemeData(StylesSettings.lightTheme(context));
                  this.isDarkModeEnabled = isDarkModeEnabled;
                  setState(() {});
                }),*/
          ],
        ),
      ),
    );
  }

  /*void colorper(String colors) async {
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
  }*/
}

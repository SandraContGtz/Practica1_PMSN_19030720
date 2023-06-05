import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/firebase/email_auth.dart';
import 'package:psmna10/firebase/facebook_firebase.dart';
import 'package:psmna10/firebase/google_auth.dart';
import 'package:psmna10/provider/color_provider.dart';
import 'package:psmna10/provider/theme_provider.dart';
import 'package:psmna10/screens/list_favorites_cloud.dart';
import 'package:psmna10/screens/list_post.dart';
import 'package:psmna10/screens/theme_page.dart';
import 'package:psmna10/settings/styles_settings.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;
  FaceAuth faceAuth= FaceAuth();
  EmailAuth emailAuth= EmailAuth();
  GoogleAuth googleAuth=GoogleAuth();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> imageChange = ValueNotifier<bool>(false);
    ColorProvider colorApp = Provider.of<ColorProvider>(context);
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Social TEC'),
        backgroundColor: colorApp.getColorBar(),
      ),
      body: const ListFavoritesCloud(), //ListPost(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((value) {
            setState(() {});
          });
        },
        label: const Text('Add Post'),
        icon: const Icon(Icons.add_comment),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ValueListenableBuilder(
              valueListenable: imageChange,
              builder: (context, value, child) {
              return UserAccountsDrawerHeader(
                
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 102, 24, 81)
                        //Color(colors/*colorApp.getColorBar()*/),
                        ),
                currentAccountPicture: CircleAvatar(
                  
                  backgroundImage: FirebaseAuth.instance.currentUser!.photoURL !=null//user?.photoUrl != null
                    ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)//CachedNetworkImage(imageUrl: FirebaseAuth.instance.currentUser!.photoURL!)as ImageProvider
                    : AssetImage('assets/images/avatar.png') as ImageProvider,
                  /*? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                  : AssetImage('assets/avatar.png') as ImageProvider,*/
                ),
               accountName: Text(FirebaseAuth.instance.currentUser!.displayName!),//Text(_credentials),//Text(user!.name.toString()),
                accountEmail:Text(FirebaseAuth.instance.currentUser!.email!));}),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/edit');
              },
              title: Text('Edit Profile'),
              subtitle: Text('Configuración del perfil'),
              leading: Icon(Icons.edit),
              trailing: Icon(Icons.chevron_right),
            ),
            
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
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/popular');
              },
              title: const Text('API video'),
              leading: const Icon(Icons.movie),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/events');
              },
              title: const Text('Eventos'),
              leading: const Icon(Icons.calendar_month),
              trailing: const Icon(
                Icons.chevron_right,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/marvel');
              },
              title: const Text('API Marvel'),
              leading: const Icon(Icons.api),
              trailing: const Icon(
                Icons.chevron_right,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
              title: const Text('Mapas'),
              leading: const Icon(Icons.map),
              trailing: const Icon(
                Icons.chevron_right,
              ),
            ),
            ListTile(
              onTap: () {
                emailAuth.signOut();
                faceAuth.signOut();
                googleAuth.signOutWithGoogle();
                Navigator.pushNamed(context, '/login');
              },
              title: const Text('LogOut'),
              leading: const Icon(Icons.logout),
              trailing: const Icon(
                Icons.chevron_right,
              ),
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
}

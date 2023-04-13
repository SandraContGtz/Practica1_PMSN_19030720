import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/database/database_helper.dart';
import 'package:psmna10/models/post_model.dart';
import 'package:psmna10/provider/color_provider.dart';
import 'package:psmna10/provider/flags_provider.dart';
import 'package:sqflite/sqflite.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  DatabaseHelper database = DatabaseHelper();
  PostModel? objPostmodel;

  @override
  Widget build(BuildContext context) {
    ColorProvider colorApp = Provider.of<ColorProvider>(context);
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    final txtConsPost = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      objPostmodel = ModalRoute.of(context)!.settings.arguments as PostModel;
      txtConsPost.text = objPostmodel!.dscPost!;
    }
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          height: 350,
          decoration: BoxDecoration(
              color: Colors.green, border: Border.all(color: Colors.black)),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              objPostmodel == null
                  ? const Text('Add Post')
                  : const Text('Update Post :)'),
              TextFormField(
                controller: txtConsPost,
                maxLines: 8,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorApp.getColorBar(),
                    //Color.fromARGB(255, 246, 148, 171),
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    if (objPostmodel == null) {
                      database.INSERT('tblPost', {
                        'dscPost': txtConsPost.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msj = value > 0
                            ? 'Registro insertado'
                            : 'Ocurrió un error';
                        var snackBar = SnackBar(content: Text(msj));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    } else {
                      database.UPDATE('tblPost', {
                        'idPost': objPostmodel!.idPost,
                        'dscPost': txtConsPost.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msj = value > 0
                            ? 'Registro actualizado'
                            : 'Ocurrió un error';
                        var snackBar = SnackBar(content: Text(msj));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                    flag.setFlagListPost(true);
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}

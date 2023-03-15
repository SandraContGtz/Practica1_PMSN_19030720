import 'package:flutter/material.dart';
import 'package:psmna10/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final txtConsPost = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          height: 350,
          decoration: BoxDecoration(
              color: Colors.green, border: Border.all(color: Colors.black)),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add Post'),
              TextFormField(
                controller: txtConsPost,
                maxLines: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    database.INSERT('tblPost', {
                      'dscPost': txtConsPost.text,
                      'datePost': DateTime.now().toString()
                    }).then((value) {
                      var msj =
                          value > 0 ? 'Registro insertado' : 'Ocurrió un error';
                      var snackBar = SnackBar(content: Text(msj));

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}

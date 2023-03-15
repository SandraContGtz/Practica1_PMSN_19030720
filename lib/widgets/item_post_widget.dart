import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/database/database_helper.dart';

import '../models/post_model.dart';
import '../provider/flags_provider.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.objPostModel});

  PostModel? objPostModel;
  DatabaseHelper database = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      backgroundImage: AssetImage('assets/itce.png'),
    );
    final txtUser = Text('Sandra ');
    final datePost = Text('06-03-2023');
    final imgPost = Image(
      image: AssetImage('assets/fondo.jpg'),
      height: 100,
    );
    final txtDesc = Text('Descripción del texto');
    final iconRate = Icon(Icons.rate_review);

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Container(
      margin: EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      child: Column(
        children: [
          Row(
            children: [avatar, txtUser, datePost],
          ),
          Row(
            children: [imgPost, txtDesc],
          ),
          Row(
            children: [
              iconRate,
              Expanded(child: Container()),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirmar borrado'),
                        content: const Text('Deseas borrar el post?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                database
                                    .DELETE('tblPost', objPostModel!.idPost!)
                                    .then(
                                        (value) => flag.setFlagListPost(true));
                                Navigator.pop(context);
                              },
                              child: const Text('Ok')),
                          TextButton(onPressed: () {}, child: const Text('No'))
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}

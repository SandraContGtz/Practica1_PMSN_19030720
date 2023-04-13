import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/provider/color_provider.dart';

import '../database/database_helper.dart';
import '../models/event.dart';
import '../provider/flags_provider.dart';

class EventItemWidget extends StatelessWidget {
  EventItemWidget({Key? key, this.objEvent}) : super(key: key);

  Event? objEvent;

  final DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final txtDesc = Text(objEvent!.dscEvento!);
    final txttitle = Text(objEvent!.titlEvento!);
    final dateEvent = Text(objEvent!.fechaEvento!.toString());

    final txtPostController = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      objEvent = ModalRoute.of(context)!.settings.arguments as Event;
      txtPostController.text = objEvent!.dscEvento!;
    }

    final txttittleController = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      objEvent = ModalRoute.of(context)!.settings.arguments as Event;
      txtPostController.text = objEvent!.titlEvento!;
    }

    final FlagsProvider flag = Provider.of<FlagsProvider>(context);
    ColorProvider colorApp = Provider.of<ColorProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorApp.getColorBar() //Color.fromARGB(255, 204, 153, 210),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          txttitle,
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    txtDesc,
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              dateEvent,
              Expanded(child: Container()),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Actualiza la Tarea'),
                      content: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            TextField(
                              controller: txttittleController,
                              decoration: InputDecoration(labelText: 'Title'),
                            ),
                            TextField(
                              controller: txtPostController,
                              decoration:
                                  InputDecoration(labelText: 'Description'),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            database.UPDATE_EVENT({
                              'idEvento': objEvent!.idEvento,
                              'titlEvento': txttittleController.text,
                              'dscEvento': txtPostController.text,
                            }).then((value) {
                              var msg =
                                  value > 0 ? 'Registro actualizado' : 'Error';
                              var snackBar = SnackBar(content: Text(msg));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              flag.setFlagListPost(true);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('¿Estás seguro de borrar el evento?'),
                      //content: const Text('Se borrara la tarea seleccionado'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            database
                                .DELETE_EVENT(objEvent!.idEvento!)
                                .then((value) => flag.setFlagListPost(true));
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              )
            ],
          )
        ],
      ),
    );
  }
}

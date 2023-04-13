import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/provider/flags_provider.dart';
import 'package:psmna10/widgets/item_post_widget.dart';
import 'package:psmna10/widgets/item_event_widget.dart';
import '../database/database_helper.dart';
import '../models/event.dart';

class ListEvents extends StatefulWidget {
  const ListEvents({super.key});

  @override
  State<ListEvents> createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {
  DatabaseHelper? database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    flag.getflagListPost();
    return FutureBuilder(
        future: flag.getflagListPost() == true
            ? database?.GET_ALL_EVENTS()
            : database!.GET_ALL_EVENTS(),
        builder: (context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var objEvent = snapshot.data![index];
                  return EventItemWidget(
                    objEvent: objEvent,
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Ocurrió un error"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

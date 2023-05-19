import 'package:flutter/material.dart';
import 'package:psmna10/firebase/favorites_firebase.dart';

class ListFavoritesCloud extends StatefulWidget {
  const ListFavoritesCloud({super.key});

  @override
  State<ListFavoritesCloud> createState() => _ListFavoritesCloudState();
}

class _ListFavoritesCloudState extends State<ListFavoritesCloud> {
  FavoritesFirebase _firebase = FavoritesFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firebase.getAllFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Container(
                    child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(snapshot.data!.docs[index].get('title')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              /*_firebase.insFavorite({
                                'title': snapshot.data!.docs[index].get('title')
                              });*/
                            },
                            icon: const Icon(Icons.favorite)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirmar borrado'),
                                  content:
                                      const Text('Deseas borrar de favoritos?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          _firebase.delFavorite(
                                              snapshot.data!.docs[index].id);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Sí')),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text('No'))
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    )
                  ],
                ));
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Errore en la petición, intente de nuevo'));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

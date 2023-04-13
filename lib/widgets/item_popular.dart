import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/database/database_helper.dart';
import 'package:psmna10/models/popular_model.dart';
import 'package:psmna10/provider/flags_provider.dart';

class ItemPopular extends StatefulWidget {
  ItemPopular({super.key, required this.popularModel});
  PopularModel popularModel;

  @override
  State<ItemPopular> createState() => _ItemPopularState();
}

class _ItemPopularState extends State<ItemPopular> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return ListView(
      children: [
        Stack(
          children: [
            FadeInImage(
              fit: BoxFit.fill,
              placeholder: const AssetImage('assets/loading1.gif'),
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${widget.popularModel.posterPath}'),
            ),
            FutureBuilder(
                future: databaseHelper.searchPopular(widget.popularModel.id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return IconButton(
                      icon: Icon(Icons.favorite),
                      color: snapshot.data != true ? Colors.white : Colors.red,
                      onPressed: () {
                        if (snapshot.data != true) {
                          databaseHelper
                              .INSERT_FAVMOV(
                                  'tblFavMovie', widget.popularModel!.toMap())
                              .then((value) => flag.setFlagListPost(true));
                        } else {
                          databaseHelper
                              .DELETE_FAVMOV(
                                  'tblFavMovie', widget.popularModel.id!, 'id')
                              .then((value) => flag.setFlagListPost(true));
                        }
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            /*Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //border: Border.all(color: Colors.grey),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: AssetImage('assets/loading1.gif'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${widget.popularModel.posterPath}'),
                ),
              ),
            ),*/
            /*Positioned(
              /*top: 0.0,
              right: 20,*/
              child: FutureBuilder(
                  future: databaseHelper.searchPopular(widget.popularModel.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        icon: Icon(Icons.favorite),
                        color: snapshot.data != true ? Colors.white : Colors.red,
                        onPressed: () {
                          if (snapshot.data != true) {
                            databaseHelper.INSERTg(
                                    'tblPopularFav', widget.popularModel!.toMap())
                                .then((value) => flag.setFlagListPost(true));
                          } else {
                            databaseHelper.DELETEg(
                                    'tblPopularFav', widget.popularModel.id!, 'id')
                                .then((value) => flag.setFlagListPost(true));
                          }
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],*/

            /*return FadeInImage(
          fit: BoxFit.fill,
          placeholder: const AssetImage('assets/loading1.gif'),
          image: NetworkImage(
              'https://image.tmdb.org/t/p/w500/${widget.popularModel.posterPath}'),
          
        );*/
          ],
        ),
      ],
    );
  }
}

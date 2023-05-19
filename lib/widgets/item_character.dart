import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/database/database_helper.dart';
import 'package:psmna10/models/marvel_model.dart';
import 'package:psmna10/network/api_marvel.dart';
import 'package:psmna10/provider/flags_provider.dart';

class ItemCharacter extends StatefulWidget {
  ItemCharacter({
    super.key,
    required this.characterModel,
  });
  CharacterModel characterModel;

  @override
  State<ItemCharacter> createState() => _ItemCharacterState();
}

class _ItemCharacterState extends State<ItemCharacter> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  //ApiMarvel api = ApiMarvel();
  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return FadeInImage(
      fit: BoxFit.fill,
      placeholder: const AssetImage('assets/loading1.gif'),
      image: NetworkImage('${widget.characterModel.thumbnail}'),
    );
    /*FutureBuilder(
                future: databaseHelper.searchPopular(widget.characterModel.id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return IconButton(
                      icon: Icon(Icons.favorite),
                      color: snapshot.data != true ? Colors.white : Colors.red,
                      onPressed: () {
                        if (snapshot.data != true) {
                          databaseHelper
                              .INSERT_FAVMOV(
                                  'tblFavMovie', widget.characterModel!.toMap())
                              .then((value) => flag.setFlagListPost(true));
                        } else {
                          databaseHelper
                              .DELETE_FAVMOV(
                                  'tblFavMovie', widget.characterModel.id!, 'id')
                              .then((value) => flag.setFlagListPost(true));
                        }
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),*/
    /* ],
        ),
      ],
    );*/
  }
}

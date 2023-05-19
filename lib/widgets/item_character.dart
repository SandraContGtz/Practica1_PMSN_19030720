import 'package:flutter/material.dart';
import 'package:psmna10/constants.dart';

class CharacterCard extends StatelessWidget {
  final String name;
  final String description;
  final String thumbnailUrl;

  CharacterCard({
    required this.name,
    required this.description,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: kRedDark,
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: "SyneTactile",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(25)),
                    gradient: LinearGradient(
                      colors: [
                        kRedSelected,
                        kRedSelected.withOpacity(0.8),
                        kRedSelected.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
              ),
            ],
          ),
          Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              height: MediaQuery.of(context).size.height / 5,
              // color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              alignment: Alignment.bottomCenter,
              child: Text(
                  description.isEmpty || description == " "
                      ? "Description not available"
                      : description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(25)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )),
            ),
          ]),
        ],
      ),
    );
  }
}




/*import 'package:flutter/material.dart';
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
}*/

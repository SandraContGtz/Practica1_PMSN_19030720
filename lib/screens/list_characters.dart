/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/database/database_helper.dart';
import 'package:psmna10/network/api_marvel.dart';
import 'package:psmna10/network/api_popular.dart';
import 'package:psmna10/provider/color_provider.dart';
import 'package:psmna10/provider/flags_provider.dart';
import 'package:psmna10/screens/movie_detail_screen.dart';
import 'package:psmna10/widgets/item_character.dart';
import 'package:psmna10/widgets/item_popular.dart';

import '../models/marvel_model.dart';

class ListCharacters extends StatefulWidget {
  const ListCharacters({super.key});

  @override
  State<ListCharacters> createState() => _ListCharactersState();
}

class _ListCharactersState extends State<ListCharacters> {
  ApiMarvel? apiPopular;
  bool isFavoriteView = false;
  DatabaseHelper? database;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiMarvel();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colorApp = Provider.of<ColorProvider>(context);
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorApp.getColorBar(),
        title: const Text('List Marvel'),
        actions: [
          IconButton(
            icon: isFavoriteView != true
                ? Icon(Icons.favorite_outline_outlined)
                : Icon(Icons.list_alt),
            onPressed: () {
              setState(() {
                isFavoriteView = !isFavoriteView;
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: apiPopular!.getAllCharacters(),
          builder: (context, AsyncSnapshot<List<CharacterModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                  itemBuilder: (context, index) {
                    return ItemCharacter(characterModel: snapshot.data![index]);
                  });
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Ocurrió un error'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
      /*body:FutureBuilder(
          future: flag.getflagListPost() == true
              ? isFavoriteView
                  ? database!.getAllPopular()
                  : apiPopular!.getAllCharacters()
              : isFavoriteView
                  ? database!.getAllPopular()
                  : apiPopular!.getAllCharacters(),
          builder: (context, AsyncSnapshot<List<CharacterModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  CharacterModel objPopularModel = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => MovieDetail(
                            objPopularModel: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: snapshot.data![index].id!,
                      child: ItemPopular(popularModel: snapshot.data![index]),
                    ),
                  );
                  //return ItemPopular(popularModel: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('OCURRIO UN ERROR' + snapshot.error.toString()),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),*/
    );
  }
}



/*
body: FutureBuilder(
          future: apiPopular!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                  itemBuilder: (context, index) {
                    return ItemPopular(popularModel: snapshot.data![index]);
                  });
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Ocurrió un error'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
*/
*/




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:psmna10/constants.dart';
import 'package:psmna10/models/marvel_model.dart';
import 'package:psmna10/widgets/item_character.dart';
import '../keys.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}


class _CharactersScreenState extends State<CharactersScreen> {
  late String charactersUrl;
  List<CharacterModel> charactersList = [];
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getMarvelCharacters(k50CharactersUrl);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: Scaffold(
        appBar: AppBar(
        title: Text('Marvel'),
        backgroundColor: Colors.red,
      ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,  // removes emojis
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 18),
                  controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        color: kLavender,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search_rounded),
                        color: kLavender,
                        onPressed: (){
                          if(searchController.text.trim().isNotEmpty) {
                            charactersUrl = k50CharactersUrl +
                                "&nameStartsWith=" +
                                searchController.text;
                            getMarvelCharacters(charactersUrl);
                            if(mounted) {
                              setState(() {});
                            }
                          }
                        },
                      ),
                    )
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "chAracterS ",
                style: TextStyle(
                  fontFamily: "AvengeroDisassembled",
                  letterSpacing: 4.5,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: charactersList.isNotEmpty
                    ? RawScrollbar(
                      controller: scrollController,
                      thumbColor: kMarvelRed,
                      radius: const Radius.circular(5),
                      child: GridView.builder(
                        controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: charactersList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: MediaQuery.of(context).size.width,
                            crossAxisCount: 1,
                            mainAxisSpacing: 40,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return CharacterCard(
                              name: charactersList[index].name.toString(),
                              description: charactersList[index].description!,
                              thumbnailUrl: charactersList[index].thumbnail!.path! +
                                  "/portrait_uncanny." +
                                  charactersList[index].thumbnail!.extension!,
                            );
                          },
                        ),
                    )
                    : const Center(
                        child: CircularProgressIndicator(
                        color: kMarvelRed,
                      )),
              ),
              const SizedBox(height: 30),
            ],
          )),
    );
  }


  void getMarvelCharacters(String url) {
    debugPrint("------------------------RUNNING---------------------------");
    charactersList.clear();
    final uri = Uri.parse(url);
    http.get(uri).then((response) {
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodedJson = jsonDecode(responseBody);
        final marvelData = decodedJson['data'];
        final List resultsList = marvelData['results'];
        for (var i = 0; i < resultsList.length; i++) {
          if (resultsList[i]['thumbnail']['path'] == kImageUnavailable &&
              resultsList[i]['description'] == "") {
          } else {
            final newCharacter =
            CharacterModel.fromJson(resultsList[i] as Map<String, dynamic>);
            charactersList.add(newCharacter);
          }
        }
        setState(() {});
      }
    }).catchError((e) {
      debugPrint("---------------------------$e-----------------------------");
    });
  }

}
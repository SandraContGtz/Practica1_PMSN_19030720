import 'package:flutter/material.dart';
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
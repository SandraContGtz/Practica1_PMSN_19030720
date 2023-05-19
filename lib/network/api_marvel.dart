import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;
import 'package:psmna10/models/actor_model.dart';
import 'package:psmna10/models/marvel_model.dart';
import 'package:psmna10/models/popular_model.dart';

class ApiMarvel {
  String? ImageUrl;
  Uri link = Uri.parse(
      'https://gateway.marvel.com:443/v1/public/characters?ts=1&apikey=2e0a6cbb87ee82683b81895e9c0bb464&hash=a24926dc50a0f15742c0d66f191ad3c8');

  Future<List<CharacterModel>?> getAllCharacters() async {
    var result = await http.get(link);
    var listJson = jsonDecode(result.body)['data']['results'] as List;
    /*String path =
        json.decode(result.body)["data"]["results"][0]["thumbnail"]["path"];
    String ext = json.decode(result.body)["data"]["results"][0]["thumbnail"]
        ["extension"];
    ImageUrl = '$path.$ext';*/

    if (result.statusCode == 200) {
      return listJson
          .map((popular) => CharacterModel.fromMap(popular))
          .toList();
    }
    return null;
  }

  Future<String> getIdVideo(int id_popular) async {
    Uri auxVideo = Uri.parse('https://api.themoviedb.org/3/movie/' +
        id_popular.toString() +
        '/videos?api_key=d7236b730825fb7b3c7e23e7d91e473c');
    var result = await http.get(auxVideo);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      print(listJSON[0]['key']);
      return listJSON[0]['key'];
    }
    return '';
  }

  Future<List<ActorModel>?> getAllAuthors(PopularModel modelito) async {
    Uri auxActores = Uri.parse('https://api.themoviedb.org/3/movie/' +
        modelito.id.toString() +
        '/credits?api_key=d7236b730825fb7b3c7e23e7d91e473c');
    var result = await http.get(auxActores);
    var listJSON = jsonDecode(result.body)['cast'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((actor) => ActorModel.fromMap(actor)).toList();
    }
    return null;
  }
}

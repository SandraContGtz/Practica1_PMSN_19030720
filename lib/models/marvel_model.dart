/*import 'package:flutter/material.dart';
import 'package:psmna10/models/thumbnails.dart';

class CharacterModel {
  int? id;
  String? name;
  String? description;
  String? modified;
  String? resourceURI;
  List? urls;
  Thumbnail? thumbnail;
  /*String? comics;
  String? stories;
  String? events;
  String? series;*/

  CharacterModel({
    this.id,
    this.name,
    this.description,
    this.modified,
    this.resourceURI,
    this.urls,
    this.thumbnail,
    /*this.comics,
    this.stories,
    this.events,
    this.series,*/
  });

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        modified: map['modified'],
        resourceURI: map['uri'],
        urls: map['urls'],
        thumbnail: map['thumbnail'] != null
            ? new Thumbnail.fromMap(map['thumbnail'])
            : null);
    /*comics: map['comics'],
        stories: map['stories'],
        events: map['events'],
        series: map['series']);*/
  }
  /*factory CharacterModel.fromDocument(doc) {
    print(doc.data()['name']);
    return CharacterModel(
      id: doc.data()['id'],
      name: doc.data()['name'],
      description: doc.data()['description'],
      thumbnail:
          "${doc.data()['thumbnail']['path']}.${doc.data()['thumbnail']['extension']}",
      resourceURI: doc.data()['resourceURI'],
    );
  }*/

  /*

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        modified: map['modified'],
        resourceURI: map['uri'],
        urls: map['urls'],
        //thumbnail: map['thumbnail'],
        comics: map['comics'],
        stories: map['stories'],
        events: map['events'],
        series: map['series']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'modified': modified,
      'uri': resourceURI,
      'urls': urls,
      //'thumbnail': thumbnail,
      'comics': comics,
      'stories': stories,
      'events': events,
      'series': series
    };
  }*/
}*/


import 'package:psmna10/models/thumbnails.dart';

class CharacterModel {
  String? name;
  String? description;
  ThumbnailModel? thumbnail;
  CharacterDetailsModel? comics;
  CharacterDetailsModel? series;
  CharacterDetailsModel? stories;
  CharacterDetailsModel? events;

  CharacterModel({
    this.name,
    this.description,
    this.thumbnail,
    this.comics,
    this.series,
    this.stories,
    this.events,
  });

  CharacterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    thumbnail = (json['thumbnail'] != null
        ? ThumbnailModel.fromJson(json['thumbnail'])
        : null)!;
    comics =
    (json['comics'] != null ? CharacterDetailsModel.fromJson(json['comics']) : null)!;
    series =
    (json['series'] != null ? CharacterDetailsModel.fromJson(json['series']) : null)!;
    stories =
    (json['stories'] != null ? CharacterDetailsModel.fromJson(json['stories']) : null)!;
    events =
    (json['events'] != null ? CharacterDetailsModel.fromJson(json['events']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail?.toJson();
    }
    if (comics != null) {
      data['comics'] = comics?.toJson();
    }
    if (series != null) {
      data['series'] = series?.toJson();
    }
    if (stories != null) {
      data['stories'] = stories?.toJson();
    }
    if (events != null) {
      data['events'] = events?.toJson();
    }
    return data;
  }
}



class CharacterDetailsModel {
  int? available;

  CharacterDetailsModel({this.available});

  CharacterDetailsModel.fromJson(Map<String, dynamic> json) {
    available = json['available'];
  }









  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available'] = available;
    return data;
  }
}

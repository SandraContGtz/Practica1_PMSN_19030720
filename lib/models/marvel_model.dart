import 'package:flutter/material.dart';
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
}

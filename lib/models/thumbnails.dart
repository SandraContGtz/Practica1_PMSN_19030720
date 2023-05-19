class Thumbnail {
  String? path;
  String? extension;

  Thumbnail({this.path, this.extension});

  Thumbnail.fromMap(Map<String, dynamic> map) {
    path = map['path'];
    extension = map['extension'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['extension'] = this.extension;
    return data;
  }
}

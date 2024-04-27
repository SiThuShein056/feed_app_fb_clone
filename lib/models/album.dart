import 'photo.dart';

class AlbumModel {
  final int userId, id;
  final String title;

  final List<PhotoModel> photos;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  }) : photos = [];

  factory AlbumModel.fromJsObject(dynamic jsObject) {
    final album = AlbumModel(
      id: int.parse(jsObject['id'].toString()),
      userId: int.parse(jsObject['userId'].toString()),
      title: jsObject['title'],
    );

    if (jsObject['photo'] != null) {
      album.photos.addAll((jsObject['photo'] as List)
          .map((e) => PhotoModel.fromJsObject(e))
          .toList());
    }
    return album;
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "photo": photos.map((e) => e.toMap()).toList(),
    };
  }

  AlbumModel copy() {
    final news = AlbumModel(userId: userId, id: id, title: title);
    news.photos.addAll(photos);
    return news;
  }
}

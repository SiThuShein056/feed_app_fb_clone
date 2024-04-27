import 'user.dart';

class PhotoModel {
  final int albumId, id;
  final String title, url, thumbnailUrl;
//photo ထဲမာ user's name ကို photo.user.name ခေါ် ရအောင်လို့
  late UserModel user;

  PhotoModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJsObject(dynamic jsObject) {
    final photo = PhotoModel(
      id: int.parse(jsObject['id'].toString()),
      albumId: int.parse(jsObject['albumId'].toString()),
      title: jsObject['title'],
      url: jsObject['url'],
      thumbnailUrl: jsObject['thumbnailUrl'],
    );
    // if (jsObject['user'] != null) {
    //   photo.user = UserModel.fromJsObject(jsObject['user']);
    // }
    return photo;
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "albumId": albumId,
      "title": title,
      "url": url,
      "thumbnailUrl": thumbnailUrl,
      // "user": user.toMap(),
    };
  }
}

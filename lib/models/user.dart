import 'album.dart';
import 'comment.dart';
import 'post.dart';

class UserModel {
  final int id;
  final String name, username, email;
//to combine
  final List<PostModel> posts;
  final List<CommentModel> comments;
  final List<AlbumModel> albums;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  })  : posts = [],
        albums = [],
        comments = [];

  factory UserModel.fromJsObject(dynamic jsObject) {
    return UserModel(
      id: int.parse(jsObject['id'].toString()),
      name: jsObject['name'],
      username: jsObject['username'],
      email: jsObject['email'],
    );
  }
  factory UserModel.fromJson(dynamic data) {
    final UserModel user = UserModel.fromJsObject(data);
    final List<PostModel> posts =
        (data['posts'] as List).map(PostModel.fromJsObject).toList();
    final List<AlbumModel> albums =
        (data['albums'] as List).map(AlbumModel.fromJsObject).toList();

    user.posts.addAll(posts);
    user.albums.addAll(albums);

    for (var post in posts) {
      post.user = user;
    }
    for (var album in albums) {
      for (var photo in album.photos) {
        photo.user = user;
      }
    }
    return user;
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
      "posts": posts
          .toList()
          .map((e) => e.toMap())
          .toList(), //post htae ka tomap ko tone tr
      "comments": comments.toList().map((e) => e.toMap()).toList(),
      "albums": albums.toList().map((e) => e.toMap()).toList(),
    };
  }
}

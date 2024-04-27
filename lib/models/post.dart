import 'comment.dart';
import 'user.dart';

class PostModel {
  final int userId, id;
  final String title, body;

  final List<CommentModel> comments;
//post ထဲမာ user's name ကို post.user.name ခေါ် ရအောင်လို့
  late UserModel user;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  }) : comments = [];

  factory PostModel.fromJsObject(dynamic jsObject) {
    final post = PostModel(
      id: int.parse(jsObject['id'].toString()),
      userId: int.parse(jsObject['userId'].toString()),
      title: jsObject['title'],
      body: jsObject['body'],
    );

    if (jsObject['comment'] != null) {
      post.comments.addAll((jsObject['comment'] as List)
          .map(CommentModel.fromJsObject)
          .toList());
    }

    return post;
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "body": body,
      "comment": comments.toList().map((e) => e.toMap()).toList(),
    };
  }
}

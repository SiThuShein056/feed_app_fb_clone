class CommentModel {
  final int postId, id;
  final String name, email, body;

  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentModel.fromJsObject(dynamic jsObject) {
    return CommentModel(
      id: int.parse(jsObject['id'].toString()),
      postId: int.parse(jsObject['postId'].toString()),
      name: jsObject['name'],
      email: jsObject['email'],
      body: jsObject['body'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "postId": postId,
      "name": name,
      "email": email,
      "body": body,
    };
  }
}

import 'package:feed_app/models/user.dart';
import 'package:feed_app/repositories/api_repository.dart';

class UserController {
  final ApiRepository api;
  UserController(this.api);

  Future<List<UserModel>> getUsers() async {
    ///js object
    final List users = await api.get(
        "https://jsonplaceholder.typicode.com/users", "cached_users");

    return users.map(UserModel.fromJsObject).toList();
    // return users.map((e) =>UserModel.fromJsObject(e)).toList();
  }
}

import 'package:feed_app/models/album.dart';
import 'package:feed_app/models/post.dart';
import 'package:feed_app/models/user.dart';

import 'album_controller.dart';
import 'post_controller.dart';
import 'user_controller.dart';

class FeedController {
  final UserController userController;
  final PostController postController;
  final AlbumController albumController;

  FeedController({
    required this.userController,
    required this.postController,
    required this.albumController,
  });

  ///1 Get All Users
  ///2 Related Post,Album
  ///3 Show

  static List<UserModel> users = [];
  Future<List<UserModel>> getUsers() async {
    final List<UserModel> users = await userController.getUsers();

    ///Post
    final List<Future<List<PostModel>>> posts = users.map((e) {
      return getPosts(e.id);
    }).toList();

    ///List<Future<List<PostModel>>>

    // paww ka lo id ma taung bae UserModel taung tr ma lot direct call ya tal
    //   (e) {
    //   return getPosts(e.id);
    // }
    final List<Future<List<AlbumModel>>> albums = users.map(getAlbums).toList();

    ///List<List<PostModel>>
    // Future.wait([ //same ways with below
    //   ...posts,
    //   ...albums,
    // ]);

    final List<List<PostModel>> userPosts = await Future.wait(posts);
    final List<List<AlbumModel>> userAlbums = await Future.wait(albums);

////////WHY????//////////////////////
    for (var i = 0; i < users.length; i++) {
      //post ထဲမာ user's name ကို post.user.name ခေါ် ရအောင်လို့
      final user = users[i];
      final posts = userPosts[i];

      user.posts.addAll(posts.map((e) {
        e.user = user;
        return e;
      }));

      // user.posts.addAll(userPosts[i]);

      user.albums.addAll(userAlbums[i]);
    }

    FeedController.users.clear();
    FeedController.users.addAll(users);
////////////////////////////////
    // cacheRepository.save(users);
    return users;
  }

  Future<List<PostModel>> getPosts(int userId) async {
    return postController.getPosts(userId);
  }

////
  Future<List<AlbumModel>> getAlbums(UserModel user) async {
    return albumController.getAlbums(user);
  }
}

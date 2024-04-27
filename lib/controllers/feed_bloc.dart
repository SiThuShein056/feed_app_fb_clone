import 'package:feed_app/controllers/album_controller.dart';
import 'package:feed_app/controllers/post_controller.dart';
import 'package:feed_app/controllers/user_controller.dart';
import 'package:feed_app/models/album.dart';
import 'package:feed_app/models/post.dart';
import 'package:feed_app/models/user.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class FeedBaseState {
  List<UserModel> users;
  FeedBaseState(this.users);

  Map<String, dynamic> toJson() {
    final data = {
      "users": users.map((e) => e.toMap()).toList(),
    };
    return data;
  }
}

class FeedInitialState extends FeedBaseState {
  FeedInitialState() : super([]);
}

class FeedLoadingState extends FeedBaseState {
  FeedLoadingState() : super([]);
}

class FeedDataState extends FeedBaseState {
  FeedDataState(super.users);

  factory FeedDataState.fromJson(Map<String, dynamic> data) {
    return FeedDataState(
        (data["users"] as List).map(UserModel.fromJson).toList());
  }
}

class FeedErrorState extends FeedBaseState {
  FeedErrorState(super.users);
}

abstract class FeedBaseEvent {
  const FeedBaseEvent();
}

class FeedFatchEvent extends FeedBaseEvent {
  const FeedFatchEvent();
}

class FeedBloc extends HydratedBloc<FeedBaseEvent, FeedBaseState> {
  final UserController userController;
  final PostController postController;
  final AlbumController albumController;
  FeedBloc(super.initialState,
      {required this.albumController,
      required this.postController,
      required this.userController}) {
    on<FeedFatchEvent>((event, emit) async {
      if (state is FeedLoadingState || state is FeedDataState) return;

      emit(FeedLoadingState());

      final List<UserModel> users = await userController.getUsers();
      final List<Future<List<PostModel>>> posts = users.map((e) {
        return getPosts(e.id);
      }).toList();
      final List<Future<List<AlbumModel>>> albums =
          users.map(getAlbums).toList();
      final List<List<PostModel>> userPosts = await Future.wait(posts);
      final List<List<AlbumModel>> userAlbums = await Future.wait(albums);

      match(users, userPosts, userAlbums);

      emit(FeedDataState(users));
    });
  }
  void match(List<UserModel> users, List<List<PostModel>> userPosts,
      List<List<AlbumModel>> userAlbums) {
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
  }

  Future<List<PostModel>> getPosts(int userId) async {
    return postController.getPosts(userId);
  }

  Future<List<AlbumModel>> getAlbums(UserModel user) async {
    return albumController.getAlbums(user);
  }

  @override
  FeedBaseState? fromJson(Map<String, dynamic> json) {
    print(json['users'] == null);
    print("From Json is ${json['users']}");

    ////////
    if (json['users'] != null) {
      try {
        final newState = FeedDataState.fromJson(json);
        print("New States is $newState");
        return newState;
      } catch (e) {
        return null;
      }
    }
    return FeedErrorState([]);
    // return null;
  }

  @override
  Map<String, dynamic>? toJson(FeedBaseState state) {
    if (state is FeedDataState) {
      try {
        final data = state.toJson();

        print("Data is $data");
        return data;
      } catch (e, s) {
        print("error $s");
        return null;
      }
    }
    return null;
  }
}

import 'dart:developer';

import 'package:feed_app/controllers/feed_bloc.dart';
import 'package:feed_app/models/post.dart';
import 'package:feed_app/views/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends SearchDelegate {
  // final List<PostModel> _posts = [];

  // final users = FeedController.users;
  // List<PostModel> get posts {
  //   log("CALLED POST METHOD..............");
  //   log("DATA OF USER IS ${users.length}");

  //   if (_posts.isEmpty) {
  //     _posts.addAll(FeedController.users.fold(<PostModel>[],
  //         (previousValue, element) => [...previousValue, ...element.posts]));
  //     log(_posts.length.toString());
  //   }
  //   return _posts;

  //   // return users.fold(
  //   //     [], (previousValue, element) => [...previousValue, ...element.posts]);
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [const SizedBox()];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final bloc = context.read<FeedBloc>();

    List<PostModel> post = bloc.state.users.fold(<PostModel>[],
        (previousValue, element) => [...previousValue, ...element.posts]);
    log(" buildgggggggggggggg + ${post.length}");
    final searchPosts = post
        .where((element) =>
            element.title.toLowerCase().startsWith(query.toLowerCase()) ||
            element.body.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
        itemCount: searchPosts.length,
        itemBuilder: (_, i) {
          return PostCard(
            post: searchPosts[i],
            onTap: () {
              Navigator.of(context).pushNamed("/details",
                  arguments: bloc.state.users.firstWhere(
                      (element) => element.id == searchPosts[i].userId));
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final bloc = context.read<FeedBloc>();

    List<PostModel> post = bloc.state.users.fold(<PostModel>[],
        (previousValue, element) => [...previousValue, ...element.posts]);
    log(" suggesting............ + ${post.length}");
    final searchPosts = post
        .where((element) =>
            element.title.toLowerCase().startsWith(query.toLowerCase()) ||
            element.body.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: searchPosts.length,
        itemBuilder: (_, i) {
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed("/details",
                  arguments: bloc.state.users.firstWhere(
                      (element) => element.id == searchPosts[i].userId));
            },
            tileColor: Colors.white,
            title: Text(searchPosts[i].title),
          );
        });
  }
}

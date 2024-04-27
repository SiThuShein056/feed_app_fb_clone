import 'package:feed_app/controllers/feed_bloc.dart';
import 'package:feed_app/delegate/search.dart';
import 'package:feed_app/models/photo.dart';
import 'package:feed_app/models/post.dart';
import 'package:feed_app/views/widgets/image_section.dart';
import 'package:feed_app/views/widgets/post_card.dart';
import 'package:feed_app/views/widgets/the_end.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FeedBloc>().add(const FeedFatchEvent());
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.feed_rounded),
          title: const Text("Feeds"),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchScreen());
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: BlocBuilder<FeedBloc, FeedBaseState>(builder: (_, state) {
          if (state is FeedLoadingState) {
            return const Center(
                child: CupertinoActivityIndicator(
              color: Colors.amber,
            ));
          }
          if (state is FeedErrorState) {
            return const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            );
          }
          final users = state.users;
          return ListView(
            padding: const EdgeInsets.only(bottom: 10),
            children: [
              ///My Day Section
              ImageSection(
                photos: users.map((e) => e.albums).fold(
                  <PhotoModel>[],
                  (previousValue, element) => [
                    ...previousValue,
                    element[1]
                        //photo ko pae lo chin lot choose p
                        .photos
                        .fold(
                            <PhotoModel>[],
                            (previousValue, element) =>
                                [...previousValue, element])[0]
                  ],
                )..shuffle(),
              ),

              // for (var i in users
              //     .map((e) => e.albums)
              //     //////Why//////////
              //     .fold(
              //   <PhotoModel>[],
              //   (previousValue, element) => [
              //     ...previousValue,
              //     ...element.map((e) => e.photos).fold(
              //         <PhotoModel>[],
              //         (previousValue, element) =>
              //             [...previousValue, ...element])
              //   ],
              // )..shuffle())

              ///Post Section
              for (var posts in users
                  .map((e) => e.posts)
                  //////Why//////////
                  .fold(
                <PostModel>[],
                (previousValue, element) => [...previousValue, ...element],
              )
                //မပါရင်ကော??????
                ..shuffle()) //shuffle ka yaw tar
                PostCard(
                  post: posts,
                  onTap: () {
                    Navigator.of(context).pushNamed("/details",
                        arguments: users.firstWhere(
                            (element) => element.id == posts.userId));
                  },
                ),

              const TheEnd()
            ],
          );
        }));
  }
}

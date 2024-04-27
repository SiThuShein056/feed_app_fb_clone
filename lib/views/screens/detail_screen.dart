// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_app/models/photo.dart';
import 'package:feed_app/models/user.dart';
import 'package:feed_app/views/screens/no_found_screen.dart';
import 'package:feed_app/views/widgets/circle_profile.dart';
import 'package:feed_app/views/widgets/image_section.dart';
import 'package:feed_app/views/widgets/post_card.dart';
import 'package:feed_app/views/widgets/the_end.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = ModalRoute.of(context)?.settings.arguments;

    if (user == null || user is UserModel == false) return NoFoundScreen();
    user as UserModel;

    final coverPhoto = user.albums[1].photos;
    // final featurePhotos =
    //     user.albums.sublist(2).map((e) => e.photos as PhotoModel).toList();

    final featurePhotos = user.albums.sublist(2).fold(<PhotoModel>[],
        (previousValue, element) => [...previousValue, ...element.photos]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user.name),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 10),
        children: [
          Container(
            color: Colors.white,
            height: 230,
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/view", arguments: coverPhoto);
                  },
                  child: CachedNetworkImage(
                    imageUrl: coverPhoto.first.url,
                    height: 200,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 0,
                  child: CircleProfile(
                    name: user.name[0].toString(),
                    radius: 60,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    StaticCard(
                      width: 110,
                      icon: Icons.article,
                      label: "${user.posts.length} Posts",
                    ),
                    StaticCard(
                      width: 120,
                      icon: Icons.photo_rounded,
                      label: "${user.albums.length} Albums",
                    ),
                  ],
                ),
              ],
            ),
          ),
          ImageSection(
            showProfileImage: false,
            photos: featurePhotos,
          ),
          for (int i = 0; i < user.posts.length; i++)
            PostCard(
              post: user.posts[i],
              onTap: null,
            ),
          const TheEnd()
        ],
      ),
    );
  }
}

class StaticCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String label;
  const StaticCard({
    super.key,
    required this.width,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(175, 177, 169, 0.2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

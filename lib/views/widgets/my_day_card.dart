import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_app/models/album.dart';
import 'package:feed_app/models/photo.dart';
import 'package:flutter/material.dart';

import 'circle_profile.dart';

class MyDayCard extends StatelessWidget {
  final PhotoModel photo;
  final AlbumModel albumModel;
  final bool showProfileImage;
  const MyDayCard({
    super.key,
    required this.albumModel,
    this.showProfileImage = true,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/view", arguments: albumModel.photos);
      },
      child: SizedBox(
        width: 100,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: photo.url,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  // colorFilter: const ColorFilter.mode(
                  //   Colors.red,
                  //   BlendMode.colorBurn,
                  // ),
                ),
              ),
              // alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: showProfileImage
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showProfileImage)
                    CircleProfile(
                      name: photo.user.name[0],
                    ),
                  Text(
                    photo.user.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}

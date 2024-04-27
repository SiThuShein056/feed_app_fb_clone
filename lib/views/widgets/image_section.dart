import 'package:feed_app/controllers/feed_bloc.dart';
import 'package:feed_app/models/album.dart';
import 'package:feed_app/models/photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_day_card.dart';

class ImageSection extends StatelessWidget {
  final List<PhotoModel> photos;
  final bool showProfileImage;
  const ImageSection({
    super.key,
    this.showProfileImage = true,
    this.photos = const [],
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final feedBloc = context.read<FeedBloc>();
    if (photos.isEmpty) return const SizedBox();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      color: Colors.white,
      height: 160,
      width: size.width,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        itemBuilder: (_, i) {
          final photo = photos[i];

          ///////////////
          final albums = feedBloc.state.users
              .fold(<AlbumModel>[], (p, c) => [...p, ...c.albums]);

          final albumIndex =
              albums.indexWhere((albu) => albu.id == photos[i].albumId);

          final copied = albums[albumIndex].copy();
          copied.photos.removeWhere((element) => element.id == photo.id);
          copied.photos.insert(0, photo);

          /////////////////////
          return MyDayCard(
            // albumModel: albums[albumIndex],
            albumModel: copied,
            photo: photo,
            showProfileImage: showProfileImage,
          );
        },
      ),
    );
  }
}

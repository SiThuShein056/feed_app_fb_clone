import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_app/models/photo.dart';
import 'package:feed_app/views/screens/no_found_screen.dart';
import 'package:flutter/material.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final photo = ModalRoute.of(context)?.settings.arguments;
    if (photo == null || photo is! List<PhotoModel>) return NoFoundScreen();

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (_, i) {
                  return CachedNetworkImage(
                    imageUrl: photo[i].url,
                    fit: BoxFit.cover,
                    placeholder: (_, __) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorWidget: (context, url, error) => Center(
                      child: Icon(Icons.error_outline),
                    ),
                  );
                }),
            Positioned(
                top: mediaQuery.viewPadding.top + 10,
                left: 10,
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.chevron_left),
                    label: Text("Back")))
          ],
        ),
      ),
    );
  }
}

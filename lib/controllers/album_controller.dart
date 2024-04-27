import 'package:feed_app/models/album.dart';
import 'package:feed_app/models/photo.dart';
import 'package:feed_app/models/user.dart';
import 'package:feed_app/repositories/api_repository.dart';

class AlbumController {
  final ApiRepository api;

  AlbumController(this.api);

  Future<List<AlbumModel>> getAlbums(UserModel user) async {
    final List response = await api.get(
        "https://jsonplaceholder.typicode.com/albums?userId=${user.id}",
        "cached_albums");

    final List<AlbumModel> albums =
        response.map(AlbumModel.fromJsObject).toList();
    final List<List<PhotoModel>> photos =
        await Future.wait(albums.map((e) => getPhotos(e.id)).toList());

    // for (var i = 0; i < albums.length; i++) {
    //   albums[i].photos.addAll(photos[i]);
    // }

    for (var alubm in albums) {
      alubm.photos.addAll(
        photos[albums.indexWhere((element) => element.id == alubm.id)]
            ////photo ထဲမာ user's name ကို photo.user.name ခေါ် ရအောင်လို့
            .map((e) {
          e.user = user;
          return e;
        }),
      );
    }
    return albums;
  }

  Future<List<PhotoModel>> getPhotos(int photoId) async {
    final List response = await api.get(
        "https://jsonplaceholder.typicode.com/photos?albumId=$photoId",
        "cached_photos");

    return response.map(PhotoModel.fromJsObject).toList();
  }
}

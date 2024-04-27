import 'package:dio/dio.dart';
import 'package:feed_app/controllers/album_controller.dart';
import 'package:feed_app/controllers/feed_bloc.dart';
import 'package:feed_app/controllers/post_controller.dart';
import 'package:feed_app/controllers/user_controller.dart';
import 'package:feed_app/repositories/api_repository.dart';
import 'package:feed_app/repositories/like_repository.dart';
import 'package:feed_app/views/screens/detail_screen.dart';
import 'package:feed_app/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'views/screens/photo_view_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationCacheDirectory());
  await LikeRepository.init();
  runApp(const MiniSocailApp());
}

final ApiRepository apiRepository = ApiRepository(Dio());

class MiniSocailApp extends StatelessWidget {
  const MiniSocailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedBloc(FeedInitialState(),
          albumController: AlbumController(apiRepository),
          postController: PostController(apiRepository),
          userController: UserController(apiRepository)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/details":
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => const DetailScreen());
            case "/view":
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => const PhotoViewScreen());

            default:
              return MaterialPageRoute(
                  settings: settings, builder: (context) => const HomeScreen());
          }
        },
      ),
    );
  }
}

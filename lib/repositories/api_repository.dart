import 'package:dio/dio.dart';

class ApiRepository {
  // controller htae mr khana khana tone nay ya lot bone htoke like tr
  final Dio dio;
  // final CacheRepository cacheRepository;
  ApiRepository(
    this.dio,
    // this.cacheRepository,
  );

  Future<List<dynamic>> get(String url, String collection) async {
    try {
      final response = await dio.get(url);
      final result = response.data as List;
      // final saved = cacheRepository.save(
      //     collection, result.map((e) => e as Map<String, dynamic>).toList());

      // print("Saved value is $saved");
      return result;
    } catch (e) {
      // this.cacheRepository.get(collection);
      return [];
    }
  }
}

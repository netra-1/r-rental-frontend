import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

// ignore: depend_on_referenced_packages
import 'package:nrental/api/http_services.dart';
import 'package:nrental/response/article_response.dart';
import 'package:nrental/utils/url.dart';

class ArticleAPI {
  Future<ArticleResponse?> getArticles() async {
    Future.delayed(const Duration(seconds: 2), () {});
    ArticleResponse? articleResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(articleUrl,
          options: buildCacheOptions(const Duration(days: 7)));
      if (response.statusCode == 201) {
        articleResponse = ArticleResponse.fromJson(response.data);
      } else {
        articleResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return articleResponse;
  }

  Future<ArticleResponse?> getFeaturedArticles() async {
    Future.delayed(const Duration(seconds: 2), () {});
    ArticleResponse? articleResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(featuredArticleUrl,
          options: buildCacheOptions(const Duration(days: 7)));
      if (response.statusCode == 201) {
        articleResponse = ArticleResponse.fromJson(response.data);
      } else {
        articleResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return articleResponse;
  }
}

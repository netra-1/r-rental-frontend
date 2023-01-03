import 'package:nrental/api/article_api.dart';
import 'package:nrental/response/article_response.dart';

class ArticleRepository {
  Future<ArticleResponse?> getArticles() async {
    return ArticleAPI().getArticles();
  }
  Future<ArticleResponse?> getFeaturedArticles() async {
    return ArticleAPI().getFeaturedArticles();
  }
}

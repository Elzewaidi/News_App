import 'package:dio/dio.dart';
import '../model/article_model.dart';

class ArticleRepository {
  final Dio _dio;

  // Base URL and Endpoints - Ready for actual integration
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String bookmarksEndpoint = '/everything?q=bitcoin&apiKey=55cb1b5899124822afce8cbbe3ed7d88';
  static const String articlesEndpoint = '/everything?q=bitcoin&apiKey=55cb1b5899124822afce8cbbe3ed7d88';

  ArticleRepository({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl));

  // Fetches list of articles from API and parses the "articles" JSON array
  Future<List<ArticleModel>> getBookmarks() async {
    try {
      final response = await _dio.get(bookmarksEndpoint);
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        final List data = response.data['articles'];
        return data.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load bookmarks');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error occurred. Please try again.');
    } catch (e) {
      throw Exception('An unexpected error occurred.');
    }
  }

  // Fetches specific article details
  Future<ArticleModel> getArticleDetails(String url) async {
    try {
      // Assuming your API has an endpoint that accepts a query parameter or path for the specific article.
      // E.g., /articles?url=XYZ
      final response = await _dio.get(articlesEndpoint, queryParameters: {'url': url});
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        final List data = response.data['articles'];
        if (data.isNotEmpty) {
          return ArticleModel.fromJson(data.first);
        } else {
          throw Exception('Article not found');
        }
      } else {
        throw Exception('Failed to load article');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error occurred. Please try again.');
    } catch (e) {
      throw Exception('An unexpected error occurred.');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/news_model.dart';

class NewsApi {
  final String baseUrl = 'https://newsapi.org/v2';
  final String apiKey = 'c037ce11182b4d5fa7053503254f5638';

  Future<NewsModel> getAllNews() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/top-headlines?country=us&pageSize=100&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<Articles> filteredArticles = (jsonResponse['articles'] as List)
          .map((article) => Articles.fromJson(article))
          .where((article) =>
              article.title != null &&
              article.description != null &&
              article.urlToImage != null)
          .toList();

      return NewsModel(
        status: jsonResponse['status'],
        totalResults: filteredArticles.length,
        articles: filteredArticles,
      );
    } else {
      throw Exception('Не удалось загрузить новости');
    }
  }
}

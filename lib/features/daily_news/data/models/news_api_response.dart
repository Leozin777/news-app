import 'package:news_app_clean_architecture/features/daily_news/data/models/article.dart';

class NewsApiResponse {
  final String status;
  final List<ArticleModel> articles;

  NewsApiResponse({required this.status, required this.articles});

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) {
    return NewsApiResponse(
      status: json['status'],
      articles: (json['articles'] as List).map((article) => ArticleModel.fromJson(article)).toList(),
    );
  }
}

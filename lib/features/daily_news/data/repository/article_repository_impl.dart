import 'dart:io';

import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';
import '../models/article.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpRespose = await _newsApiService.getNewsArticles(
        newsAPIKey,
        countryQuery,
        categoryQuery,
      );

      if (httpRespose.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpRespose.response.data.articles);
      } else {
        return DataFailed(DioException(
          response: httpRespose.response,
          error: httpRespose.response.statusCode,
          type: DioExceptionType.badResponse,
          requestOptions: httpRespose.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

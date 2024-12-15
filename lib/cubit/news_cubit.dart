import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/news_model.dart';
import '/api/news_api.dart';

class NewsCubit extends Cubit<List<Articles>> {
  final NewsApi repository;
  Articles? selectedArticle;

  NewsCubit()
      : repository = NewsApi(),
        super([]);

  Future<void> fetchNews() async {
    try {
      final news = await repository.getAllNews();
      emit(news.articles ?? []);
    } catch (_) {
      emit([]);
    }
  }

  void selectArticle(Articles article) {
    selectedArticle = article;
  }
}

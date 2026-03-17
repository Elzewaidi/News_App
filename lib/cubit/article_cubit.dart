import 'package:bloc/bloc.dart';
import 'package:new_app/model/article_repository.dart';
import 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final ArticleRepository repository;

  ArticleCubit({required this.repository}) : super(ArticleInitial());

  Future<void> fetchArticleDetails(String id) async {
    emit(ArticleLoading());
    try {
      final article = await repository.getArticleDetails(id);
      emit(ArticleSuccess(article));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:new_app/model/article_repository.dart';
import 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final ArticleRepository repository;

  BookmarkCubit({required this.repository}) : super(BookmarkInitial());

  Future<void> fetchBookmarks() async {
    emit(BookmarkLoading());
    try {
      final bookmarks = await repository.getBookmarks();
      emit(BookmarkSuccess(bookmarks));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }
}

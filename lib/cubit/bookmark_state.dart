import 'package:equatable/equatable.dart';
import 'package:new_app/model/article_model.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object?> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkSuccess extends BookmarkState {
  final List<ArticleModel> bookmarks;

  const BookmarkSuccess(this.bookmarks);

  @override
  List<Object?> get props => [bookmarks];
}

class BookmarkError extends BookmarkState {
  final String message;

  const BookmarkError(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';
import 'package:new_app/model/article_model.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object?> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleSuccess extends ArticleState {
  final ArticleModel article;

  const ArticleSuccess(this.article);

  @override
  List<Object?> get props => [article];
}

class ArticleError extends ArticleState {
  final String message;

  const ArticleError(this.message);

  @override
  List<Object?> get props => [message];
}

///Состояния главной страницы (на второй их нет, так как там только чтение)

part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

//Начальное состояние
class NewsInitialState extends NewsState {}

//Пометка новостей прочитанными
class AllReadState extends NewsState {
  final List<Article> featuredArticles;
  final List<Article> latestArticles;

  const AllReadState(
      {required this.featuredArticles, required this.latestArticles});

  @override
  List<Object> get props => [featuredArticles, latestArticles];
}

//Добавление featuredArticle
class FeaturedArticleAddState extends NewsState {
  final Article featuredArticle;

  const FeaturedArticleAddState({required this.featuredArticle});

  @override
  List<Object> get props => [featuredArticle];
}

//Добавление latestArticle
class LatestArticleAddState extends NewsState {
  final Article latestArticle;

  const LatestArticleAddState({required this.latestArticle});

  @override
  List<Object> get props => [latestArticle];
}

//При возникновении ошибки
class NewsLoadFailedState extends NewsState {
  final Error error;

  const NewsLoadFailedState({required this.error});

  @override
  List<Object> get props => [error];
}

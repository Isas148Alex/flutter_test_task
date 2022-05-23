//Состояния главной страницы (на второй их нет, так как там только чтение)

part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

//Начальное состояние
class NewsInitialState extends NewsState{}

//Когда новости подгружены
class NewsLoadedState extends NewsState {
  final List<Article> featuredArticles;
  final List<Article> latestArticles;

  const NewsLoadedState({required this.featuredArticles, required this.latestArticles});

  @override
  List<Object> get props => [featuredArticles, latestArticles];
}

//При возникновении ошибки
class NewsLoadFailedState extends NewsState {
  final Error error;

  const NewsLoadFailedState({required this.error});

  @override
  List<Object> get props => [error];
}

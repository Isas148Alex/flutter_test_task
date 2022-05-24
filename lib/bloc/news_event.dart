//События главной страницы

part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

//Добавление latestArticle
class FeaturedArticleAddEvent extends NewsEvent{
  final Article featuredArticle;

  const FeaturedArticleAddEvent({required this.featuredArticle});

  @override
  List<Object?> get props => [featuredArticle];
}

//Добавление latestArticle
class LatestArticleAddEvent extends NewsEvent{
  final Article latestArticle;

  const LatestArticleAddEvent({required this.latestArticle});

  @override
  List<Object?> get props => [latestArticle];
}

//Пометка новостей, как прочитанных
class MarkAllReadEvent extends NewsEvent{
  const MarkAllReadEvent();

  @override
  List<Object?> get props => [];
}

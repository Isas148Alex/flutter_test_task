//TODO

part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitialState extends NewsState{}

class NewsLoadedState extends NewsState {
  final List<Article> featuredArticles;
  final List<Article> latestArticles;

  const NewsLoadedState({required this.featuredArticles, required this.latestArticles});

  @override
  List<Object> get props => [featuredArticles, latestArticles];
}

class NewsLoadFailedState extends NewsState {
  final Error error;

  const NewsLoadFailedState({required this.error});

  @override
  List<Object> get props => [error];
}

class OpenNewState extends NewsState {
  final id;

  const OpenNewState({required this.id});

  @override
  List<Object> get props => [id];
}
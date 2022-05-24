//Логика главной страницы

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forestvpn_test/repositories/news/repository.dart';

import '../repositories/news/models/models.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final repository = MockNewsRepository();
  final List<Article> featuredArticles = [];
  final List<Article> latestArticles = [];

  NewsBloc() : super(NewsInitialState()) {
    on<FeaturedArticleAddEvent>((event, emit) {
      _featuredArticleAddEventHandler(event, emit);
    });

    on<LatestArticleAddEvent>((event, emit) {
      _latestArticleAddEventHandler(event, emit);
    });

    on<MarkAllReadEvent>((event, emit) {
      _markAllReadEventHandler(event, emit);
    });
  }

  void _markAllReadEventHandler(MarkAllReadEvent event, Emitter emit) {
    //По факту - это очень и очень плохо, потому что если объектов будет много,
    //пересоздание списков займёт уйму времени, но т.к. поле "readed" объявлено как
    //final, вариант есть такой.
    for (var i in latestArticles) {
      i = Article(
          id: i.id,
          title: i.title,
          publicationDate: i.publicationDate,
          imageUrl: i.imageUrl,
          description: i.description,
          readed: true);
    }
    for (var i in featuredArticles) {
      i = Article(
          id: i.id,
          title: i.title,
          publicationDate: i.publicationDate,
          imageUrl: i.imageUrl,
          description: i.description,
          readed: true);
    }
    emit(AllReadState(
        latestArticles: latestArticles,
        featuredArticles: featuredArticles));
  }

  void _featuredArticleAddEventHandler(
      FeaturedArticleAddEvent event, Emitter emit) {
    emit(FeaturedArticleAddState(featuredArticle: event.featuredArticle));
  }

  void _latestArticleAddEventHandler(
      LatestArticleAddEvent event, Emitter emit) {
    emit(LatestArticleAddState(latestArticle: event.latestArticle));
  }
}

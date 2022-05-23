//Логика главной страницы

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forestvpn_test/repositories/news/repository.dart';

import '../repositories/news/models/models.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final repository = MockNewsRepository();

  NewsBloc() : super(NewsInitialState()) {
    on<LoadNewsEvent>((event, emit) async {
      await _loadNewsEventHandler(event, emit);
    });

    on<MarkAllReadEvent>((event, emit) {
      _markAllReadEventHandler(event, emit);
    });
  }

  Future<void> _loadNewsEventHandler(LoadNewsEvent event, Emitter emit) async {
    final featuredArticles =
        await repository.getFeaturedArticles().catchError((error) {
      emit(NewsLoadFailedState(error: error));
    });
    final latestArticles =
        await repository.getFeaturedArticles().catchError((error) {
      emit(NewsLoadFailedState(error: error));
    });
    emit(NewsLoadedState(
        featuredArticles: featuredArticles, latestArticles: latestArticles));
  }

  void _markAllReadEventHandler(MarkAllReadEvent event, Emitter emit){
    List<Article> featuredArticles = [];
    List<Article> latestArticles = [];
    for (var art in (state as NewsLoadedState).featuredArticles) {
      featuredArticles.add(Article(
          id: art.id,
          title: art.title,
          publicationDate: art.publicationDate,
          imageUrl: art.imageUrl,
          readed: true,
          description: art.description));
    }
    for (var art in (state as NewsLoadedState).latestArticles) {
      latestArticles.add(Article(
          id: art.id,
          title: art.title,
          publicationDate: art.publicationDate,
          imageUrl: art.imageUrl,
          readed: true,
          description: art.description));
    }
    emit(NewsLoadedState(
        latestArticles: latestArticles,
        featuredArticles: featuredArticles));
  }
}

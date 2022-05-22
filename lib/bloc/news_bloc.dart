//TODO

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
    });

    on<OpenNewEvent>((event, emit) {
      emit(OpenNewState(id: event.id));
    });
  }
}

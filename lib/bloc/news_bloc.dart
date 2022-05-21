//TODO

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsEvent>((event, emit) {
      on<NewsEvent>(_newsEventHandler);
      // TODO: implement event handler
    });

  }
  Future<void> _newsEventHandler(NewsEvent e, Emitter emit) async {
    emit(NewsInitial);
  }
}

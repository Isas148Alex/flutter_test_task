//События главной страницы

part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

//Загрузка новостей - первое событие
class LoadNewsEvent extends NewsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//Пометка новостей, как прочитанных
class MarkAllReadEvent extends NewsEvent{
  const MarkAllReadEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//TODO

part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class LoadNewsEvent extends NewsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ScrollCarousel extends NewsEvent{
  final index;

  const ScrollCarousel(this.index);

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class OpenNewEvent extends NewsEvent{
  final id;

  const OpenNewEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class MarkAllReadEvent extends NewsEvent{
  const MarkAllReadEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

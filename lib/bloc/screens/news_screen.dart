///Главная страница

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forestvpn_test/bloc/news_bloc.dart';
import 'package:forestvpn_test/constant_styles.dart';
import 'package:forestvpn_test/repositories/news/mock_news_repository.dart';
import 'package:forestvpn_test/repositories/news/models/models.dart';
import 'package:jiffy/jiffy.dart';

import '../../constant_texts.dart';
import 'new_screen.dart';

class NewsScreen extends StatelessWidget {
  final repository = MockNewsRepository();
  final List<Article> articles = [];

  NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstantTexts.notifications,
            style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          //Можно было выбрать другой тип кнопки, но этот смотрится красиво,
          //а на макете не было отображена нажатая кнопка
          ActionChip(
            backgroundColor: Colors.white,
            label: Text(ConstantTexts.markAllRead),
            onPressed: () {
              context.read<NewsBloc>().add(const MarkAllReadEvent());
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: ConstantStyles.containerPadding,
            child: Text(
              ConstantTexts.featured,
              style: ConstantStyles.textSize20,
            )),
        Container(
            padding: ConstantStyles.containerPadding,
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitialState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsLoadedState) {
                  return CarouselSlider.builder(
                      options: CarouselOptions(
                        //В макете было 300 и оно выглядит норм. Но всё таки сделал так
                        //чтобы влезало больше списка. Можно раскомментить тут
                        //и чуть нижу в построитель списка передать в 2 раза больше элементов
                        //на 96 и 99 строках
                        //height: 300,
                        viewportFraction: 1,
                        //Не было указано, но как по мне - логично
                        enableInfiniteScroll: false,
                      ),
                      itemCount: state.featuredArticles.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return _carouselSliderFeaturedArticlesBuild(
                            context, state, index);
                      });
                } else if (state is NewsLoadFailedState) {
                  return Text(state.error.toString());
                }
                return Text(ConstantTexts.somethingWrong);
              },
            )),
        Container(
            padding: ConstantStyles.containerPadding,
            child: Text(ConstantTexts.latestNews,
                style: ConstantStyles.textSize20)),
        BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitialState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoadedState) {
              return Expanded(
                  child: ListView.builder(
                      itemCount: state.latestArticles.length, //*2   Вот тут
                      itemBuilder: (context, index) {
                        return _listViewLatestArticlesBuilder(
                            context, state, index); //%state.latestArticles.length И вот тут
                      }));
            } else if (state is NewsLoadFailedState) {
              return Text(state.error.toString());
            }
            return const Text("Something went wrong");
          },
        ),
      ],
    );
  }

  //Построение карусели
  Widget _carouselSliderFeaturedArticlesBuild(
      BuildContext context, NewsLoadedState state, int index) {
    return Stack(fit: StackFit.expand, children: [
      InkWell(
        onTap: () {
          //По-хорошему здесь использовать repository.getArticle(),
          //но как по мне - лучше передавать на новый экран новость в актуальном
          //состоянии, а оно есть в нашем списке.
          //А так - можно было бы обернуть это в try-catch и в catch выводить
          //ScaffoldMessenger с текстом типа "Новость не найдена".
          //А ещё лучше всё это через BLoC делать.
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return NewScreen(article: state.featuredArticles[index]);
          }));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              state.featuredArticles[index].imageUrl,
              fit: BoxFit.cover,
              color: const Color(0xff000000).withOpacity(0.7),
              colorBlendMode: BlendMode.darken,
            )),
      ),
      Container(
          margin: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              //Сделано исключительно для проверки прочитана или нет статья
              //для проверки кнопки "mark all read"
              state.featuredArticles[index].title +
                  state.featuredArticles[index].readed.toString(),
              overflow: TextOverflow.clip,
              style: ConstantStyles.newTitle,
            )
          ])),
    ]);
  }

  //Построение списка
  Widget _listViewLatestArticlesBuilder(
      BuildContext context, NewsLoadedState state, int index) {
    return Container(
        padding: ConstantStyles.containerPadding,
        child: Card(
            child: ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return NewScreen(article: state.latestArticles[index]);
            }));
          },
          title: Text(state.latestArticles[index].title,
              style: ConstantStyles.textSize16),
          subtitle: Text(
              Jiffy(state.latestArticles[index].publicationDate).fromNow(),
              style: ConstantStyles.textSize12),
          leading: SizedBox(
              width: 90,
              height: 60,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    state.latestArticles[index].imageUrl,
                    fit: BoxFit.cover,
                  ))),
        )));
  }
}

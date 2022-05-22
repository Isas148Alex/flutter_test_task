///Used for definition of main screen with all news

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forestvpn_test/bloc/news_bloc.dart';
import 'package:forestvpn_test/repositories/news/mock_news_repository.dart';
import 'package:forestvpn_test/repositories/news/models/models.dart';
import 'package:jiffy/jiffy.dart';

import '../../constant_texts.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: Text(
              ConstantTexts.featured,
              style: const TextStyle(fontSize: 20),
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitialState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsLoadedState) {
                  return CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1,
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
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: const Text("Latest news", style: TextStyle(fontSize: 20))),
        BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitialState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoadedState) {
              return Expanded(
                  child: ListView.builder(
                      itemCount: state.latestArticles.length,
                      itemBuilder: (context, index) {
                        return _listViewLatestArticlesBuilder(state, index);
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

  Widget _carouselSliderFeaturedArticlesBuild(
      BuildContext context, NewsLoadedState state, int index) {
    return Stack(fit: StackFit.passthrough, children: [
      InkWell(
        onTap: () {
          context
              .read<NewsBloc>()
              .add(OpenNewEvent(state.featuredArticles[index]));
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
      Positioned(
        width: 200,
        child: Text(
          state.featuredArticles[index].title,
          style: const TextStyle(color: Colors.white, fontSize: 28),
        ),
        bottom: 10,
        left: 10,
      )
    ]);
  }

  Widget _listViewLatestArticlesBuilder(NewsLoadedState state, int index) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        child: Card(
            child: ListTile(
          title: Text(state.latestArticles[index].title,
              style: const TextStyle(fontSize: 16)),
          subtitle: Text(
              Jiffy(state.latestArticles[index].publicationDate).fromNow(),
              style: const TextStyle(fontSize: 12)),
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

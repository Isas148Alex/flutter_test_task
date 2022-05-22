///Used for definition of main screen with all news

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forestvpn_test/repositories/news/mock_news_repository.dart';
import 'package:forestvpn_test/repositories/news/models/models.dart';
import 'new_screen.dart';

class NewsScreen extends StatelessWidget {
  final repository = MockNewsRepository();
  final List<Article> articles = [];

  NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Notifications", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          ActionChip(
            backgroundColor: Colors.white,
            label: const Text("Mark all read"),
            onPressed: () {
              _markAllRead();
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
        const Text("Featured"),
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1,
            enableInfiniteScroll: false,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return FutureBuilder<List<Article>>(
                future: repository.getFeaturedArticles(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Ошибка");
                  } else if (snapshot.hasData) {
                    articles.add(snapshot.data![index]);
                    return Stack(fit: StackFit.passthrough, children: [
                      InkWell(
                        onTap: () {
                          _openNew(context, index);
                        },
                        child: Image.network(
                          snapshot.data![index].imageUrl,
                          fit: BoxFit.fill,
                          color: const Color(0xff000000).withOpacity(0.7),
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                      Positioned(
                        child: Text(
                          snapshot.data![index].title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        bottom: 10,
                        left: 10,
                        // width: 150,
                      )
                    ]);
                  } else {
                    return const CircularProgressIndicator();
                  }
                });
          },
          itemCount: 4,
        ),
        const Text("Latest news"),
        Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildListView(context, index);
                }))
      ],
    );
  }

  void _markAllRead() {}

  void _openNew(BuildContext context, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return NewScreen(article: articles[index]);
    }));
  }

  Widget _buildListView(BuildContext context, int index) {
    return const Card(
      child: Text("asd"),
    );
  }
}

///Used for definition of main screen with all news

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forestvpn_test/repositories/news/mock_news_repository.dart';
import 'package:forestvpn_test/repositories/news/models/models.dart';

class NewsScreen extends StatelessWidget {
  final repository = MockNewsRepository();

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
                    return Stack(
                        // fit: StackFit.expand,
                        children: [
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              snapshot.data![index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            snapshot.data![index].title,
                            style: const TextStyle(color: Colors.white),
                          )
                        ]);
                  } else {
                    return const Text("No value");
                  }
                });
          },
          itemCount: 4,
        ),
      ],
    );
  }

  void _markAllRead() {}
}

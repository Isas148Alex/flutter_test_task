/// Виджет одной новости

import 'package:flutter/material.dart';
import 'package:forestvpn_test/constants/constant_styles.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';

import '../constants/constant_other.dart';

class NewScreen extends StatelessWidget {
  final Article article;

  const NewScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScaffoldBody(context),
    );
  }

  Widget _buildScaffoldBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: ConstantOther.backgroundColorSliverAppBar,
          expandedHeight: ConstantOther.expandedHeightSliverAppBar,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            title: Text(
              article.title,
              overflow: TextOverflow.clip,
              style: ConstantStyles.textSize20,
            ),
            background: ClipRRect(
                borderRadius: ConstantOther.borderRadius,
                child: Image.network(
                  article.imageUrl,
                  fit: BoxFit.cover,
                  color: ConstantOther.blur,
                  colorBlendMode: BlendMode.darken,
                )),
          ),
        ),
        _buildTextArea(),
      ],
    );
  }

  Widget _buildTextArea() => SliverToBoxAdapter(
          child: SingleChildScrollView(
              child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
        child: Text(
            //Для проверки отображения длинных новостей можно раскомментить код ниже
            _reformatDescription(article.description) +
                _reformatDescription(article.description) +
                _reformatDescription(article.description) +
                _reformatDescription(article.description),
            style: ConstantStyles.textSize16),
      )));

  //Делаю переносы строк, а то всё одним абзацем
  String _reformatDescription(String? description) {
    return description == null ? "" : description.replaceAll("\n", "\n\n");
  }
}

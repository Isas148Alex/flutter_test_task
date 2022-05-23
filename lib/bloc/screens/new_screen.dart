/// Виджет одной новости

import 'package:flutter/material.dart';
import 'package:forestvpn_test/constant_styles.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';

class NewScreen extends StatelessWidget {
  final Article article;

  const NewScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    return Column(
      //Растягиваем картинку на всю ширину
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            //Заголовок + фоновая картинка, размеры не настроены, поэтому высота везде разная
            child: Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.bottomLeft,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        article.imageUrl,
                        fit: BoxFit.cover,
                        color: const Color(0xff000000).withOpacity(0.7),
                        colorBlendMode: BlendMode.darken,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 48),
                      child: Text(
                        article.title,
                        overflow: TextOverflow.clip,
                        style: ConstantStyles.newTitle,
                      ))
                ])),
        //На случай длинного текста
        Expanded(
            child: SingleChildScrollView(
                child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
          child: Text(_reformatDescription(article.description),
              style: ConstantStyles.textSize16),
        )))
      ],
    );
  }

  //делаю переносы строк, а то всё одним абзацем
  String _reformatDescription(String? description) {
    return description == null ? "" : description.replaceAll("\n", "\n\n");
  }
}

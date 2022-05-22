/// Used for definition of a page of concrete new

import 'package:flutter/material.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';

class NewScreen extends StatelessWidget {
  final Article article;

  const NewScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Stack(fit: StackFit.passthrough, children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.imageUrl,
                fit: BoxFit.cover,
                color: const Color(0xff000000).withOpacity(0.7),
                colorBlendMode: BlendMode.darken,
              )),
          Positioned(
            width: 300,
            child: Text(
              article.title + article.title,
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
            bottom: 10,
            left: 10,
          )
        ]),
      ),*/
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(fit: StackFit.passthrough, children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.imageUrl,
                fit: BoxFit.cover,
                color: const Color(0xff000000).withOpacity(0.7),
                colorBlendMode: BlendMode.darken,
              )),
          Positioned(
            width: 300,
            child: Text(
              article.title + article.title,
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
            bottom: 10,
            left: 10,
          )
        ]),
        Container(
          margin: const EdgeInsets.all(10),
          child: Text(_reformatDescription(article.description),
              style: const TextStyle(fontSize: 16)),
        )
      ],
    );
  }

  String _reformatDescription(String? description) {
    return description == null ? "" : description.replaceAll("\n", "\n\n");
  }
}

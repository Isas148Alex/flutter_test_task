/// Used for definition of a page of concrete new

import 'package:flutter/material.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';

class NewScreen extends StatelessWidget {
  final Article article;

  const NewScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(article.title);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forestvpn_test/screens/news_screen.dart';
import 'constants/constant_texts.dart';
import 'bloc/news/news_bloc.dart';

void main() {
  runApp(const ForestVPNTestApp());
}

class ForestVPNTestApp extends StatelessWidget {
  const ForestVPNTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstantTexts.title,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (BuildContext context) {
          return NewsBloc();
        },
        child: NewsScreen(),
      ),
    );
  }
}

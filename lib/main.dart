import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forestvpn_test/bloc/screens/news_screen.dart';

import 'bloc/news_bloc.dart';

void main() {
  runApp(const ForestVPNTestApp());
}

class ForestVPNTestApp extends StatelessWidget {
  const ForestVPNTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ForestVPN test',
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (BuildContext context) {
            return NewsBloc()..add(LoadNewsEvent());
          },
          child: NewsScreen(),
        ));
  }
}

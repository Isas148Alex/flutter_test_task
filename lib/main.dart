import 'package:flutter/material.dart';
import 'package:forestvpn_test/news_screen.dart';

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
      home: NewsScreen(),
    );
  }
}

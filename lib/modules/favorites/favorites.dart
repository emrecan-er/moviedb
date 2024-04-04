import 'package:flutter/material.dart';
import 'package:movie/constants.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kCardColor,
        title: Text('Favorites'),
      ),
    );
  }
}

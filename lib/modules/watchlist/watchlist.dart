import 'package:flutter/material.dart';
import 'package:movie/constants.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        backgroundColor: kCardColor,
      ),
      backgroundColor: kBackgroundColor,
    );
  }
}

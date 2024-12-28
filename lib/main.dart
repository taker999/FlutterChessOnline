import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'helper/constants.dart';
import 'pages/about_page.dart';
import 'pages/game_page.dart';
import 'pages/home_page.dart';
import 'pages/set_game_time_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chess',
      initialRoute: Constants.homePage,
      routes: {
        Constants.homePage: (context) => const HomePage(),
        Constants.aboutPage: (context) => const AboutPage(),
        Constants.gamePage: (context) => const GamePage(),
        Constants.setGameTimePage: (context) => const SetGameTimePage(),
        Constants.settingsPage: (context) => const SettingsPage(),
      },
    );
  }
}

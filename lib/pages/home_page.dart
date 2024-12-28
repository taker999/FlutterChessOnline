import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/game_provider.dart';
import '../widgets/build_game_type.dart';
import 'about_page.dart';
import 'set_game_time_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Chess',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return BuildGameType(
                  label: 'Play vs Computer',
                  icon: Icons.computer,
                  onTap: () {
                    ref.read(gameProvider.notifier).setVsComputer(true);
                    // navigate to set game time page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetGameTimePage(),
                      ),
                    );
                  },
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                return BuildGameType(
                  label: 'Play vs Friend',
                  icon: Icons.person,
                  onTap: () {
                    ref.read(gameProvider.notifier).setVsComputer(false);
                    // navigate to set game time page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetGameTimePage(),
                      ),
                    );
                  },
                );
              },
            ),
            BuildGameType(
              label: 'Settings',
              icon: Icons.settings,
              onTap: () {
                // navigate to settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
            BuildGameType(
              label: 'About',
              icon: Icons.info,
              onTap: () {
                // navigate to about page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

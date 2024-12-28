import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../helper/helper_functions.dart';
import '../widgets/build_game_type.dart';
import 'game_startup_page.dart';

class SetGameTimePage extends StatelessWidget {
  const SetGameTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Choose game time',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: gameTimes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1.5),
          itemBuilder: (context, index) {
            // get the first word of the game time
            final String label = gameTimes[index].split(' ')[0];

            // get the second word from game time
            final String gameTime = gameTimes[index].split(' ')[1];

            return BuildGameType(
              label: label,
              gameTime: gameTime,
              onTap: () => label == Constants.custom
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameStartupPage(
                          isCustomTime: true,
                          gameTime: '0',
                        ),
                      ),
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameStartupPage(
                          isCustomTime: false,
                          gameTime: gameTime,
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

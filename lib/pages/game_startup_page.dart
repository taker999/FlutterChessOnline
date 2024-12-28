import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/constants.dart';
import '../helper/helper_functions.dart';
import '../providers/game_provider.dart';
import '../widgets/build_custom_time.dart';
import '../widgets/game_level_radio_button.dart';
import '../widgets/player_color_radio_button.dart';

class GameStartupPage extends ConsumerStatefulWidget {
  const GameStartupPage(
      {super.key, required this.isCustomTime, required this.gameTime});

  final bool isCustomTime;
  final String gameTime;

  @override
  ConsumerState<GameStartupPage> createState() => _GameStartupPageState();
}

class _GameStartupPageState extends ConsumerState<GameStartupPage> {
  int whiteTimeInMinutes = 0;
  int blackTimeInMinutes = 0;

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Setup Game',
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
        child: Column(
          children: [
            // radio list tile
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: PlayerColorRadioButton(
                    title: 'Play as ${PlayerColor.white.name}',
                    value: PlayerColor.white,
                    groupValue: game.playerColor,
                    onChanged: (value) {
                      ref.read(gameProvider.notifier).setPlayerColor(0);
                    },
                  ),
                ),
                widget.isCustomTime
                    ? BuildCustomTime(
                        time: whiteTimeInMinutes.toString(),
                        onLeftArrowClicked: () {
                          if (whiteTimeInMinutes != 0) {
                            setState(() {
                              whiteTimeInMinutes--;
                            });
                          }
                        },
                        onRightArrowClicked: () {
                          setState(() {
                            whiteTimeInMinutes++;
                          });
                        },
                      )
                    : Container(
                        padding: const EdgeInsets.all(6.0),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            widget.gameTime,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: PlayerColorRadioButton(
                    title: 'Play as ${PlayerColor.black.name}',
                    value: PlayerColor.black,
                    groupValue: game.playerColor,
                    onChanged: (value) {
                      ref.read(gameProvider.notifier).setPlayerColor(1);
                    },
                  ),
                ),
                widget.isCustomTime
                    ? BuildCustomTime(
                        time: blackTimeInMinutes.toString(),
                        onLeftArrowClicked: () {
                          if (blackTimeInMinutes != 0) {
                            setState(() {
                              blackTimeInMinutes--;
                            });
                          }
                        },
                        onRightArrowClicked: () {
                          setState(() {
                            blackTimeInMinutes++;
                          });
                        },
                      )
                    : Container(
                        padding: const EdgeInsets.all(6.0),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            widget.gameTime,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            ref.read(gameProvider).vsComputer
                ? Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Game Difficulty',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GameLevelRadioButton(
                            title: GameDifficulty.easy.name,
                            value: GameDifficulty.easy,
                            groupValue: game.gameDifficulty,
                            onChanged: (value) {
                              ref
                                  .read(gameProvider.notifier)
                                  .setGameDifficulty(1);
                            },
                          ),
                          const SizedBox(width: 10),
                          GameLevelRadioButton(
                            title: GameDifficulty.medium.name,
                            value: GameDifficulty.medium,
                            groupValue: game.gameDifficulty,
                            onChanged: (value) {
                              ref
                                  .read(gameProvider.notifier)
                                  .setGameDifficulty(2);
                            },
                          ),
                          const SizedBox(width: 10),
                          GameLevelRadioButton(
                            title: GameDifficulty.hard.name,
                            value: GameDifficulty.hard,
                            groupValue: game.gameDifficulty,
                            onChanged: (value) {
                              ref
                                  .read(gameProvider.notifier)
                                  .setGameDifficulty(3);
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink(),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // navigate to game page
                playGame(ref);
              },
              child: const Text('Play'),
            ),
          ],
        ),
      ),
    );
  }

  void playGame(WidgetRef ref) {
    // check if it's custom time
    if (widget.isCustomTime) {
      // check all timers are greater than 0
      if (whiteTimeInMinutes == 0 || blackTimeInMinutes == 0) {
        // show snack bar
        showSnackBar(context: context, content: 'Time cannot be 0');
        return;
      }
      // start loading dialog
      ref.read(gameProvider.notifier).setLoading(true);

      // save time and player color for both players
      ref
          .read(gameProvider.notifier)
          .setGameTime(whiteTimeInMinutes, blackTimeInMinutes);
      if (ref.read(gameProvider).vsComputer) {
        ref.read(gameProvider.notifier).setLoading(false);

        // navigate to game page
        Navigator.pushNamed(context, Constants.gamePage);
      } else {
        // search for players
      }
    } else {
      // not custom time
      // check if it's incremental time
      // get the value after the + sign
      final String incrementalTime = widget.gameTime.split('+')[1];

      // get the value before the + time
      final String gameTime = widget.gameTime.split('+')[0];

      // check if increment is equal to 0
      if (incrementalTime != '0') {
        // save the incremental time
        ref
            .read(gameProvider.notifier)
            .setIncrementalTime(int.parse(incrementalTime));
        ref.read(gameProvider.notifier).setLoading(true);
        ref
            .read(gameProvider.notifier)
            .setGameTime(int.parse(gameTime), int.parse(gameTime));
        if (ref.read(gameProvider).vsComputer) {
          ref.read(gameProvider.notifier).setLoading(false);

          // navigate to game page
          Navigator.pushNamed(context, Constants.gamePage);
        } else {
          // search for players
        }
      }
    }
  }
}

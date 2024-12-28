import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:square_bishop/square_bishop.dart';
import 'package:squares/squares.dart';

import '../providers/game_provider.dart';
import '../service/assets_manager.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameProvider.notifier).resetGame(false);
      letAIPlayFirst();
    });
    super.initState();
  }

  void letAIPlayFirst() async {
    final game = ref.read(gameProvider);
    if (ref.read(gameProvider).state.state == PlayState.theirTurn &&
        !game.aiThinking) {
      ref.read(gameProvider.notifier).setAiThinking(true);
      await Future.delayed(
          Duration(milliseconds: Random().nextInt(4750) + 250));
      game.game.makeRandomMove();
      ref.read(gameProvider.notifier).setAiThinking(false);
      ref.read(gameProvider.notifier).setSquaresState();
      pauseStartTimer(false, () {});
    }
  }

  void _onMove(Move move) async {
    final game = ref.read(gameProvider);
    bool result = game.game.makeSquaresMove(move);
    if (result) {
      ref.read(gameProvider.notifier).setSquaresState();

      if(game.player == Squares.white) {
        pauseStartTimer(false, () {});
      } else {
        pauseStartTimer(true, () {});
      }
    }
    if (ref.read(gameProvider).state.state == PlayState.theirTurn &&
        !game.aiThinking) {
      ref.read(gameProvider.notifier).setAiThinking(true);
      await Future.delayed(
          Duration(milliseconds: Random().nextInt(4750) + 250));
      game.game.makeRandomMove();
      ref.read(gameProvider.notifier).setAiThinking(false);
      ref.read(gameProvider.notifier).setSquaresState();

      if(game.player == Squares.white) {
        pauseStartTimer(true, () {});
      } else {
        pauseStartTimer(false, () {});
      }
    }
  }

  void pauseStartTimer(bool isWhitesTimer, Function onNewGame) {
    if (isWhitesTimer) {
      // pause timer for black and start timer for white
      ref.read(gameProvider.notifier).pauseBlacksTimer();
      ref.read(gameProvider.notifier).startWhitesTimer(context, onNewGame);
    } else {
      // pause timer for white and start timer for black
      ref.read(gameProvider.notifier).pauseWhitesTimer();
      ref.read(gameProvider.notifier).startBlacksTimer(context, onNewGame);
    }
  }

  String getTimerToDisplay(bool isUser) {
    final game = ref.read(gameProvider);
    String timer = '';
    // check if it's user
    if (isUser) {
      if (game.player == Squares.white) {
        timer = game.whiteTime.toString().substring(2, 7);
      } else {
        timer = game.blackTime.toString().substring(2, 7);
      }
    } else {
      // if it's not user do the opposite
      if (game.player == Squares.white) {
        timer = game.blackTime.toString().substring(2, 7);
      } else {
        timer = game.whiteTime.toString().substring(2, 7);
      }
    }
    return timer;
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);
    String whitesTimer = getTimerToDisplay(true);
    String blacksTimer = getTimerToDisplay(false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // TODO show dialog if sure
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'Chess',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => ref.read(gameProvider.notifier).resetGame(true),
            icon: const Icon(
              Icons.start,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: ref.read(gameProvider.notifier).flipBoard,
            icon: const Icon(
              Icons.rotate_left,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // opponent's data
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(AssetsManager.stockfishIcon),
            ),
            title: const Text('Stockfish'),
            subtitle: const Text('Rating: 3000'),
            trailing: Text(
              blacksTimer,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: BoardController(
              state: game.flipBoard
                  ? game.state.board.flipped()
                  : game.state.board,
              playState: game.state.state,
              pieceSet: PieceSet.merida(),
              theme: BoardTheme.brown,
              moves: game.state.moves,
              onMove: _onMove,
              onPremove: _onMove,
              markerTheme: MarkerTheme(
                empty: MarkerTheme.dot,
                piece: MarkerTheme.corners(),
              ),
              promotionBehaviour: PromotionBehaviour.autoPremove,
            ),
          ),

          // our data
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(AssetsManager.userIcon),
            ),
            title: const Text('User'),
            subtitle: const Text('Rating: 1200'),
            trailing: Text(
              whitesTimer,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

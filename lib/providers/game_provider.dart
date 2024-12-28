import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:square_bishop/square_bishop.dart';
import 'package:squares/squares.dart';
import 'package:bishop/bishop.dart' as bishop;

import '../helper/constants.dart';
import '../models/chess_game_state.dart';

class ChessGameStateNotifier extends StateNotifier<ChessGameState> {
  ChessGameStateNotifier()
      : super(ChessGameState(
          vsComputer: false,
          isLoading: false,
          player: Squares.white,
          playerColor: PlayerColor.white,
          whiteTime: Duration.zero,
          blackTime: Duration.zero,
          savedWhiteTime: Duration.zero,
          savedBlackTime: Duration.zero,
          gameLevel: 1,
          gameDifficulty: GameDifficulty.easy,
          incrementalTime: 0,
          game: bishop.Game(variant: bishop.Variant.standard()),
          state: SquaresState.initial(0),
          aiThinking: false,
          flipBoard: false,
          whitesTimer: null,
          blacksTimer: null,
        ));

  void resetGame(bool newGame) {
    if (newGame) {
      // check if the player was white in the previous game
      // change the player
      if (state.player == Squares.white) {
        state = state.copyWith(player: Squares.black);
      } else {
        state = state.copyWith(player: Squares.white);
      }
    }

    // reset game
    state =
        state.copyWith(game: bishop.Game(variant: bishop.Variant.standard()));
    state = state.copyWith(state: state.game.squaresState(state.player));
  }

  void flipBoard() {
    state = state.copyWith(flipBoard: !state.flipBoard);
  }

  void setAiThinking(bool value) {
    state = state.copyWith(aiThinking: value);
  }

  void setSquaresState() {
    state = state.copyWith(state: state.game.squaresState(state.player));
  }

  void setVsComputer(bool value) {
    state = state.copyWith(vsComputer: value);
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setGameTime(int savedWhiteTime, int savedBlackTime) {
    // set game times
    state = state.copyWith(
        savedWhiteTime: Duration(minutes: savedWhiteTime),
        savedBlackTime: Duration(minutes: savedBlackTime));

    // set times
    setTimes(state.savedWhiteTime, state.savedBlackTime);
  }

  void setTimes(Duration whiteTime, Duration blackTime) {
    state = state.copyWith(whiteTime: whiteTime, blackTime: blackTime);
  }

  void setPlayerColor(int player) {
    state = state.copyWith(
        player: player,
        playerColor:
            player == Squares.white ? PlayerColor.white : PlayerColor.black);
  }

  void setGameDifficulty(int level) {
    state = state.copyWith(
        gameLevel: level,
        gameDifficulty: level == 1
            ? GameDifficulty.easy
            : level == 2
                ? GameDifficulty.medium
                : GameDifficulty.hard);
  }

  void setIncrementalTime(int time) {
    state = state.copyWith(incrementalTime: time);
  }

  // pause black's timer
  void pauseBlacksTimer() {
    if (state.blacksTimer != null) {
      state = state.copyWith(
          blackTime:
          state.blackTime + Duration(seconds: state.incrementalTime));
      state.blacksTimer!.cancel();
    }
  }

  // start black's timer
  void startBlacksTimer(BuildContext context, Function onNewGame) {
    state = state.copyWith(
        blacksTimer: Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(
          blackTime: state.blackTime - const Duration(seconds: 1));
      if (state.blackTime == Duration.zero) {
        // blacks timeout - black has lost the game
        state.blacksTimer!.cancel();

        // show game over dialog
        log('Black has lost');
      }
    }));
  }

  // pause white's timer
  void pauseWhitesTimer() {
    if (state.whitesTimer != null) {
      state = state.copyWith(
          whiteTime:
              state.whiteTime + Duration(seconds: state.incrementalTime));
      state.whitesTimer!.cancel();
    }
  }

  // start white's timer
  void startWhitesTimer(BuildContext context, Function onNewGame) {
    state = state.copyWith(
        whitesTimer: Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(
          whiteTime: state.whiteTime - const Duration(seconds: 1));
      if (state.whiteTime == Duration.zero) {
        // whites timeout - white has lost the game
        state.whitesTimer!.cancel();

        // show game over dialog
        log('White has lost');
      }
    }));
  }
}

final gameProvider =
    StateNotifierProvider<ChessGameStateNotifier, ChessGameState>((ref) {
  return ChessGameStateNotifier(); // Initial value of the counter
});

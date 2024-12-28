import 'dart:async';

import 'package:bishop/bishop.dart' as bishop;
import 'package:square_bishop/square_bishop.dart';

import '../helper/constants.dart';

class ChessGameState {
  final bool vsComputer;
  final bool isLoading;
  final int player;
  final PlayerColor playerColor;
  final Duration whiteTime;
  final Duration blackTime;
  final Duration savedWhiteTime;
  final Duration savedBlackTime;
  final int gameLevel;
  final GameDifficulty gameDifficulty;
  final int incrementalTime;
  final bishop.Game game;
  final SquaresState state;
  final bool aiThinking;
  final bool flipBoard;
  final Timer? whitesTimer;
  final Timer? blacksTimer;

  ChessGameState({
    required this.vsComputer,
    required this.isLoading,
    required this.player,
    required this.playerColor,
    required this.whiteTime,
    required this.blackTime,
    required this.savedWhiteTime,
    required this.savedBlackTime,
    required this.gameLevel,
    required this.gameDifficulty,
    required this.incrementalTime,
    required this.game,
    required this.state,
    required this.aiThinking,
    required this.flipBoard,
    required this.whitesTimer,
    required this.blacksTimer,
  });

  ChessGameState copyWith({
    bool? vsComputer,
    bool? isLoading,
    int? player,
    PlayerColor? playerColor,
    Duration? whiteTime,
    Duration? blackTime,
    Duration? savedWhiteTime,
    Duration? savedBlackTime,
    int? gameLevel,
    GameDifficulty? gameDifficulty,
    int? incrementalTime,
    bishop.Game? game,
    SquaresState? state,
    bool? aiThinking,
    bool? flipBoard,
    Timer? whitesTimer,
    Timer? blacksTimer,
  }) {
    return ChessGameState(
      vsComputer: vsComputer ?? this.vsComputer,
      isLoading: isLoading ?? this.isLoading,
      player: player ?? this.player,
      playerColor: playerColor ?? this.playerColor,
      whiteTime: whiteTime ?? this.whiteTime,
      blackTime: blackTime ?? this.blackTime,
      savedWhiteTime: savedWhiteTime ?? this.savedWhiteTime,
      savedBlackTime: savedBlackTime ?? this.savedBlackTime,
      gameLevel: gameLevel ?? this.gameLevel,
      gameDifficulty: gameDifficulty ?? this.gameDifficulty,
      incrementalTime: incrementalTime ?? this.incrementalTime,
      game: game ?? this.game,
      state: state ?? this.state,
      aiThinking: aiThinking ?? this.aiThinking,
      flipBoard: flipBoard ?? this.flipBoard,
      whitesTimer: whitesTimer ?? this.whitesTimer,
      blacksTimer: blacksTimer ?? this.blacksTimer,
    );
  }
}

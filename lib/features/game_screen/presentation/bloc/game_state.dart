part of 'game_bloc.dart';

@immutable
class GameState {}

final class GameInitialState extends GameState {
  final int maxAttempts;
  final int maxRange;

  GameInitialState({
    required this.maxAttempts,
    required this.maxRange,
  });
}

final class GameInProgressState extends GameState {
  final int attemptsLeft;

  GameInProgressState({
    required this.attemptsLeft,
  });
}

final class GameVictoryState extends GameState {
  final int attemptsLeft;

  GameVictoryState({
    required this.attemptsLeft,
  });
}

final class GameOverState extends GameState {
  final int correctNumber;

  GameOverState({
    required this.correctNumber,
  });
}

final class GameErrorState extends GameState {
  final String message;

  GameErrorState({required this.message});
}

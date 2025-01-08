part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GenerateRandomNumberEvent extends GameEvent {
  final int maxRange;
  final int maxAttempts;

  GenerateRandomNumberEvent({
    required this.maxRange,
    required this.maxAttempts,
  });
}

class CheckGuessEvent extends GameEvent {
  final int guess;

  CheckGuessEvent({
    required this.guess,
  });
}

class RestartGameEvent extends GameEvent {
  final int maxRange;
  final int maxAttempts;

  RestartGameEvent({
    required this.maxRange,
    required this.maxAttempts,
  });
}

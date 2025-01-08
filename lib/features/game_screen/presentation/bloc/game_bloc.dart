import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late int _targetNumber = 0;
  late int _remainingAttempts = 0;

  final Random _random = Random();

  GameBloc() : super(GameInitialState(maxAttempts: 0, maxRange: 0)) {
    on<GenerateRandomNumberEvent>(_onGenerateRandomNumber);

    on<CheckGuessEvent>(_onCheckGuess);

    on<RestartGameEvent>(_onRestartGame);
  }

  void _onGenerateRandomNumber(
      GenerateRandomNumberEvent event, Emitter<GameState> emit) {
    if (event.maxRange <= 0) {
      emit(
        GameErrorState(
            message: 'Максимальный диапазон должен быть больше нуля'),
      );
      return;
    }

    try {
      _targetNumber = _random.nextInt(event.maxRange) + 1;
      _remainingAttempts = event.maxAttempts;
      emit(GameInProgressState(attemptsLeft: _remainingAttempts));
    } on Exception catch (e) {
      emit(GameErrorState(message: 'Что то пошло не так: ${e.toString()}'));
    }
  }

  void _onCheckGuess(CheckGuessEvent event, Emitter<GameState> emit) {
    if (event.guess == _targetNumber) {
      emit(GameVictoryState(attemptsLeft: _remainingAttempts));
    } else {
      _remainingAttempts--;
      if (_remainingAttempts == 0) {
        emit(GameOverState(correctNumber: _targetNumber));
      } else {
        emit(GameInProgressState(attemptsLeft: _remainingAttempts));
      }
    }
  }

  void _onRestartGame(RestartGameEvent event, Emitter<GameState> emit) {
    emit(GameInitialState(
      maxAttempts: event.maxAttempts,
      maxRange: event.maxRange,
    ));
  }
}

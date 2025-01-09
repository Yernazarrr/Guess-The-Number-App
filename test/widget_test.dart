import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guess_the_number/features/game_screen/presentation/bloc/game_bloc.dart';

void main() {
  group('GameBloc', () {
    late GameBloc gameBloc;

    setUp(() {
      gameBloc = GameBloc();
    });

    tearDown(() {
      gameBloc.close();
    });

    blocTest<GameBloc, GameState>(
      'emits [GameErrorState] when maxRange is less than or equal to 0',
      build: () => gameBloc,
      act: (bloc) =>
          bloc.add(GenerateRandomNumberEvent(maxRange: 0, maxAttempts: 5)),
      expect: () => [
        isA<GameErrorState>(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameInProgressState] when GenerateRandomNumberEvent is added with valid maxRange and maxAttempts',
      build: () => gameBloc,
      act: (bloc) =>
          bloc.add(GenerateRandomNumberEvent(maxRange: 10, maxAttempts: 5)),
      expect: () => [isA<GameInProgressState>()],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameVictoryState] when CheckGuessEvent is added with correct guess',
      build: () => gameBloc,
      seed: () => GameInProgressState(attemptsLeft: 5),
      act: (bloc) {
        bloc.add(GenerateRandomNumberEvent(maxRange: 10, maxAttempts: 5));
        bloc.add(CheckGuessEvent(
            guess: 1)); // Assuming the random number generated is 1
      },
      expect: () => [
        isA<GameInProgressState>(),
        isA<GameVictoryState>(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameOverState] when CheckGuessEvent is added with incorrect guess and no attempts left',
      build: () => gameBloc,
      seed: () => GameInProgressState(attemptsLeft: 1),
      act: (bloc) {
        bloc.add(GenerateRandomNumberEvent(maxRange: 10, maxAttempts: 1));
        bloc.add(CheckGuessEvent(
            guess: 2)); // Assuming the random number generated is not 2
      },
      expect: () => [
        isA<GameInProgressState>(),
        isA<GameOverState>(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameInitialState] when RestartGameEvent is added',
      build: () => gameBloc,
      act: (bloc) => bloc.add(RestartGameEvent(maxRange: 10, maxAttempts: 5)),
      expect: () => [isA<GameInitialState>()],
    );
  });
}

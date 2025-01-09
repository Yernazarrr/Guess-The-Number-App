import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'bloc/game_bloc.dart';
import 'screens/game_in_progress_screen.dart';
import 'screens/initial_screen.dart';
import 'screens/result_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _maxAttemptsController = TextEditingController();
  final TextEditingController _maxRangeController = TextEditingController();

  final _logger = Logger();

  int? _maxRange;
  int? _maxAttempts;

  @override
  void dispose() {
    _maxRangeController.dispose();
    _maxAttemptsController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _maxAttemptsController.addListener(_updateMaxAttempts);
    _maxRangeController.addListener(_updateMaxRange);
  }

  void _updateMaxRange() {
    setState(() {
      try {
        _maxRange = int.tryParse(_maxRangeController.text);
      } catch (e) {
        _showError('Ошибка при вводе диапазона');
      }
    });
  }

  void _updateMaxAttempts() {
    setState(() {
      try {
        _maxAttempts = int.tryParse(_maxAttemptsController.text);
      } catch (e) {
        _showError('Ошибка при вводе количества попыток');
      }
    });
  }

  void _clearControllers() {
    _controller.clear();
    _maxAttemptsController.clear();
    _maxRangeController.clear();
  }

  // Метод для старта игры
  void _startGame() {
    if (_maxRange == null || _maxRange! <= 0) {
      _showError('Диапазон должен быть больше 0');
      return;
    }
    if (_maxAttempts == null || _maxAttempts! <= 0) {
      _showError('Количество попыток должно быть больше 0');
      return;
    }

    _logger.i(
      'Игра началась с диапазоном: $_maxRange и попытками: $_maxAttempts',
    );

    BlocProvider.of<GameBloc>(context).add(
      GenerateRandomNumberEvent(
        maxRange: _maxRange!,
        maxAttempts: _maxAttempts!,
      ),
    );
  }

  // Метод для рестарта игры
  void _restartGame() {
    _logger.i('Игра перезапущена');

    try {
      // Проверяем, что значения не равны null перед использованием
      if (_maxRange != null && _maxAttempts != null) {
        _clearControllers();
        BlocProvider.of<GameBloc>(context).add(
          RestartGameEvent(
            maxRange: 0,
            maxAttempts: 0,
          ),
        );
      } else {
        _showError('Диапазон или количество попыток не могут быть null');
      }
    } catch (e) {
      _showError('Ошибка при перезапуске игры: $e');
    }
  }

  // Метод для показа ошибки на экране
  void _showError(String message) {
    _logger.e('Ошибка: $message');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ошибка'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Закрыть'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        try {
          if (state is GameInitialState) {
            return _buildInitialScreen();
          } else if (state is GameInProgressState) {
            return _buildGameInProgressScreen(state);
          } else if (state is GameVictoryState) {
            return _buildResultScreen('Вы угадали!', Colors.green);
          } else if (state is GameOverState) {
            return _buildResultScreen(
                'Вы проиграли! Загаданное число: ${state.correctNumber}',
                Colors.red);
          } else {
            return _buildErrorScreen();
          }
        } catch (e) {
          _showError('Неизвестная ошибка: $e');
          return _buildErrorScreen();
        }
      },
    );
  }

  Widget _buildInitialScreen() {
    return InitialScreen(
      maxAttemptsController: _maxAttemptsController,
      maxRangeController: _maxRangeController,
      onStartGame: _startGame,
    );
  }

  Widget _buildGameInProgressScreen(GameInProgressState state) {
    return GameInProgressScreen(
      attemptsLeft: state.attemptsLeft,
      controller: _controller,
      onSubmitGuess: (guess) {
        try {
          BlocProvider.of<GameBloc>(context).add(
            CheckGuessEvent(guess: guess),
          );
        } catch (e) {
          _showError('Ошибка при отправке предположения: $e');
        }
      },
    );
  }

  Widget _buildResultScreen(String message, Color color) {
    return ResultScreen(
      message: message,
      color: color,
      onRestart: _restartGame,
    );
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ошибка в приложении!',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _restartGame();
              },
              child: const Text('Начать заново'),
            ),
          ],
        ),
      ),
    );
  }
}

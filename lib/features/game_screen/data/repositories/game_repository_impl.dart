import 'dart:math';

import '../../domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final Random _random = Random();

  @override
  int generateRandomNumber(int maxRange) {
    if (maxRange <= 0) {
      throw ArgumentError('Максимальный диапазон должен быть больше нуля.');
    }

    return _random.nextInt(maxRange) + 1;
  }
}

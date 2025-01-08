import '../repositories/game_repository.dart';

class GenerateRandomNumber {
  final GameRepository gameRepository;

  GenerateRandomNumber(this.gameRepository);

  int call(int maxRange) {
    return gameRepository.generateRandomNumber(maxRange);
  }
}

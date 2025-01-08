import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class InitialScreen extends StatelessWidget {
  final TextEditingController maxAttemptsController;
  final TextEditingController maxRangeController;
  final VoidCallback onStartGame;

  const InitialScreen({
    super.key,
    required this.maxAttemptsController,
    required this.maxRangeController,
    required this.onStartGame,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Угадай число',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Введите количество попыток и максимальный диапазон',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Количество попыток:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            MyTextField(
              hintText: 'Введите количество попыток',
              controller: maxAttemptsController,
            ),
            const SizedBox(height: 10),
            Text(
              'Максимальный диапазон:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            MyTextField(
              hintText: 'Введите максимальный диапазон',
              controller: maxRangeController,
            ),
            const SizedBox(height: 10),
            MyButton(
              buttonText: 'Начать игру',
              onTap: onStartGame,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class GameInProgressScreen extends StatelessWidget {
  final int attemptsLeft;
  final TextEditingController controller;
  final void Function(int guess) onSubmitGuess;

  const GameInProgressScreen({
    super.key,
    required this.attemptsLeft,
    required this.controller,
    required this.onSubmitGuess,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              hintText: 'Введите число',
              controller: controller,
            ),
            const SizedBox(height: 10),
            MyButton(
              buttonText: 'Проверить',
              onTap: () {
                final guess = int.tryParse(controller.text);
                if (guess != null) {
                  onSubmitGuess(guess);
                }
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Осталось попыток: $attemptsLeft',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

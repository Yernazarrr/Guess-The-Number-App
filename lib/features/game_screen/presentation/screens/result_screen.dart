import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class ResultScreen extends StatelessWidget {
  final String message;
  final Color color;
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.message,
    required this.color,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            MyButton(
              buttonText: 'Начать заново',
              onTap: onRestart,
            ),
          ],
        ),
      ),
    );
  }
}

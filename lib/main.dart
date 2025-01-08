import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/core/theme/theme.dart';

import 'features/game_screen/presentation/bloc/game_bloc.dart';
import 'features/game_screen/presentation/game_screen.dart';

void main() {
  runApp(const GuessTheNumberApp());
}

class GuessTheNumberApp extends StatelessWidget {
  const GuessTheNumberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guess the Number App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: BlocProvider(
        create: (context) => GameBloc(),
        child: const GameScreen(),
      ),
    );
  }
}

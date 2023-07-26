import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/logic/bloc_export.dart';
import 'package:quiz/presentation/home/home_screen.dart';
import 'package:quiz/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              QuestionCubit(repo: context.read<QuizRepository>())..loadQuiz(),
          child: const QuestionScreen(),
        ),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          spaceHeight(20),
          Image.asset(
            "assets/q.png",
            fit: BoxFit.contain,
            height: sH(context) / 2,
            width: sW(context) / 2,
          ),
          loading()
        ],
      ),
    );
  }
}

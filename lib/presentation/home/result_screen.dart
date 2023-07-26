import 'package:flutter/material.dart';
import 'package:quiz/presentation/splash/splash_screen.dart';
import 'package:quiz/utils/utils.dart';

class ResultScreen extends StatefulWidget {
  final String marks;
  const ResultScreen({required this.marks, super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              spaceHeight(80),
              Image.asset(
                "assets/w.png",
                height: 100,
                width: sW(context) / 2,
                fit: BoxFit.contain,
              ),
              spaceHeight(20),
              const Text(
                'Congrats',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              spaceHeight(20),
              Text('${widget.marks}/ 10',
                  style: const TextStyle(fontSize: 50, color: Colors.grey)),
              spaceHeight(20),
              const Text(
                "You did a great job ! Learn more by taking another quiz",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              spaceHeight(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      navigatorKey.currentState!.pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const SplashScreen(),
                          ),
                          (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 26, 65, 117),
                    ),
                    icon: const Icon(
                      Icons.timer,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Retake Quiz',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quiz/logic/bloc_export.dart';
import 'package:quiz/presentation/splash/splash_screen.dart';
import 'package:quiz/utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// bloc observe state change
  Bloc.observer = MyBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => QuizRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => QuestionAnswerCubit(),
          ),
        ],
        child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: "Qizo quiz",
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
              primaryColor: Colors.black,
              useMaterial3: true,
            ),
            home: const SplashScreen()),
      ),
    );
  }
}

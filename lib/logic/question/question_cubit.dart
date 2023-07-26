import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/logic/bloc_export.dart';
import 'package:quiz/models/quiz_model.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final QuizRepository repo;
  QuestionCubit({required this.repo}) : super(QuestionInitial());

  loadQuiz() async {
    try {
      emit(QuestionLoading());
      var res = await repo.startQuiz();
      emit(QuizQuestionsLoaded(questions: res.questions));
    } catch (e) {
      throw Exception;
    }
  }

  quizSubmit({required marks}) async {
    String mark = marks;

    emit(QuizSubmitLoading());

    await Future.delayed(const Duration(seconds: 2));
    emit(QuizSubmited(mark: mark));
  }
}

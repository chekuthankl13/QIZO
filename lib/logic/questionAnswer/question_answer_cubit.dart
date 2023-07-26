import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'question_answer_state.dart';

class QuestionAnswerCubit extends Cubit<QuestionAnswerState> {
  QuestionAnswerCubit() : super(QuestionAnswerInitial());

  int answerClicked({required correctAnswer, required selectedAnswer}) {
    if (selectedAnswer == correctAnswer) {
      emit(QuestionAnswerState(marks: state.marks + 1, isCorrect: true));

      log(state.marks.toString(), name: "state");
      return state.marks;
    } else {
      emit(QuestionAnswerState(marks: state.marks, isCorrect: false));
      return state.marks;
    }
  }
}

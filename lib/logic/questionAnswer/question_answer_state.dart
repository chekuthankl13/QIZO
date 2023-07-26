part of 'question_answer_cubit.dart';

class QuestionAnswerState extends Equatable {
  final int marks;
  final bool isCorrect;
  const QuestionAnswerState({this.isCorrect = false, this.marks = 0});

  @override
  List<Object> get props => [marks, isCorrect];
}

class QuestionAnswerInitial extends QuestionAnswerState {}

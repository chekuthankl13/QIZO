part of 'question_cubit.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

class QuizQuestionsLoaded extends QuestionState {
  final List<Questions> questions;
  const QuizQuestionsLoaded({
    required this.questions,
  });

  @override
  List<Object> get props => [questions];
}

class QuizSubmited extends QuestionState {
  final String mark;
  const QuizSubmited({
    required this.mark,
  });
  @override
  List<Object> get props => [mark];
}

class QuizSubmitLoading extends QuestionState {}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionModel {
  final List<Questions> questions;
  QuestionModel({
    required this.questions,
  });

  factory QuestionModel.fromJson(List<Map<String, dynamic>> json) =>
      QuestionModel(
          questions:
              List<Questions>.from((json).map((e) => Questions.fromJson(e))));
}

class Questions {
  final String id;
  final String cid;
  final String question;
  final String correctAnswer;
  final List<String> answers;
  final String category;

  Questions(
      {required this.id,
      required this.cid,
      required this.question,
      required this.correctAnswer,
      required this.answers,
      required this.category});

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
      id: json['id'],
      cid: json['category_id'],
      question: json['question'],
      correctAnswer: json['correctAnswer'],
      answers: List<String>.from(json['incorrectAnswers'])
        ..add(json['correctAnswer'])
        ..shuffle(),
      category: json['category']);
}

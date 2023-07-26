import 'package:quiz/config/dummy_data.dart';
import 'package:quiz/models/quiz_model.dart';

class QuizRepository {
  Future<QuestionModel> startQuiz() async {
    await Future.delayed(const Duration(seconds: 1));
    var k = questionList;
    var data = QuestionModel.fromJson(k);
    return data;
  }
}

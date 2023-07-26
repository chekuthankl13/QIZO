import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quiz/logic/bloc_export.dart';
import 'package:quiz/models/quiz_model.dart';
import 'package:quiz/presentation/home/result_screen.dart';
import 'package:quiz/utils/utils.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  ValueNotifier<int> pageIndex = ValueNotifier(0);

  ValueNotifier<int> length = ValueNotifier(0);
  ValueNotifier<String> selectedAn = ValueNotifier("");

  ValueNotifier<String> correctanswer = ValueNotifier("");

  var pagectrl = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz"),
        ),
        body: BlocConsumer<QuestionCubit, QuestionState>(
          listener: (context, state) {
            if (state is QuizSubmited) {
              navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
                builder: (context) => ResultScreen(marks: state.mark),
              ));
            }
          },
          builder: (context, state) {
            if (state is QuestionLoading) {
              return loading();
            }

            if (state is QuizQuestionsLoaded) {
              return body(state.questions);
            }

            return loading();
          },
        ));
  }

  body(List<Questions> questions) {
    length.value = questions.length - 1;
    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (value) {
            pageIndex.value = value;
          },
          physics: const NeverScrollableScrollPhysics(),
          controller: pagectrl,
          itemCount: questions.length,
          itemBuilder: (context, index) {
            var data = questions[index];
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // spaceHeight(sH(context) / 5),
                  spaceHeight(20),
                  Image.asset(
                    "assets/q.png",
                    height: sH(context) / 5,
                    width: sW(context) / 2,
                    fit: BoxFit.contain,
                  ),
                  spaceHeight(10),
                  Text(
                    data.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  spaceHeight(30),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: data.answers.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 60,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16),
                      itemBuilder: (context, index) {
                        var e = data.answers[index];
                        return ValueListenableBuilder(
                          valueListenable: selectedAn,
                          builder: (context, value, child) => GestureDetector(
                            onTap: () {
                              if (e != data.correctAnswer) {
                                errorToast(context,
                                    error: "sorry the answer is wrong !!");
                              } else {}
                              selectedAn.value = e;
                              correctanswer.value = data.correctAnswer;
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: value == e
                                    ? const Color.fromARGB(255, 26, 65, 117)
                                    : Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 2)
                                ],
                                border: Border.all(
                                    color: Colors.blueAccent.withOpacity(.7)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: value == e
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 45,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: pageIndex,
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                spaceWidth(10),
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      questions.length,
                      (index) => ValueListenableBuilder(
                            valueListenable: pageIndex,
                            builder: (context, value, child) => Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  color: value == index
                                      ? Colors.grey
                                      : Colors.grey[200],
                                  shape: BoxShape.circle),
                            ),
                          )),
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                  onPressed: () {
                    if (selectedAn.value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          behavior: SnackBarBehavior.floating,
                          content: Text("Please select the answer!!"),
                        ),
                      );
                    } else {
                      int m = context.read<QuestionAnswerCubit>().answerClicked(
                          correctAnswer: correctanswer.value,
                          selectedAnswer: selectedAn.value);
                      correctanswer.value = "";
                      selectedAn.value = "";
                      forward(m);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(70, 30),
                      padding: const EdgeInsets.all(0),
                      backgroundColor: const Color.fromARGB(255, 26, 65, 117),
                      foregroundColor: Colors.white),
                  child: ValueListenableBuilder(
                    valueListenable: pageIndex,
                    builder: (context, values, child) => values == length.value
                        ? const Text(
                            "Submit",
                            style: TextStyle(fontSize: 10),
                          )
                        : const Text(
                            "Next",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                  ),
                ),
                spaceWidth(10)
              ],
            ),
          ),
        ),
      ],
    );
  }

  forward(int m) {
    if (islastpage) {
      context.read<QuestionCubit>().quizSubmit(marks: m.toString());

      log("last page");
    } else {
      pagectrl.animateToPage(pagectrl.page!.toInt() + 1,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  bool get islastpage => pageIndex.value == length.value;
}

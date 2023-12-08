import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app_api/model/quiz_model/quiz_model.dart';

class QuizController extends ChangeNotifier {
  List? questions;
  bool isLoading = true;
  int questionIndex = 0;
  bool isCorrect = false;
  double score = 0;
  bool canSelect = true;
  bool goNext = false;
  int crctAnswers = 0;
  getData() async {
    isLoading = true;
    final url =
        Uri.parse('https://nice-lime-hippo-wear.cyclic.app/api/v1/quiz');
    final response = await http.get(url);
    final decodeData = jsonDecode(response.body);
    questions = decodeData.map((e) => QuizModel.fromJson(e)).toList();
    isLoading = false;
    notifyListeners();
    return questions;
  }

  nextQuestion() {
    if (questionIndex < questions!.length - 1) {
      questionIndex++;
      notifyListeners();
    }
  }

  checkAnswer(int index) {
    if (questions![questionIndex].options[index].isCorrect == true) {
      isCorrect = true;
      crctAnswers += 1;
    } else {
      isCorrect = false;
    }
  }

  scoreCalculator() {
    score = ((crctAnswers / questions!.length) * 100).roundToDouble();
  }

  tryAgain() {
    questionIndex = 0;
    isCorrect = false;
    score = 0;
    canSelect = true;
    goNext = false;
    crctAnswers = 0;
    notifyListeners();
  }
}

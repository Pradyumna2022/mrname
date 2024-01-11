// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

List<QuizModel> quizModelFromJson(String str) => List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));

String quizModelToJson(List<QuizModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizModel {
  var id;
  var questionTextEnglish;
  var questionTextHindi;
  var optionAEnglish;
  var optionAHindi;
  var optionBEnglish;
  var optionBHindi;
  var correctOption;

  QuizModel({
    this.id,
    this.questionTextEnglish,
    this.questionTextHindi,
    this.optionAEnglish,
    this.optionAHindi,
    this.optionBEnglish,
    this.optionBHindi,
    this.correctOption,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    id: json["id"],
    questionTextEnglish: json["question_text_english"],
    questionTextHindi: json["question_text_hindi"],
    optionAEnglish: json["option_a_english"],
    optionAHindi: json["option_a_hindi"],
    optionBEnglish: json["option_b_english"],
    optionBHindi: json["option_b_hindi"],
    correctOption: json["correct_option"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_text_english": questionTextEnglish,
    "question_text_hindi": questionTextHindi,
    "option_a_english": optionAEnglish,
    "option_a_hindi": optionAHindi,
    "option_b_english": optionBEnglish,
    "option_b_hindi": optionBHindi,
    "correct_option": correctOption,
  };
}

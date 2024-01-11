
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/question_model.dart';
class ApiServices{

  static Future<List?> getApi()async{
     try{
       var response = await http.get(Uri.parse('https://quiz.dailytest.in/api/questions'));
       print(response.body);
       if(response.statusCode == 200){
         return quizModelFromJson(response.body);
       }else{
         return null;
       }
     }catch(e){
       print(e.toString() +'..................................................');
     }
  }
}
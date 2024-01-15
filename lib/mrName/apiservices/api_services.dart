
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/question_controller.dart';
import '../model/question_model.dart';
class ApiServices{

  static Future<List<dynamic>?> getApi()async{
     try{
       var response = await http.get(Uri.parse('https://quiz.dailytest.in/api/questions'));

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
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrname/mrName/controller/question_controller.dart';
import 'package:mrname/mrName/views/total_question_collections.dart';

import 'conponets/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    super.initState();
    print('THIS IS SPLASH SCRENEN ________________________________________________');
    productController.fetchData();
    setState(() {

    });
    print('THIS IS SPLASH SCRENEN ________________________________________________');
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TotalQuestionCollections()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("MrName",
                  style: splashTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

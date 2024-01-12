import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mrname/mrName/views/total_question_collections.dart';
import 'conponets/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TotalQuestionCollections()), (route) => false);
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

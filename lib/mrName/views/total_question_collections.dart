import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrname/mrName/apiservices/api_services.dart';
import 'package:mrname/mrName/model/question_model.dart';

import '../conponets/constant.dart';
import '../controller/question_controller.dart';

class TotalQuestionCollections extends StatefulWidget {
  const TotalQuestionCollections({Key? key}) : super(key: key);

  @override
  State<TotalQuestionCollections> createState() =>
      _TotalQuestionCollectionsState();
}

//   CLASS OF THE QUESTION VARIABLES **************
class QuestionData {
  int? tappedQuestionIndex;
  int? selectedQuestionIndex;
  int? correctAnswer = 1;
  bool isCheckedQuestion = true;
  bool isQuestionsLocked = false;
}

class _TotalQuestionCollectionsState extends State<TotalQuestionCollections> {
  ProductController productController = Get.put(ProductController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  List<QuestionData> questionDataList = List.generate(
      10, (_) => QuestionData()); // Assuming there are 10 questions


  Future<void> _onRefresh() async {
    try {
      List<QuizModel>? newData = await ApiServices.getApi() as List<QuizModel>?;
      if (newData != null) {
        setState(() {
          // Convert the regular list to RxList
          productController.productList.assignAll(newData);

          // Update your questionDataList or any other state variables with the new data
          // For example:
          questionDataList = List.generate(newData.length, (_) => QuestionData());
        });
      }
    } catch (e) {
      print('Error refreshing data: $e');
    }
  }






  Color getAnswerColor(int questionIndex, int answerIndex,int correctAnswer) {
    QuestionData questionData = questionDataList[questionIndex];
    if (questionData.selectedQuestionIndex == answerIndex) {
      print("TURE WALA QUESTION NO : "+questionData.selectedQuestionIndex.toString()+"   ============== ANSWER INDEX: "+answerIndex.toString()+" ===========  CorrectOption: "+correctAnswer.toString());
      return (correctAnswer+1) == answerIndex
          ? Colors.green
          : Colors.red;
    } else {
      print("FALSE WALA QUESTION NO : "+questionData.selectedQuestionIndex.toString()+"   ============== ANSWER INDEX: "+answerIndex.toString()+" ===========  CorrectOption: "+correctAnswer.toString());
      return questionData.isQuestionsLocked
          ? Colors.black
          : (questionData.tappedQuestionIndex == answerIndex
              ? Color(0xffE6E5E4)
              : Colors.black);
    }
  }

  Color getTextColor(int questionIndex, int answerIndex) {
    QuestionData questionData = questionDataList[questionIndex];
    if (questionData.selectedQuestionIndex == answerIndex) {
      return Colors.white;
    } else {
      return questionData.isQuestionsLocked
          ? Colors.white
          : (questionData.tappedQuestionIndex == answerIndex
              ? Colors.black
              : Colors.white);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('THIS IS INIT METHOD ');

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          strokeWidth: 2,
          backgroundColor: Colors.black,
          color: Colors.white,
          key: _refreshIndicatorKey,
          onRefresh: _onRefresh,
          child: WillPopScope(
            onWillPop: () => _showExitMessage(context),
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 7,
                  color: Colors.white,
                  backgroundColor: Colors.black,
                ));
              } else {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text(
                        'MrName',
                        style: appBarTextStyle,
                      ),
                      leading: Text(""),
                      centerTitle: true,
                      pinned: false,
                      backgroundColor: Colors.black,
                      floating: true,
                      expandedHeight: 50.0,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        if(productController.productList.isEmpty)
                          Center(
                            child: Column(
                              children: [
                                Image.asset('assets/images/nodata.jpg'),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        if(productController.productList.isNotEmpty)

                        ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: productController.productList.length,
                          itemBuilder: (context, index) {
                            QuestionData questionData = questionDataList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    width: MediaQuery.sizeOf(context).width,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // *********  ENGLISH QUESTION ********
                                        Text(
                                            productController.productList[index]
                                                .questionTextEnglish
                                                .toString(),
                                            style: questionTitleStyle),
                                        // *********  HINDI QUESTION ********
                                        Text(
                                            productController.productList[index]
                                                .questionTextHindi
                                                .toString(),
                                            style: questionTitleStyle),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),

                                  // ***************  EVERY QUESTION OPTION HERE ! ********
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //***********   FIRST OPTION  ***********
                                          InkWell(
                                            onTap: () {
                                              if (!questionData.isQuestionsLocked) {
                                                setState(() {
                                                  questionData.tappedQuestionIndex =
                                                      1;
                                                });
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 5),
                                              width: 250,
                                              decoration: BoxDecoration(
                                                color: getAnswerColor(index, 1, int.parse(productController.productList[index].correctOption)),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        productController
                                                            .productList[index]
                                                            .optionAEnglish
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.josefinSans(
                                                                fontSize: 15,
                                                                color: getTextColor(
                                                                    index, 1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                    Text(
                                                        productController
                                                            .productList[index]
                                                            .optionAHindi
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.josefinSans(
                                                                fontSize: 15,
                                                                color: getTextColor(
                                                                    index, 1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          //***********   SECOND OPTION ***********
                                          InkWell(
                                            onTap: () {
                                              if (!questionData.isQuestionsLocked) {
                                                setState(() {
                                                  questionData.tappedQuestionIndex =
                                                      2;
                                                });
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 20),
                                              width: 250,
                                              decoration: BoxDecoration(
                                                color: getAnswerColor(index, 2, int.parse(productController.productList[index].correctOption)),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        productController
                                                            .productList[index]
                                                            .optionBEnglish
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.josefinSans(
                                                                fontSize: 15,
                                                                color: getTextColor(
                                                                    index, 2),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                    Text(
                                                        productController
                                                            .productList[index]
                                                            .optionBHindi
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.josefinSans(
                                                                fontSize: 15,
                                                                color: getTextColor(
                                                                    index, 2),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      //***************   LOCK OF THE QUESTION ****************
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            if (questionData.tappedQuestionIndex !=
                                                    null &&
                                                !questionData.isQuestionsLocked) {
                                              setState(() {
                                                questionData.selectedQuestionIndex =
                                                    questionData
                                                        .tappedQuestionIndex;
                                                questionData.isQuestionsLocked =
                                                    true;
                                                print(questionData.correctAnswer
                                                        .toString() +
                                                    ">>>>>>>>>  this is your correct answer");
                                                print(questionData
                                                        .selectedQuestionIndex
                                                        .toString() +
                                                    '>>>>>>>  this is your selected index');
                                                print(questionData
                                                        .tappedQuestionIndex
                                                        .toString() +
                                                    ">>>>>>   this is your tapped index");
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 138,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: questionData.isQuestionsLocked
                                                  ? Image.asset(
                                                      'assets/icons/lock.png',
                                                      color: Colors.white,
                                                      scale: 15,
                                                    )
                                                  : Image.asset(
                                                      'assets/icons/unlock.png',
                                                      color: Colors.white,
                                                      scale: 15,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ]),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  //   ********************  THIS IS FOR SHOW DIALOG HERE! ************
  Future<bool> _showExitMessage(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: RichText(
          text: TextSpan(
            style: showContextHeadStyle,
            children: [
              TextSpan(text: 'Are you sure you want to exit? '),

              WidgetSpan(
                child:
                Image.asset(
                  'assets/icons/sad.gif',
                  height: 35.0, // Adjust height as needed
                  width: 35.0, // Adjust width as needed
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
                color: Colors.red,borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(2),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No',style: showContextConfirmationStyle,),
            ),
          ),

          Container(
            decoration: BoxDecoration(
                color: Colors.green,borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(2),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes',style: showContextConfirmationStyle,),
            ),
          ),
        ],
      ),
    )) ??
        false;
  }
  // Future<bool> _showExitMessage(BuildContext context) async {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Row(
  //         children: [
  //           Text('Are you sure you want to exit?'),
  //           SizedBox(width: 8.0),
  //           Image.asset(
  //             'assets/icons/sad.gif',
  //             height: 35.0, // Adjust height as needed
  //             width: 35.0, // Adjust width as needed
  //           ),
  //         ],
  //       ),
  //       duration: Duration(seconds: 4), // Adjust duration as needed
  //       action: SnackBarAction(
  //         label: 'Yes',
  //         onPressed: () {
  //           // Handle Yes button press
  //           Navigator.of(context).pop(true);
  //         },
  //       ),
  //     ),
  //   );
  //
  //   // Automatically dismiss the Snackbar after 4 seconds
  //   await Future.delayed(Duration(seconds: 4));
  //
  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //
  //   // Return true to allow the back navigation
  //   return true;
  // }
  }

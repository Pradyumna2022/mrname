// import 'dart:async';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:mrname/mrName/apiservices/api_services.dart';
// import 'package:mrname/mrName/model/question_model.dart';
//
// import 'mrName/conponets/question_data.dart';
// import 'mrName/controller/question_controller.dart';
//
// class hhfsdf extends StatefulWidget {
//   const hhfsdf({Key? key}) : super(key: key);
//
//   @override
//   State<hhfsdf> createState() =>
//       _hhfsdfState();
// }
//
// //   CLASS OF THE QUESTION VARIABLES **************
//
//
// class _hhfsdfState extends State<hhfsdf> {
//   late ConnectivityResult _connectivityResult;
//   ProductController productController = Get.put(ProductController());
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//   GlobalKey<RefreshIndicatorState>();
//   List<QuestionData> questionDataList =
//   List.generate(100000, (_) => QuestionData());
//
//   // Future<void> _onRefresh() async {
//   //   try {
//   //     List<QuizModel>? newData = await ApiServices.getApi() as List<QuizModel>?;
//   //     if (newData != null) {
//   //       setState(() {
//   //         // Convert the regular list to RxList
//   //         productController.productList.assignAll(newData);
//   //
//   //         // Update your questionDataList or any other state variables with the new data
//   //         // For example:
//   //         questionDataList =
//   //             List.generate(newData.length, (_) => QuestionData());
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print('Error refreshing data: $e');
//   //   }
//   // }
//   Future<void> _onRefresh() async {
//     try {
//       // Check connectivity before making the API call
//       if (_connectivityResult != ConnectivityResult.none) {
//         List<QuizModel>? newData = await ApiServices.getApi() as List<QuizModel>?;
//         if (newData != null) {
//           setState(() {
//             // Convert the regular list to RxList
//             productController.productList.assignAll(newData);
//
//             // Update your questionDataList or any other state variables with the new data
//             // For example:
//             questionDataList =
//                 List.generate(newData.length, (_) => QuestionData());
//           });
//         }
//       }
//     } catch (e) {
//       print('Error refreshing data: $e');
//     }
//   }
//   Color getAnswerColor(int questionIndex, int answerIndex, int correctAnswer) {
//     QuestionData questionData = questionDataList[questionIndex];
//     if (questionData.selectedQuestionIndex == answerIndex) {
//       print("TURE WALA QUESTION NO : " +
//           questionData.selectedQuestionIndex.toString() +
//           "   ============== ANSWER INDEX: " +
//           answerIndex.toString() +
//           " ===========  CorrectOption: " +
//           correctAnswer.toString());
//       return (correctAnswer + 1) == answerIndex
//           ? Color(0xff70BC2F)
//           : Color(0xffF3830D);
//     } else {
//       print("FALSE WALA QUESTION NO : " +
//           questionData.selectedQuestionIndex.toString() +
//           "   ============== ANSWER INDEX: " +
//           answerIndex.toString() +
//           " ===========  CorrectOption: " +
//           correctAnswer.toString());
//       return questionData.isQuestionsLocked
//           ? Theme.of(context).brightness == Brightness.dark
//           ? Color(0xff1D1D1D)
//           : Color(0xffE6E5E4)
//           : (questionData.tappedQuestionIndex == answerIndex
//           ? Theme.of(context).brightness == Brightness.dark
//           ? Color(0xffE6E5E4)
//           : Colors.black
//           : Theme.of(context).brightness == Brightness.dark
//           ? Color(0xff1D1D1D)
//           : Color(0xffE6E5E4));
//     }
//   }
//
//   Color getTextColor(int questionIndex, int answerIndex) {
//     QuestionData questionData = questionDataList[questionIndex];
//     if (questionData.selectedQuestionIndex == answerIndex) {
//       return Colors.white;
//     } else {
//       return questionData.isQuestionsLocked
//           ? Theme.of(context).brightness == Brightness.dark
//           ? Colors.white
//           : Colors.black
//           : (questionData.tappedQuestionIndex == answerIndex
//           ? Theme.of(context).brightness == Brightness.dark
//           ? Colors.black
//           : Colors.white
//           : Theme.of(context).brightness == Brightness.dark
//           ? Colors.white
//           : Colors.black);
//     }
//   }
//
//   DateTime? lastPressed;
//   Future<void> _initializeConnectivity() async {
//     _connectivityResult = await Connectivity().checkConnectivity();
//   }
//   void _subscribeToConnectivityChanges() {
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       setState(() {
//         _connectivityResult = result;
//       });
//
//       if (_connectivityResult == ConnectivityResult.mobile ||
//           _connectivityResult == ConnectivityResult.wifi) {
//         // Reload data when connectivity is available
//         _onRefresh();
//       }
//     });
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _initializeConnectivity();
//     _subscribeToConnectivityChanges();
//     productController.fetchData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).brightness == Brightness.dark
//             ? Colors.black
//             : Colors.white,
//         body: RefreshIndicator(
//           strokeWidth: 2,
//           backgroundColor: Theme.of(context).brightness == Brightness.dark
//               ? Colors.black
//               : Color(0xffE6E5E4),
//           color: Theme.of(context).brightness == Brightness.dark
//               ? Colors.white
//               : Colors.black,
//           key: _refreshIndicatorKey,
//           onRefresh: _onRefresh,
//           child: WillPopScope(
//             onWillPop: () async {
//               final now = DateTime.now();
//               final maxDuration = Duration(seconds: 2);
//               final isWarning = lastPressed == null ||
//                   now.difference(lastPressed!) > maxDuration;
//               if (isWarning) {
//                 lastPressed = DateTime.now();
//                 final snackBar = SnackBar(
//                     backgroundColor:
//                     Theme.of(context).brightness == Brightness.dark
//                         ? Colors.black
//                         : Colors.white,
//                     content: Row(
//                       children: [
//                         Text(
//                           "Double Tap to Close App              ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 19,
//                               fontFamily: 'Lora',
//                               color: Theme.of(context).brightness == Brightness.dark
//                                   ? Colors.white
//                                   : Colors.black),
//                         ),
//                         Spacer(),
//                         Image.asset('assets/icons/sad.gif',scale: 20,)
//                       ],
//                     ));
//                 ScaffoldMessenger.of(context)
//                   ..removeCurrentSnackBar()
//                   ..showSnackBar(snackBar);
//                 return false;
//               } else {
//                 return true;
//               }
//             },
//             child: Obx(() {
//               if (productController.isLoading.value) {
//                 return
//                   Center(
//                     child: LoadingAnimationWidget.discreteCircle(
//                       size: 50, color: Colors.pink,
//                       secondRingColor : Colors.deepPurpleAccent,
//                       thirdRingColor: Colors.yellow
//                     ),
//                   );
//                   // Center(
//                   //   child: CircularProgressIndicator(
//                   //     strokeWidth: 7,
//                   //     color: Theme.of(context).brightness == Brightness.dark
//                   //         ? Colors.black
//                   //         : Colors.white,
//                   //     backgroundColor:
//                   //     Theme.of(context).brightness == Brightness.dark
//                   //         ? Colors.white
//                   //         : Colors.black,
//                   //   ));
//               } else {
//                 return CustomScrollView(
//                   slivers: [
//                     SliverAppBar(
//                       title: Text(
//                         'Yara',
//                         style: TextStyle(
//                             fontSize: 25,
//                             color:
//                             Theme.of(context).brightness == Brightness.dark
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: 'Josef'),
//                       ),
//                       leading: Text(""),
//                       centerTitle: true,
//                       pinned: false,
//                       backgroundColor:
//                       Theme.of(context).brightness == Brightness.dark
//                           ? Colors.black
//                           : Colors.white,
//                       floating: true,
//                       expandedHeight: 50.0,
//                     ),
//                     SliverList(
//                       delegate: SliverChildListDelegate([
//                         if (productController.productList.isEmpty)
//                           Center(
//                               child: Column(
//                                 children: [
//
//                                   Center(child: Image.asset('assets/images/no in.gif')),
//                                   Center(
//                                     child: Text(
//                                       "Please Check Your Internet Connection",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontSize: 20
//                                       ),),
//                                   ),
//                                 ],
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                               )),
//                         if (productController.productList.isNotEmpty)
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: BouncingScrollPhysics(),
//                             itemCount: productController.productList.length,
//                             itemBuilder: (context, index) {
//                               QuestionData questionData =
//                               questionDataList[index];
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8.0, vertical: 10),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         color: Theme.of(context).brightness ==
//                                             Brightness.dark
//                                             ? Color(0xff1D1D1D)
//                                             : Color(0xffE6E5E4),
//                                         borderRadius: BorderRadius.circular(4),
//                                       ),
//                                       width: MediaQuery.sizeOf(context).width,
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 15.0, horizontal: 10),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           // *********  ENGLISH QUESTION ********
//                                           Text(
//                                               productController
//                                                   .productList[index]
//                                                   .questionTextEnglish
//                                                   .toString(),
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Theme.of(context)
//                                                       .brightness ==
//                                                       Brightness.dark
//                                                       ? Colors.white
//                                                       : Colors.black,
//                                                   fontWeight: FontWeight.w700)),
//                                           // *********  HINDI QUESTION ********
//                                           Text(
//                                               productController
//                                                   .productList[index]
//                                                   .questionTextHindi
//                                                   .toString(),
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Theme.of(context)
//                                                       .brightness ==
//                                                       Brightness.dark
//                                                       ? Colors.white
//                                                       : Colors.black,
//                                                   fontWeight: FontWeight.w700)),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//
//                                     // ***************  EVERY QUESTION OPTION HERE ! ********
//                                     Row(
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             //***********   FIRST OPTION  ***********
//                                             InkWell(
//                                               onTap: () {
//                                                 if (!questionData
//                                                     .isQuestionsLocked) {
//                                                   setState(() {
//                                                     questionData
//                                                         .tappedQuestionIndex = 1;
//                                                   });
//                                                 }
//                                               },
//                                               child: Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 15,
//                                                     horizontal: 5),
//                                                 width: 250,
//                                                 decoration: BoxDecoration(
//                                                   color: getAnswerColor(
//                                                       index,
//                                                       1,
//                                                       int.parse(
//                                                           productController
//                                                               .productList[
//                                                           index]
//                                                               .correctOption)),
//                                                   borderRadius:
//                                                   BorderRadius.circular(4),
//                                                 ),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 8.0),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                     CrossAxisAlignment
//                                                         .start,
//                                                     children: [
//                                                       Text(
//                                                           productController
//                                                               .productList[
//                                                           index]
//                                                               .optionAEnglish
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                               fontFamily:
//                                                               'Lora',
//                                                               fontSize: 15,
//                                                               color:
//                                                               getTextColor(
//                                                                   index, 1),
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .bold)),
//                                                       Text(
//                                                           productController
//                                                               .productList[
//                                                           index]
//                                                               .optionAHindi
//                                                               .toString(),
//                                                           style: GoogleFonts
//                                                               .josefinSans(
//                                                               fontSize: 15,
//                                                               color:
//                                                               getTextColor(
//                                                                   index,
//                                                                   1),
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w700)),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 5,
//                                             ),
//                                             //***********   SECOND OPTION ***********
//                                             InkWell(
//                                               onTap: () {
//                                                 if (!questionData
//                                                     .isQuestionsLocked) {
//                                                   setState(() {
//                                                     questionData
//                                                         .tappedQuestionIndex = 2;
//                                                   });
//                                                 }
//                                               },
//                                               child: Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 5,
//                                                     vertical: 13),
//                                                 width: 250,
//                                                 decoration: BoxDecoration(
//                                                   color: getAnswerColor(
//                                                       index,
//                                                       2,
//                                                       int.parse(
//                                                           productController
//                                                               .productList[
//                                                           index]
//                                                               .correctOption)),
//                                                   borderRadius:
//                                                   BorderRadius.circular(4),
//                                                 ),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 8.0),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                     CrossAxisAlignment
//                                                         .start,
//                                                     children: [
//                                                       Text(
//                                                           productController
//                                                               .productList[
//                                                           index]
//                                                               .optionBEnglish
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                               fontFamily:
//                                                               'Lora',
//                                                               fontSize: 15,
//                                                               color:
//                                                               getTextColor(
//                                                                   index, 2),
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w700)),
//                                                       Text(
//                                                           productController
//                                                               .productList[
//                                                           index]
//                                                               .optionBHindi
//                                                               .toString(),
//                                                           style: GoogleFonts
//                                                               .josefinSans(
//                                                               fontSize: 15,
//                                                               color:
//                                                               getTextColor(
//                                                                   index,
//                                                                   2),
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w700)),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Spacer(),
//                                         //***************   LOCK OF THE QUESTION ****************
//                                         InkWell(
//                                           onTap: () {
//                                             if (questionData
//                                                 .tappedQuestionIndex !=
//                                                 null &&
//                                                 !questionData
//                                                     .isQuestionsLocked) {
//                                               setState(() {
//                                                 questionData
//                                                     .selectedQuestionIndex =
//                                                     questionData
//                                                         .tappedQuestionIndex;
//                                                 questionData
//                                                     .isQuestionsLocked = true;
//                                                 print(questionData
//                                                     .correctAnswer
//                                                     .toString() +
//                                                     ">>>>>>>>>  this is your correct answer");
//                                                 print(questionData
//                                                     .selectedQuestionIndex
//                                                     .toString() +
//                                                     '>>>>>>>  this is your selected index');
//                                                 print(questionData
//                                                     .tappedQuestionIndex
//                                                     .toString() +
//                                                     ">>>>>>   this is your tapped index");
//                                               });
//                                             }
//                                           },
//                                           child: Container(
//                                             height: 128,
//                                             width: 60,
//                                             decoration: BoxDecoration(
//                                               color: Theme.of(context)
//                                                   .brightness ==
//                                                   Brightness.dark
//                                                   ? Color(0xff1D1D1D)
//                                                   : Color(0xffE6E5E4),
//                                               borderRadius:
//                                               BorderRadius.circular(4),
//                                             ),
//                                             child: Center(
//                                               child: questionData
//                                                   .isQuestionsLocked
//                                                   ? Image.asset(
//                                                 'assets/icons/lock.png',
//                                                 color: Theme.of(context)
//                                                     .brightness ==
//                                                     Brightness.dark
//                                                     ? Colors.white
//                                                     : Colors.black,
//                                                 scale: 15,
//                                               )
//                                                   : Image.asset(
//                                                 'assets/icons/unlock.png',
//                                                 color: Theme.of(context)
//                                                     .brightness ==
//                                                     Brightness.dark
//                                                     ? Colors.white
//                                                     : Colors.black,
//                                                 scale: 15,
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           )
//                       ]),
//                     ),
//                   ],
//                 );
//               }
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }

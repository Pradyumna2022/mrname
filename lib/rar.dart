// import 'dart:async';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mrname/mrName/apiservices/api_services.dart';
// import 'package:mrname/mrName/model/question_model.dart';
// import 'package:shimmer/shimmer.dart';
//
// import 'mrName/conponets/constant.dart';
// import 'mrName/conponets/question_data.dart';
// import 'mrName/controller/question_controller.dart';
//
// class newfile extends StatefulWidget {
//   const newfile({Key? key}) : super(key: key);
//
//   @override
//   State<newfile> createState() => _newfileState();
// }
//
// class _newfileState extends State<newfile> {
//   late ConnectivityResult _connectivityResult;
//   ProductController productController = Get.put(ProductController());
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//   List<QuestionData> questionDataList =
//       List.generate(100000, (_) => QuestionData());
//
//   Future<void> _onRefresh() async {
//     try {
//       // Check connectivity before making the API call
//       if (_connectivityResult != ConnectivityResult.none) {
//         List<QuizModel>? newData =
//             await ApiServices.getApi() as List<QuizModel>?;
//         if (newData != null) {
//           setState(() {
//             // Convert the regular list to RxList
//             productController.productList.clear();
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
//
//   Color getAnswerColor(int questionIndex, int answerIndex, int correctAnswer) {
//     QuestionData questionData = questionDataList[questionIndex];
//     if (questionData.selectedQuestionIndex == answerIndex) {
//       print("TURE WALA QUESTION NO : " +
//           questionData.selectedQuestionIndex.toString() +
//           "   ============== ANSWER INDEX: " +
//           answerIndex.toString() +
//           " ===========  CorrectOption: " +
//           correctAnswer.toString());
//       return (correctAnswer + 1) == answerIndex ? correctColor : wrongColor;
//     } else {
//       // print("FALSE WALA QUESTION NO : " +
//       //     questionData.selectedQuestionIndex.toString() +
//       //     "   ============== ANSWER INDEX: " +
//       //     answerIndex.toString() +
//       //     " ===========  CorrectOption: " +
//       //     correctAnswer.toString());
//       return questionData.isQuestionsLocked
//           ? Theme.of(context).brightness == Brightness.dark
//               ? darkQueOptionBackgroundColor
//               : lightQueOptionBackgroundColor
//           : (questionData.tappedQuestionIndex == answerIndex
//               ? Theme.of(context).brightness == Brightness.dark
//                   ? lightQueOptionBackgroundColor
//                   : blackColor
//               : Theme.of(context).brightness == Brightness.dark
//                   ? darkQueOptionBackgroundColor
//                   : lightQueOptionBackgroundColor);
//     }
//   }
//
//   Color getTextColor(int questionIndex, int answerIndex) {
//     QuestionData questionData = questionDataList[questionIndex];
//     if (questionData.selectedQuestionIndex == answerIndex) {
//       return whiteColor;
//     } else {
//       return questionData.isQuestionsLocked
//           ? Theme.of(context).brightness == Brightness.dark
//               ? whiteColor
//               : blackColor
//           : (questionData.tappedQuestionIndex == answerIndex
//               ? Theme.of(context).brightness == Brightness.dark
//                   ? blackColor
//                   : whiteColor
//               : Theme.of(context).brightness == Brightness.dark
//                   ? whiteColor
//                   : blackColor);
//     }
//   }
//
//   DateTime? lastPressed;
//   Future<void> _initializeConnectivity() async {
//     _connectivityResult = await Connectivity().checkConnectivity();
//   }
//
//   void _subscribeToConnectivityChanges() {
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       setState(() {
//         _connectivityResult = result;
//         print(_connectivityResult.toString() +
//             '-------------------------------------------');
//       });
//
//       if (_connectivityResult == ConnectivityResult.mobile ||
//           _connectivityResult == ConnectivityResult.wifi) {
//         // Reload data when connectivity is available
//         _onRefresh();
//       }
//     });
//   }
//
//   // bool isFirstTime =true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _initializeConnectivity();
//     productController.productList.clear();
//     _subscribeToConnectivityChanges();
//     Future.delayed(Duration(milliseconds: 300), () {
//       productController.productList.clear();
//       productController.fetchData();
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final mobileWidth = MediaQuery.of(context).size.width * 0.2;
//     final rotateWidth = MediaQuery.of(context).size.width * 0.1;
//     final mobileHeight = MediaQuery.of(context).size.height * 0.179;
//     final rotateHeight = MediaQuery.of(context).size.height * 0.38;
//     final mobileHeightForOption = MediaQuery.of(context).size.height * 0.088;
//     final rotateHeightForOption = MediaQuery.of(context).size.height * 0.185;
//     final mobileWidthForOption = MediaQuery.of(context).size.width * 0.74;
//     final rotateWidthForOption = MediaQuery.of(context).size.width * 0.87;
//     print(MediaQuery.of(context).size.height );
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).brightness == Brightness.dark
//             ? blackColor
//             : whiteColor,
//         body: RefreshIndicator(
//           strokeWidth: 2,
//           backgroundColor: Theme.of(context).brightness == Brightness.dark
//               ? blackColor
//               : lightQueOptionBackgroundColor,
//           color: Theme.of(context).brightness == Brightness.dark
//               ? whiteColor
//               : blackColor,
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
//                         Theme.of(context).brightness == Brightness.dark
//                             ? lightQueOptionBackgroundColor
//                             : darkQueOptionBackgroundColor,
//                     content: Text(
//                       "Double Tap to Close App",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 19,
//                           fontFamily: 'Lora',
//                           color: Theme.of(context).brightness == Brightness.dark
//                               ? blackColor
//                               : whiteColor),
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
//                 return shimmerEffect();
//               } else {
//                 return CustomScrollView(
//                   slivers: [
//                     SliverAppBar(
//                       title: Text(
//                         'jjjj',
//                         style: TextStyle(
//                             fontSize: 25,
//                             color:
//                                 Theme.of(context).brightness == Brightness.dark
//                                     ? whiteColor
//                                     : blackColor,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: 'Josef'),
//                       ),
//                       leading: Text(""),
//                       centerTitle: true,
//                       pinned: false,
//                       backgroundColor:
//                           Theme.of(context).brightness == Brightness.dark
//                               ? blackColor
//                               : whiteColor,
//                       floating: true,
//                       expandedHeight: 50.0,
//                     ),
//                     SliverList(
//                       delegate: SliverChildListDelegate([
//                         if (productController.productList.isEmpty)
//                           Center(
//                               child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Center(
//                                   child:
//                                       Image.asset('assets/images/no in.gif')),
//                               SizedBox(
//                                 height: 100,
//                               ),
//                               Center(
//                                   child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: RichText(
//                                   textAlign: TextAlign.center,
//                                   text: TextSpan(children: [
//                                     TextSpan(
//                                       text: 'Please Check Your',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 30,
//                                           color: Colors.white70),
//                                     ),
//                                     TextSpan(
//                                       text: ' Internet Connection',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 35,
//                                           color: Colors.yellow),
//                                     ),
//                                   ]),
//                                 ),
//                               )),
//                             ],
//                           )),
//                         if (productController.productList.isNotEmpty)
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: BouncingScrollPhysics(),
//                             itemCount: productController.productList.length,
//                             itemBuilder: (context, index) {
//                               QuestionData questionData =
//                                   questionDataList[index];
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8.0, vertical: 10),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         color: Theme.of(context).brightness ==
//                                                 Brightness.dark
//                                             ? darkQueOptionBackgroundColor
//                                             : lightQueOptionBackgroundColor,
//                                         borderRadius: BorderRadius.circular(4),
//                                       ),
//                                       width: MediaQuery.sizeOf(context).width,
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 15.0, horizontal: 10),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
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
//                                                               .brightness ==
//                                                           Brightness.dark
//                                                       ? whiteColor
//                                                       : blackColor,
//                                                   fontWeight: FontWeight.w700,
//                                                   fontFamily: 'Lora')),
//                                           // *********  HINDI QUESTION ********
//                                           Text(
//                                               productController
//                                                   .productList[index]
//                                                   .questionTextHindi
//                                                   .toString(),
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Theme.of(context)
//                                                               .brightness ==
//                                                           Brightness.dark
//                                                       ? whiteColor
//                                                       : blackColor,
//                                                   fontWeight: FontWeight.w700,
//                                                   fontFamily: 'Lora')),
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
//                                               CrossAxisAlignment.start,
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
//                                                 height:  (MediaQuery.of(context)
//                                                     .size
//                                                     .height <
//                                                     752)
//                                                     ? rotateHeightForOption:mobileHeightForOption,
//                                                 width: (MediaQuery.of(context)
//                                                     .size
//                                                     .width >
//                                                     360)
//                                                     ? rotateWidthForOption:mobileWidthForOption,
//                                                 decoration: BoxDecoration(
//                                                   color: getAnswerColor(
//                                                       index,
//                                                       1,
//                                                       int.parse(
//                                                           productController
//                                                               .productList[
//                                                                   index]
//                                                               .correctOption)),
//                                                   borderRadius:
//                                                       BorderRadius.circular(4),
//                                                 ),
//                                                 ///  NO PROBLEM HERE !!!!!!!!!!!!!!!!!!!!!!!!!!!  padding
//                                                 child: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 8.0),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                           productController
//                                                               .productList[
//                                                                   index]
//                                                               .optionAEnglish
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                               fontFamily:
//                                                                   'Lora',
//                                                               fontSize: 15,
//                                                               color:
//                                                                   getTextColor(
//                                                                       index, 1),
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold)),
//                                                       Text(
//                                                           productController
//                                                               .productList[
//                                                                   index]
//                                                               .optionAHindi
//                                                               .toString(),
//                                                           style: GoogleFonts
//                                                               .josefinSans(
//                                                                   fontSize: 15,
//                                                                   color:
//                                                                       getTextColor(
//                                                                           index,
//                                                                           1),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700)),
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
//
//                                                 height:  (MediaQuery.of(context)
//                                                     .size
//                                                     .height <
//                                                     752)
//                                                     ? rotateHeightForOption:mobileHeightForOption,
//                                                 width: (MediaQuery.of(context)
//                                                     .size
//                                                     .width >
//                                                     360)
//                                                     ? rotateWidthForOption:mobileWidthForOption,
//                                                 decoration: BoxDecoration(
//                                                   color: getAnswerColor(
//                                                       index,
//                                                       2,
//                                                       int.parse(
//                                                           productController
//                                                               .productList[
//                                                                   index]
//                                                               .correctOption)),
//                                                   borderRadius:
//                                                       BorderRadius.circular(4),
//                                                 ),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 8.0),
//                                                   child: Column(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                           productController
//                                                               .productList[
//                                                                   index]
//                                                               .optionBEnglish
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                               fontFamily:
//                                                                   'Lora',
//                                                               fontSize: 15,
//                                                               color:
//                                                                   getTextColor(
//                                                                       index, 2),
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700)),
//                                                       Text(
//                                                           productController
//                                                               .productList[
//                                                                   index]
//                                                               .optionBHindi
//                                                               .toString(),
//                                                           style: GoogleFonts
//                                                               .josefinSans(
//                                                                   fontSize: 15,
//                                                                   color:
//                                                                       getTextColor(
//                                                                           index,
//                                                                           2),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700)),
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
//                                                         .tappedQuestionIndex !=
//                                                     null &&
//                                                 !questionData
//                                                     .isQuestionsLocked) {
//                                               setState(() {
//                                                 questionData
//                                                         .selectedQuestionIndex =
//                                                     questionData
//                                                         .tappedQuestionIndex;
//                                                 questionData.isQuestionsLocked =
//                                                     true;
//                                                 print(questionData.correctAnswer
//                                                         .toString() +
//                                                     ">>>>>>>>>  this is your correct answer");
//                                                 print(questionData
//                                                         .selectedQuestionIndex
//                                                         .toString() +
//                                                     '>>>>>>>  this is your selected index');
//                                                 print(questionData
//                                                         .tappedQuestionIndex
//                                                         .toString() +
//                                                     ">>>>>>   this is your tapped index");
//                                               });
//                                             }
//                                           },
//                                           child: Container(
//                                             height:  (MediaQuery.of(context)
//                                                 .size
//                                                 .height <
//                                                 752)
//                                                 ? rotateHeight:mobileHeight,
//                                             width: (MediaQuery.of(context)
//                                                 .size
//                                                 .width >
//                                                 360)
//                                                 ? rotateWidth:mobileWidth,
//                                             decoration: BoxDecoration(
//                                               color: Theme.of(context)
//                                                           .brightness ==
//                                                       Brightness.dark
//                                                   ? darkQueOptionBackgroundColor
//                                                   : lightQueOptionBackgroundColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(4),
//                                             ),
//                                             child: Center(
//                                               child: questionData
//                                                       .isQuestionsLocked
//                                                   ? Image.asset(
//                                                       'assets/icons/lock.png',
//                                                       color: Theme.of(context)
//                                                                   .brightness ==
//                                                               Brightness.dark
//                                                           ? whiteColor
//                                                           : blackColor,
//                                                       scale: 15,
//                                                     )
//                                                   : Image.asset(
//                                                       'assets/icons/unlock.png',
//                                                       color: Theme.of(context)
//                                                                   .brightness ==
//                                                               Brightness.dark
//                                                           ? whiteColor
//                                                           : blackColor,
//                                                       scale: 15,
//                                                     ),
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
//
//   /// simmer effect code here !
//   Widget shimmerEffect() {
//     return Column(
//       children: [
//         Shimmer.fromColors(
//           child: Container(
//             // Customize the shimmer container as per your UI
//             width: MediaQuery.sizeOf(context).width,
//             height: MediaQuery.sizeOf(context).height * 0.1,
//             decoration: BoxDecoration(
//               color: Colors.white, // Customize as needed
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//           baseColor: Theme.of(context).brightness == Brightness.dark
//               ? darkQueOptionBackgroundColor
//               : lightQueOptionBackgroundColor,
//           highlightColor: Theme.of(context).brightness == Brightness.dark
//               ? whiteColor
//               : blackColor,
//         ),
//         SizedBox(height: 5),
//         Expanded(
//           child: ListView.builder(
//             itemCount: 10, // You can adjust the number of shimmer items
//             itemBuilder: (context, index) {
//               return Shimmer.fromColors(
//                 baseColor: Theme.of(context).brightness == Brightness.dark
//                     ? darkQueOptionBackgroundColor
//                     : lightQueOptionBackgroundColor,
//                 highlightColor: Theme.of(context).brightness == Brightness.dark
//                     ? whiteColor
//                     : blackColor,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//                   child: Column(
//                     children: [
//                       Container(
//                         // Customize the shimmer container as per your UI
//                         width: MediaQuery.sizeOf(context).width,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: Colors.white, // Customize as needed
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 // Customize the shimmer container as per your UI
//                                 width: 250,
//                                 height: 70,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white, // Customize as needed
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 margin: EdgeInsets.only(bottom: 6),
//                               ),
//                               Container(
//                                 // Customize the shimmer container as per your UI
//                                 width: 250,
//                                 height: 70,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white, // Customize as needed
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Spacer(),
//                           Container(
//                             height: 145,
//                             width: 60,
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).brightness ==
//                                       Brightness.dark
//                                   ? darkQueOptionBackgroundColor
//                                   : lightQueOptionBackgroundColor,
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

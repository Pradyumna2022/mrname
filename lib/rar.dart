// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'mrName/conponets/constant.dart';
//
// class TotalQuestionCollections extends StatefulWidget {
//   const TotalQuestionCollections({Key? key}) : super(key: key);
//
//   @override
//   State<TotalQuestionCollections> createState() =>
//       _TotalQuestionCollectionsState();
// }
//
// //   CLASS OF THE QUESTION VARIABLES **************
// class QuestionData {
//   int? tappedQuestionIndex;
//   int? selectedQuestionIndex;
//   int correctAnswer = 1;
//   bool isCheckedQuestion = true;
//   bool isQuestionsLocked = false;
// }
//
// class _TotalQuestionCollectionsState extends State<TotalQuestionCollections> {
//   ProductController productController = Get.put(ProductController());
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//   GlobalKey<RefreshIndicatorState>();
//   List<QuestionData> questionDataList = List.generate(
//       10, (_) => QuestionData()); // Assuming there are 10 questions
//
//   Color getAnswerColor(int questionIndex, int answerIndex) {
//     QuestionData questionData = questionDataList[questionIndex];
//     if (questionData.selectedQuestionIndex == answerIndex) {
//       return questionData.correctAnswer == answerIndex
//           ? Colors.green
//           : Colors.red;
//     } else {
//       return questionData.isQuestionsLocked
//           ? Colors.black
//           : (questionData.tappedQuestionIndex == answerIndex
//           ? Color(0xffE6E5E4)
//           : Colors.black);
//     }
//   }
//
//   Color getTextColor(int questionIndex, int answerIndex) {
//     QuestionData questionData = questionDataList[questionIndex];
//     if (questionData.selectedQuestionIndex == answerIndex) {
//       return Colors.white;
//     } else {
//       return questionData.isQuestionsLocked
//           ? Colors.white
//           : (questionData.tappedQuestionIndex == answerIndex
//           ? Colors.black
//           : Colors.white);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: RefreshIndicator(
//
//           backgroundColor: Colors.red,
//           color: Colors.yellow,
//           key: _refreshIndicatorKey,
//           onRefresh: () async {
//             // Replace this delay with the code to be executed during refresh
//             // and return a Future when code finishes execution.
//             return Future<void>.delayed(const Duration(seconds: 3));
//           },
//           child: Obx(() {
//             if (productController.isLoading.value) {
//               return Center(
//                   child: CircularProgressIndicator(
//                     strokeWidth: 7,
//                     color: Colors.white,
//                     backgroundColor: Colors.black,
//                   ));
//             } else {
//               return CustomScrollView(
//                 slivers: [
//                   SliverAppBar(
//                     title: Text(
//                       'MrName',
//                       style: appBarTextStyle,
//                     ),
//                     leading: Text(""),
//                     centerTitle: true,
//                     pinned: false,
//                     backgroundColor: Colors.black,
//                     floating: true,
//                     expandedHeight: 50.0,
//                   ),
//                   SliverList(
//                     delegate: SliverChildListDelegate([
//                       if(productController.productList.value.isEmpty)
//                         Center(
//                           child: Column(
//                             children: [
//                               Image.asset('assets/images/nodata.jpg'),
//                             ],
//                             mainAxisAlignment: MainAxisAlignment.center,
//                           ),
//                         ),
//                       if(productController.productList.value.isNotEmpty)
//                         ListView.builder(
//                           shrinkWrap: true,
//                           physics: BouncingScrollPhysics(),
//                           itemCount: productController.productList.length,
//                           itemBuilder: (context, index) {
//                             QuestionData questionData = questionDataList[index];
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8.0, vertical: 10),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.black,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     width: MediaQuery.sizeOf(context).width,
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 20.0, horizontal: 10),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         // *********  ENGLISH QUESTION ********
//                                         Text(
//                                             productController.productList[index]
//                                                 .questionTextEnglish
//                                                 .toString(),
//                                             style: questionTitleStyle),
//                                         // *********  HINDI QUESTION ********
//                                         Text(
//                                             productController.productList[index]
//                                                 .questionTextHindi
//                                                 .toString(),
//                                             style: questionTitleStyle),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 5),
//
//                                   // ***************  EVERY QUESTION OPTION HERE ! ********
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           //***********   FIRST OPTION  ***********
//                                           InkWell(
//                                             onTap: () {
//                                               if (!questionData.isQuestionsLocked) {
//                                                 setState(() {
//                                                   questionData.tappedQuestionIndex =
//                                                   1;
//                                                 });
//                                               }
//                                             },
//                                             child: Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 20, horizontal: 5),
//                                               width: 250,
//                                               decoration: BoxDecoration(
//                                                 color: getAnswerColor(index, 1),
//                                                 borderRadius:
//                                                 BorderRadius.circular(20),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     horizontal: 8.0),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                         productController
//                                                             .productList[index]
//                                                             .optionAEnglish
//                                                             .toString(),
//                                                         style:
//                                                         GoogleFonts.josefinSans(
//                                                             fontSize: 15,
//                                                             color: getTextColor(
//                                                                 index, 1),
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w700)),
//                                                     Text(
//                                                         productController
//                                                             .productList[index]
//                                                             .optionAHindi
//                                                             .toString(),
//                                                         style:
//                                                         GoogleFonts.josefinSans(
//                                                             fontSize: 15,
//                                                             color: getTextColor(
//                                                                 index, 1),
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w700)),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           //***********   SECOND OPTION ***********
//                                           InkWell(
//                                             onTap: () {
//                                               if (!questionData.isQuestionsLocked) {
//                                                 setState(() {
//                                                   questionData.tappedQuestionIndex =
//                                                   2;
//                                                 });
//                                               }
//                                             },
//                                             child: Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 5, vertical: 20),
//                                               width: 250,
//                                               decoration: BoxDecoration(
//                                                 color: getAnswerColor(index, 2),
//                                                 borderRadius:
//                                                 BorderRadius.circular(20),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     horizontal: 8.0),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                         productController
//                                                             .productList[index]
//                                                             .optionBEnglish
//                                                             .toString(),
//                                                         style:
//                                                         GoogleFonts.josefinSans(
//                                                             fontSize: 15,
//                                                             color: getTextColor(
//                                                                 index, 2),
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w700)),
//                                                     Text(
//                                                         productController
//                                                             .productList[index]
//                                                             .optionBHindi
//                                                             .toString(),
//                                                         style:
//                                                         GoogleFonts.josefinSans(
//                                                             fontSize: 15,
//                                                             color: getTextColor(
//                                                                 index, 2),
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w700)),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       //***************   LOCK OF THE QUESTION ****************
//                                       Padding(
//                                         padding: const EdgeInsets.only(right: 8.0),
//                                         child: InkWell(
//                                           onTap: () {
//                                             if (questionData.tappedQuestionIndex !=
//                                                 null &&
//                                                 !questionData.isQuestionsLocked) {
//                                               setState(() {
//                                                 questionData.selectedQuestionIndex =
//                                                     questionData
//                                                         .tappedQuestionIndex;
//                                                 questionData.isQuestionsLocked =
//                                                 true;
//                                                 print(questionData.correctAnswer
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
//                                             height: 138,
//                                             width: 60,
//                                             decoration: BoxDecoration(
//                                               color: Colors.black,
//                                               borderRadius:
//                                               BorderRadius.circular(8),
//                                             ),
//                                             child: Center(
//                                               child: questionData.isQuestionsLocked
//                                                   ? Image.asset(
//                                                 'assets/icons/lock.png',
//                                                 color: Colors.white,
//                                                 scale: 15,
//                                               )
//                                                   : Image.asset(
//                                                 'assets/icons/unlock.png',
//                                                 color: Colors.white,
//                                                 scale: 15,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         )
//                     ]),
//                   ),
//                 ],
//               );
//             }
//           }),
//         ),
//       ),
//     );
//   }
// }

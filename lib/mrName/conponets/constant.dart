import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//    *********  FOR STYLING HERE ***********
TextStyle getSplashTextStyle(BuildContext context) {
 return TextStyle(
  fontSize: 45,
  color: Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black,
  fontWeight: FontWeight.w700,
  fontFamily: 'Josef',
 );
}

TextStyle appBarTextStyle = TextStyle(
    fontSize: 25,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: 'Josef'
);

TextStyle questionTitleStyle = GoogleFonts.josefinSans(
    fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700
);

TextStyle showContextHeadStyle = GoogleFonts.josefinSans(
    fontSize: 22,color: Colors.deepPurple,fontWeight: FontWeight.w700
);

TextStyle showContextConfirmationStyle = GoogleFonts.josefinSans(
    fontSize: 16,color: Colors.white,fontWeight: FontWeight.w700
);


/// ************************  COLOR COMBINATION OF THE APP

const Color correctColor = Color(0xff70BC2F);
const Color wrongColor = Color(0xffF3830D);
const Color darkQueOptionBackgroundColor = Color(0xff1D1D1D);
const Color lightQueOptionBackgroundColor = Color(0xffE6E5E4);
const Color blackColor = Colors.black;
const Color whiteColor = Colors.white;


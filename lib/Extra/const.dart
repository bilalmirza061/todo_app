import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Extra/color.dart';

class AppConst{
  static List<BoxShadow> shadow() {
    return [
      BoxShadow(
        color: AppColor.shadowColor,
        blurRadius: 10,
        offset: const Offset(0, 3), // Shadow position
      ),
    ];
  }

  static poppins({FontWeight? weight, double? size, Color? color, double? height}) {
    return GoogleFonts.poppins(
    fontWeight: weight,
    fontSize: size,
    color: color,
    height: height
    );
  }

  static customGap({double? val}){
    return SizedBox(height: val);
  }


}
import 'package:flutter/material.dart';

class Utils{
  static hGap(double val){
    return SizedBox(
      width: val,
      height: 0,
    );
  }

  static vGap(double val){
    return SizedBox(
      height: val,
      width: 0,
    );
  }

  static openDialog(BuildContext ctx, Widget wid){
    showDialog(context: ctx, builder: (ctx)=> wid);

  }

  static showError(BuildContext ctx, String msg){
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
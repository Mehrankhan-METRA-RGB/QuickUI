import 'package:flutter/material.dart';

class AppDialog{
  static Future<void> dialog(BuildContext context, Widget child) async {
    return showDialog<void>(
      context: context,
       barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          content: child,
        );
      },
    );
  }


}
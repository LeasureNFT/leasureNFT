import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leasure_nft/app/core/app_colors.dart';

class MessageToast {
  static showToast({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      fontSize: 12,
    );
  }
}

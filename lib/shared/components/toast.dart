import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast({required toastMsg}) {
  Fluttertoast.showToast(
      msg: toastMsg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: null,
      textColor: Colors.white,
      fontSize: 16.0);
}

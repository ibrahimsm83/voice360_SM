import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomToast {
  static showToast(String body, bool error) {
    Get.showSnackbar(
      GetSnackBar(
        barBlur: 5,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        title: error ? "Error" : "Success",
        message: body,
        backgroundColor: error == true
            ? Colors.redAccent
            : Theme.of(Get.context!).primaryColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

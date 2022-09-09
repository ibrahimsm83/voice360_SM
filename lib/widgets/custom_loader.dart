import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomLoader {
  static void showLoader() {
    Get.dialog(CustomLoading(), barrierColor: Colors.transparent);
  }

  static void dismisLoader() {
    if (Get.isOverlaysOpen) {
      Get.back();
    }
  }
}

class CustomLoading extends StatefulWidget {
  CustomLoading({Key? key}) : super(key: key);

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0),
        body: Center(
          child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 22,
                    spreadRadius: 14)
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Lottie.asset('assets/animation/loading_anim.json'),
          ),
        ),
      ),
    );
  }
}

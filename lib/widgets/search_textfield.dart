import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Searchbar extends StatelessWidget {
  TextEditingController? controller;
  Function? onChanged;
  Searchbar({Key? key, this.controller, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Color(0xffF6F7F9),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Icon(
            Icons.search,
            color: Colors.grey.shade600,
            size: 24.w,
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            width: 300.w,
            child: TextField(
              onChanged: (value) => onChanged!(value),
              controller: controller,
              decoration: InputDecoration.collapsed(
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 16.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

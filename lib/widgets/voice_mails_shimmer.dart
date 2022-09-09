import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class VoiceMailsShimmer extends StatelessWidget {
  const VoiceMailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: EdgeInsets.only(
                bottom: 8.0.w, left: 20.w, right: 20.w, top: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Container(
                  width: 200.w,
                  height: 20.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      Container(
                        width: double.infinity,
                        height: 5.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 5,
        ));
  }
}

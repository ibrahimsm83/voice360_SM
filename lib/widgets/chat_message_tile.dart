import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:itp_voice/models/message.dart';
import 'package:itp_voice/widgets/custom_toast.dart';
import 'package:photo_view/photo_view.dart';

class MyMessageChatTile extends StatefulWidget {
  final String? message;
  final bool isCurrentUser;
  final String deliveryTime;
  final bool? isDelivered;
  final String? media;
  final String? fileName;

  MyMessageChatTile({
    this.message,
    required this.isCurrentUser,
    required this.deliveryTime,
    this.isDelivered,
    this.media,
    this.fileName,
  });

  @override
  State<MyMessageChatTile> createState() => _MyMessageChatTileState();
}

class _MyMessageChatTileState extends State<MyMessageChatTile> {
  final double minValue = 8.0;
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: [
            Column(
              crossAxisAlignment: widget.isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: widget.isCurrentUser ? 70.w : 15.w, right: widget.isCurrentUser ? 15.w : 70.w),
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Bubble(
                    elevation: 0,
                    style: BubbleStyle(
                        // nipRadius: 0,

                        radius: Radius.circular(10),
                        padding: BubbleEdges.all(7)),
                    nip: widget.isCurrentUser ? BubbleNip.rightTop : BubbleNip.leftTop,
                    color: widget.isCurrentUser ? Theme.of(context).colorScheme.primary : Color(0xffEAE9E9),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 5.w),
                            Padding(
                              padding: EdgeInsets.only(
                                right: widget.isCurrentUser ? 15.w : 0,
                              ),
                              child: widget.media == null
                                  ? SelectableText(
                                      "${widget.message}",
                                      minLines: 1,
                                      maxLines: 6,
                                      textWidthBasis: TextWidthBasis.longestLine,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: widget.isCurrentUser ? Colors.white : Colors.black,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (childContext) => Scaffold(
                                                body: PhotoView(
                                                  imageProvider: NetworkImage(widget.media!),
                                                ),
                                              ),
                                            ),
                                          ),
                                      child: Image.network(widget.media!)),
                            ),
                          ],
                        ),
                        if (widget.isDelivered != null && widget.isCurrentUser == true)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              widget.isDelivered == true
                                  ? "assets/images/double_tick.png"
                                  : "assets/images/single_tick.png",
                              width: 14,
                              color: widget.isCurrentUser ? Colors.white : Colors.black,
                            ),
                          ),
                        if (widget.media != null)
                          Positioned(
                            bottom: 3,
                            left: widget.isCurrentUser ? 3 : null,
                            right: !widget.isCurrentUser ? 3 : null,
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isDownloading = true;
                                });
                                try {
                                  Directory? directory = await DownloadsPathProvider.downloadsDirectory;
                                  var dir = await directory!.path;
                                  String savePath = dir + "/${widget.fileName}";
                                  await Dio().download(widget.media!, savePath);
                                  CustomToast.showToast("Downloaded ${widget.fileName}", false);
                                } catch (e) {
                                  print(e.toString());
                                }
                                setState(() {
                                  isDownloading = false;
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 5,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                                child: isDownloading
                                    ? Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.download,
                                        color: AppColors.black,
                                      ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: widget.isCurrentUser ? 0 : 25.w,
                    right: widget.isCurrentUser ? 25.w : 0,
                  ),
                  child: Text(
                    // "23:12 AM",
                    widget.deliveryTime,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}

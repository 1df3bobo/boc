import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:boc/utils/stack_position.dart';

import '../../../../../../utils/color_util.dart';
import '../card_transfer_logic.dart';
import '../card_transfer_state.dart';
import 'account_transfer_widget.dart';

class RemarkWidget extends StatefulWidget {
  const RemarkWidget({super.key, this.showTransferType = true});

  final bool showTransferType;

  @override
  State<RemarkWidget> createState() => _RemarkWidgetState();
}

class _RemarkWidgetState extends State<RemarkWidget> {
  final CardTransferLogic logic = Get.put(CardTransferLogic());
  final CardTransferState state = Get.find<CardTransferLogic>().state;

  List transferTime = [
    '实时-立即提交',
    '普通-2小时后提交',
    '次日-次日提交',
  ];

  List tipsList = [
    '实时立即提交，不可撤销',
    '普通2小时后提交，提交前可撤销',
    '次日凌晨提交，提交前可撤销',
  ];

  String transferTimeName = '实时';
  List titleNames = [];

  bool showTag = false;

  FocusNode focusNode1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: Colors.white,
      margin: EdgeInsets.only(top: 15.w),
      child: Column(
        children: [
          if (widget.showTransferType) ...[
            Container(
              height: 44.w,
              padding: EdgeInsets.only(left: 15.w, right: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(text: '转账方式'),
                  Row(
                    children: [
                      BaseText(
                        text: transferTimeName,
                        color: Color(0xff111111),
                      ),
                      Image(image: 'ic_jt_right'.png3x,width: 22.w,height: 22.w,),
                    ],
                  )
                ],
              ),
            ).withOnTap(onTap: onTapTransferType),
            Container(
              width: 1.sw,
              height: 1.w,
              margin: EdgeInsets.only(left: 15.w),
              color: const Color(0xffE7E9EB),
            ),
          ],

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(text: '附言'),
              Row(
                children: [
                  BaseText(
                    text: '选填',
                    color: Color(0xff666666),
                  ),
                  Image(image: 'ic_jt_right'.png3x,width: 22.w,height: 22.w,),
                ],
              )
            ],
          ).withContainer(
            height: 44.w,
            padding: EdgeInsets.only(left: 15.w, right: 12.w),
            onTap: _showRemarkDialog,
          ),
        ],
      ),
    );
  }

  void _showRemarkDialog() {
    FocusScope.of(context).unfocus();
    Get.dialog(
      GestureDetector(
        onTap: () => Get.back(),
        child: Material(
          color: Colors.black54,
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Image(
                    image: 'zhzz_fy'.png3x,
                    width: 1.sw * 0.8,
                    fit: BoxFit.fitWidth,
                  ).withOnTap(onTap: () => Get.back()),
                  Positioned(
                    left: 10.w,
                    right: 30.w,
                    top: 50.w,
                    child: TextField(
                      controller: state.remarksTextController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: '选填',
                        hintStyle: TextStyle(
                          color: const Color(0xff999999),
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierColor: Colors.black54,
    );
  }

  void onTapTransferType(){

    FocusScope.of(context).unfocus();
    focusNode1.unfocus();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        StackPosition stackPosition = StackPosition(
          designWidth: 1080,
          designHeight: 584,
          deviceWidth: 1.sw,
        );
        return Container(
          width: 1.sw,
          height: stackPosition.getHeight(584),
          child: Stack(
            children: [
              transferTimeName == '实时' ? Image(image: 'transfer_type_dialog1'.png3x, width: 1.sw, fit: BoxFit.fitWidth) : Image(image: 'transfer_type_dialog2'.png3x, width: 1.sw, fit: BoxFit.fitWidth),
              Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 50.w,
                    height: 40.w,
                  ).withOnTap(onTap: (){ Get.back(); })
              ),
              Positioned(
                  left: 0,
                  top: 50.w,
                  child: Container(
                    width: 1.sw,
                    height: 50.w,
                  ).withOnTap(onTap: () {
                    transferTimeName = '实时';
                    setState(() {});
                    Get.back();
                  })
              ),

              Positioned(
                  left: 0,
                  top: 120.w,
                  child: Container(
                    width: 1.sw,
                    height: 50.w,
                  ).withOnTap(onTap: () {
                    transferTimeName = '普通';
                    setState(() {});
                    Get.back();
                  })
              )
            ],
          ),
        );
      },
    );
  }
}

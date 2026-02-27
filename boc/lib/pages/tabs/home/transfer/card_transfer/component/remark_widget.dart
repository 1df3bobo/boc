import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../utils/color_util.dart';
import '../card_transfer_logic.dart';
import '../card_transfer_state.dart';
import 'account_transfer_widget.dart';

class RemarkWidget extends StatefulWidget {
  const RemarkWidget({super.key});

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
          ),
        ],
      ),
    );
  }

  void onTapTransferType(){

    FocusScope.of(context).unfocus();
    focusNode1.unfocus();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Container(
              width: 1.sw,
              height: 45.w,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 15.w, right: 15.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6.w))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                  ),
                  BaseText(
                    text: '请选择',
                    color: Color(0xff666666),
                    fontSize: 16.sp,
                  ),
                  Icon(
                    Icons.clear,
                    size: 24.w,
                  ).withOnTap(onTap: () {
                    Get.back();
                  }),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                String name = transferTime[index];
                return Container(
                  width: 1.sw,
                  height: 55.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 15.w,
                      ),
                      BaseText(
                        text: name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: transferTimeName == name
                              ? BColors.mainColor
                              : Colors.black,
                        ),
                      ),
                      transferTimeName == name
                          ? Image(
                        image: 't_sel'.png3x,
                        width: 20.w,
                        height: 15.w,
                      )
                          : SizedBox(
                        width: 20.w,
                        height: 15.w,
                      )
                    ],
                  ),
                ).withOnTap(onTap: () {
                  transferTimeName = name;
                  setState(() {});
                  Get.back();
                });
              },
              itemCount: transferTime.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  width: 1.sw,
                  height: 0.5.w,
                  color: const Color(0xffEFEFEF),
                );
              }, //state.list.length,
            ).withContainer(
              margin: EdgeInsets.only(left: 15.w, right: 15.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6.w))),
            ),
          ],
        ).withContainer(height: 245.w, color: Colors.white);
      },
    );
  }
}

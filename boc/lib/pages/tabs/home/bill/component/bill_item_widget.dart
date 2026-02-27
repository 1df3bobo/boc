import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/bill_item_model.dart';
import '../bill_info/bill_info_view.dart';

class BillItemWidget extends StatefulWidget {
  final BillItemList model;
  final int index;

  const BillItemWidget({super.key, required this.model, required this.index});

  @override
  State<BillItemWidget> createState() => _BillItemWidgetState();
}

class _BillItemWidgetState extends State<BillItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 71.w,
      width: 1.sw,
      child: Column(
        children: [
          Container(
            width: 1.sw - 38.w,
            height: 0.8.w,
            margin: EdgeInsets.only(left: 38.w),
            color: const Color(0xffF4F4F4),
          ),
          Row(
            children: [
              Container(
                width: 38.w,
                height: 70.w,
                color: const Color(0xffF4F4F4),
                child: Column(
                  children: [
                    SizedBox(
                      height: 14.w,
                    ),
                    BaseText(
                      text: widget.model.day,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xff666666),
                          fontWeight: FontWeight.bold),
                    ),
                    BaseText(
                      text: widget.model.week,
                      style:
                          TextStyle(fontSize: 10.sp, color: Color(0xff666666)),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1.sw - 38.w,
                height: 70.w,
                color: Colors.white,
                padding: EdgeInsets.only(left: 14.w, right: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText(
                          text: widget.model.excerpt,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xff303030),
                              fontWeight: FontWeight.bold,
                              height: 1),
                        ),
                        BaseText(
                          text: widget.model.oppositeName,
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 13.sp, color: const Color(0xff666666)),
                        ).withContainer(
                          width: (1.sw - 38.w) / 2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText(
                          text:
                              '余额 ${double.parse(widget.model.accountBalance == '' ? '0' : widget.model.accountBalance).bankBalance}',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xff666666),
                              height: 1),
                        ),
                        Row(
                          children: [
                            BaseText(
                              text: '人民币',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            BaseText(
                              text: double.parse(widget.model.amount == ''?'0':widget.model.amount).bankBalance,
                              style: TextStyle(
                                  color: widget.model.type == '1'
                                      ? const Color(0xffC34236)
                                      : const Color(0xff35827D),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ).withOnTap(onTap: () {
        Get.to((() => BillInfoPage()),
            arguments: {'model': widget.model.billDetail});
      }),
    );
  }
}

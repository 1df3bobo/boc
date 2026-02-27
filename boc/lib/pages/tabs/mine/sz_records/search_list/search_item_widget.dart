import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/pay_ment_model.dart';
import '../../../../../utils/widget_util.dart';
import '../../../home/bill/bill_info/bill_info_view.dart';

class SearchItemWidget extends StatefulWidget {
  final PayMentList model;
  const SearchItemWidget({super.key, required this.model});

  @override
  State<SearchItemWidget> createState() => _SearchItemWidgetState();
}

class _SearchItemWidgetState extends State<SearchItemWidget> {
  @override
  Widget build(BuildContext context) {
    PayMentList m = widget.model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          width: 1.sw,
          height: 90.w,
          color: Colors.white,
          padding:
          EdgeInsets.only(left: 15.w, top: 10.w, right: 15.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              netImage(url: m.icon, width: 21.w, height: 21.w),
              SizedBox(width: 8.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                      text: m.excerpt,
                      color: Color(0xff222222),
                      fontSize: 13),
                  SizedBox(
                    height: 8.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        text: m.transactionCategory + m.bankCard,
                        fontSize: 13,
                        color: Color(0xff666666),
                      ),
                      Row(
                        children: [
                          BaseText(
                            text: '人民币元',
                            fontSize: 12,
                            color: Color(0xff666666),
                          ),
                          SizedBox(width: 8.w,),
                          BaseText(
                            text: (m.type == '1'?'+':'-') + double.parse(
                                m.amount == '' ? '0' : m.amount).abs()
                                .bankBalance,
                            style: TextStyle(
                                color: m.type == '1'
                                    ? Color(0xffE82E4A)
                                    : Color(0xff222222),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ).withSizedBox(
                      width: 1.sw - 60.w
                  ),
                  SizedBox(height: 8.w,),
                  BaseText(text: widget.model.transactionTime.replaceAll('-', '/'),style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff666666)
                  ),)
                ],
              )
            ],
          ),
        ).withOnTap(onTap: (){
          Get.to((() => BillInfoPage()),
              arguments: {'model': m.billDetail});
        })
      ],
    );
  }
}

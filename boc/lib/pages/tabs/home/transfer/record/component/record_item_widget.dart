import 'package:boc/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/model/transfer_record_model.dart';

class RecordItemWidget extends StatefulWidget {
  final TransferRecordList model;
  const RecordItemWidget({super.key, required this.model});

  @override
  State<RecordItemWidget> createState() => _RecordItemWidgetState();
}

class _RecordItemWidgetState extends State<RecordItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        widget.model.day == ''?const SizedBox.shrink():Container(
          width: 1.sw,
          height: 30.w,
          padding: EdgeInsets.only(left: 14.w),
          color: const Color(0xffF9F9F9),
          alignment: Alignment.centerLeft,
          child: BaseText(text: widget.model.day,color: Color(0xff666666),),
        ),
        Container(
          width: 1.sw,
          height: 95.w,
          color: Colors.white,
          padding: EdgeInsets.only(left: 17.w, top: 15.w, right: 12.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(
                    text: widget.model.oppositeName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Image(
                        image: 'sc_dd'.png3x,
                        width: 14.w,
                        height: 14.w,
                      ),
                      SizedBox(
                        width: 5.5.w,
                      ),
                      BaseText(
                        text: '交易成功',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xff222222)),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 8.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      netImage(url: widget.model.icon, width: 14.w,height: 14.w),
                      SizedBox(width: 4.w,),
                      BaseText(text: widget.model.oppositeBankName,style: TextStyle(
                          fontSize: 13,color: Color(0xff666666)
                      ),).withSizedBox(width: 190.w)
                    ],
                  ),
                  BaseText(text: widget.model.transactionTime,style: TextStyle(
                    fontSize: 13,color: Color(0xff666666)
                  ),)
                ],
              ),
              SizedBox(height: 4.w,),
              Container(
                alignment: Alignment.centerRight,
                child: BaseText(text: '人民币元 ${widget.model.amount.bankBalance}',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff222222)
                ),),
              )
            ],
          ),
        )
      ],
    );
  }
}

import 'package:boc/pages/tabs/home/transfer/record/notify/notify_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../card_transfer/card_transfer_view.dart';
import 'record_detail_logic.dart';
import 'record_detail_state.dart';

class RecordDetailPage extends BaseStateless {
  RecordDetailPage({Key? key}) : super(key: key,title: '明细');

  final RecordDetailLogic logic = Get.put(RecordDetailLogic());
  final RecordDetailState state = Get.find<RecordDetailLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: 1.sw,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: 15.w,
            top: 15.w,
            right: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(
                    text: '${state.model.type == '1' ? '收入' : '支出'}金额 (人民币元)',
                    style: const TextStyle(color: Color(0xff666666), fontSize: 14),
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
              SizedBox(height: 20.w),
              BaseText(
                text: state.model.amount.bankBalance,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff222222)),
              ),
              SizedBox(height: 20.w),
            ],
          ),
        ),
        ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String e = state.titles0[index];
              if (e == '')
                return SizedBox(
                  width: 1.sw,
                  height: 8.w,
                );
              if (e == 'text')
                return Container(
                  width: 1.sw,
                  height: 32.w,
                  alignment: Alignment.centerLeft,
                  color: const Color(0xFFF5F5F5),
                  padding: EdgeInsets.only(left: 15.w),
                  child: BaseText(
                    text: '涝可修改分类、备注、所属账本、交易对象和计入收支情况',
                    fontSize: 11,
                    color: Color(0xff999999),
                  ),
                );
              // if(logic.valueStr(e) == '') return const SizedBox.shrink();
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BaseText(
                    text: e,
                    fontSize: 13,
                    maxLines: 2,
                    color: Color(0xff666666),
                  ).withContainer(
                    width: 65.w,
                  ),
                  SizedBox(
                    width: 52.w,
                  ),
                  Container(
                    child: BaseText(
                      text: logic.valueStr(e),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.sp),
                    ),
                  ).expanded()
                ],
              ).withContainer(
                  padding: EdgeInsets.only(
                    top: 10.w,
                    bottom: 10.w,
                    left: 15.w,
                    right: 15.w,
                  ),
                  color: Colors.white);
            },
            itemCount: state.titles0.length),

        Stack(
          children: [
            Image(image: 'zz_b_bg'.png3x),
            
            Positioned(
                top: 25.w,
                child: Container(
              width: 1.sw,
              height: 70.w,
            ).withOnTap(onTap: (){

              Get.to(() => NotifyPage(),arguments: {
                'model':state.model
              });
                })),

            Positioned(
                top: 25.w + 70.w,
                child: Container(
                  width: 1.sw,
                  height: 65.w,
                ).withOnTap(onTap: (){
                  Get.to(() => CardTransferPage(), arguments: {
                    'icon': state.model.icon,
                    'bankName': state.model.oppositeBankName,
                    'id': state.model.oppositeBankId,
                    'name': state.model.oppositeName,
                    'bankCard': state.model.oppositeAccount,
                  });
                })),

            Positioned(
                top: 25.w + 70.w + 65.w,
                child: Container(
                  width: 1.sw,
                  height: 70.w,
                ))
          ],
        ),
        SizedBox(height: 45.w,),

      ],
    );
  }
}

import 'package:boc/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'notify_logic.dart';
import 'notify_state.dart';

class NotifyPage extends BaseStateless {
  NotifyPage({Key? key}) : super(key: key,title: '通知收款人');

  final NotifyLogic logic = Get.put(NotifyLogic());
  final NotifyState state = Get.find<NotifyLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [

            Stack(
              children: [
                Container(
                  width: 340.w,
                  height: 452.w,
                  margin: EdgeInsets.only(left: 18.w,top: 16.w,right: 18.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.w)),
                    image: DecorationImage(
                      image: 'tzskr_s'.png3x,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.w,),
                      BaseText(text: '转账成功',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff222222)
                      ),),
                      SizedBox(height: 16.w,),
                      BaseText(text: '此回单为客户自行打印，表示汇款申请已提交，'
                          '仅供参考。资金到账状态以收款方账户为准。',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.5,
                          height: 1.6,
                          color: Color(0xff222222),
                        ),).withPadding(
                        left: 21.w,right: 21.w,
                      ),
                      SizedBox(height: 32.w,),
                      Column(
                        spacing: 15.w,
                        children: state.title.map((e){
                          return Row(
                            children: [
                              BaseText(text: e,color: Color(0xff696969),fontSize: 13.5,).withSizedBox(
                                width: 100.w,
                              ),
                              BaseText(text: logic.valueStr(e),style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: e == '转账金额'?BColors.mainColor:Colors.black
                              ),),
                            ],
                          );
                        }).toList(),
                      ).withPadding(
                        left: 15.w,right: 15.w,
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 217.w,
                    top: 28.w,
                    child: Image(image: 'tzskr_z'.png3x,width: 98.w))
              ],
            ),

          ],
        ).expanded(),
        
        Image(image: 'tzskr_b'.png3x)
      ],
    );
  }
}

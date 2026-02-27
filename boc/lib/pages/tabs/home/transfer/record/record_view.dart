import 'package:boc/pages/tabs/home/transfer/record/record_detail/record_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'component/record_item_widget.dart';
import 'component/record_right_widget.dart';
import 'record_logic.dart';
import 'record_state.dart';

class RecordPage extends BaseStateless {
  RecordPage({Key? key}) : super(key: key, title: '转账记录');

  final RecordLogic logic = Get.put(RecordLogic());
  final RecordState state = Get.find<RecordLogic>().state;


  @override
  bool get enablePullDown => false;

  @override
  void onLoading() {
    super.onLoading();
    state.recordData.pageNum++;
    logic.transferPage();
  }


  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<RecordLogic>(builder: (_){
              return BaseText(
                text:state.selectTime == ''?'':'${state.selectTime}查询结果',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff666666)),
              );
            },id: 'updateTagText',),
            Row(
              children: [
                BaseText(
                  text: '筛选',
                  fontSize: 13,
                  color: Color(0xff222222),
                ),
                Image(
                  image: 'sx_ic'.png3x,
                  width: 12.w,
                  height: 12.w,
                )
              ],
            ).withOnTap(onTap: () {
              SmartDialog.show(
                alignment: Alignment.centerRight,
                builder: (context) {
                  return const RecordRightWidget();
                },
              );
            })
          ],
        ).withContainer(
            height: 38.w,
            padding: EdgeInsets.only(left: 10.w,right: 10.w)
        ),
        GetBuilder(
          builder: (RecordLogic c) {
            return Expanded(
                child: refreshWidget(
                    controller: state.refreshController,
                    child: ListView.separated(
                      controller: state.scController,
                      padding: EdgeInsets.only(top: 10.w),
                      itemBuilder: (context, index) {
                        return RecordItemWidget(model: state.list[index],).withOnTap(onTap: (){
                          Get.to(() => RecordDetailPage(),arguments: {
                            'model':state.list[index].detail
                          });
                        });
                      },
                      itemCount: state.list.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 1.sw,
                          height: 0.5.w,
                          color: Color(0xffdedede),
                        );
                      },
                    )));
          },
          id: 'updateUI',
        )
      ],
    );
  }
}

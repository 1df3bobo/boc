import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../config/model/bill_item_model.dart';
import 'bill_logic.dart';
import 'bill_state.dart';
import 'component/bill_item_widget.dart';
import 'component/bill_top_widget.dart';

class BillPage extends BaseStateless {
  BillPage({Key? key}) : super(key: key,title: '交易明细');

  final BillLogic logic = Get.put(BillLogic());
  final BillState state = Get.find<BillLogic>().state;


  @override
  void onLoading() {
    super.onLoading();
    state.billData.pageNum++;
    logic.getData();
  }

  @override
  bool get enablePullDown => false;

  @override
  get refreshController => state.refreshController;

  @override
  Widget initBody(BuildContext context) {
    return GetBuilder(
      builder: (BillLogic c) {
        return Column(
          children: [
            const BillTopWidget(),

            refreshWidget(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: state.controller,
                  itemBuilder: (context, index) {

                    BillItemList model = state.list[index];
                    if (model.billDetail == null) {
                      return Container(
                        width: 1.sw,
                        height: 35.w,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 15.w),
                        color:Color(0xffF9F9F9),
                        child: BaseText(
                          text: model.month + '/' + model.year,
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      );
                    }
                    return BillItemWidget(
                      model: model,
                      index: 0,
                    );
                  },
                  itemCount: state.list.length ,
                )).expanded()
          ],
        );
      },
      id: 'updateUI',
    );
  }
}

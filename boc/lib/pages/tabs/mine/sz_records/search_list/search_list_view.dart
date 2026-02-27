import 'package:boc/pages/tabs/mine/sz_records/search_list/search_item_widget.dart';
import 'package:boc/pages/tabs/mine/sz_records/search_list/search_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'search_list_logic.dart';
import 'search_list_state.dart';

class SearchListPage extends BaseStateless {
  SearchListPage({Key? key}) : super(key: key, title: '收支记录');

  final SearchListLogic logic = Get.put(SearchListLogic());
  final SearchListState state = Get.find<SearchListLogic>().state;

  @override
  get refreshController => state.refreshController;

  @override
  void onLoading() {
    super.onLoading();
    state.searchData.pageNum++;
    logic.getData2();
  }

  @override
  bool get enablePullDown => false;

  @override
  Widget initBody(BuildContext context) {
    return GetBuilder<SearchListLogic>(builder: (_){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.sw,
            height: 28.w,
            margin: EdgeInsets.only(left: 15.w, right: 15.w),
            decoration: BoxDecoration(
                color: const Color(0xffF5F5F5),
                borderRadius: BorderRadius.all(Radius.circular(4.w))),
            child: Row(
              children: [
                Image(
                  image: 'ic_search_left'.png3x,
                  width: 15.w,
                  height: 15.w,
                ).withContainer(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                ),
                TextFieldWidget(
                  hintText: '请输入',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 12,
                  ),
                  controller: state.textController,
                  onSubmitted: (v) {
                    state.searchData.keyword = v;
                    logic.getData2().then((_){
                      try {
                        state.controller.jumpTo(0);
                      }catch(e){}

                    });;
                  },
                ).expanded()
              ],
            ),
          ).withContainer(
              color: Colors.white,
              padding: EdgeInsets.only(
                top: 10.w,
                bottom: 10.w,
              )),
          Container(
            color: Colors.white,
            height: 30.w,
            child: Row(
              children: [
                GetBuilder<SearchListLogic>(
                  builder: (_) {
                    DateTime now = DateTime.now();
                    String time = DateFormat('yyyy.MM').format(now);
                    if (state.selectTime != '') {
                      time = state.selectTime;
                    } else {
                      if (state.searchData.endTime != '') {
                        time =
                        '${state.searchData.beginTime.replaceAll('-', '/')}-${state.searchData.endTime.replaceAll('-', '/')}';
                      } else {
                        time = DateFormat('yyyy.MM').format(now);
                      }
                    }

                    return Row(
                      children: [
                        BaseText(
                          text: time,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color(0xff222222)),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Image(
                          image: 'xia_01'.png,
                          width: 8.w,
                          height: 8.w,
                        ),
                      ],
                    ).withOnTap(onTap: () {
                      SmartDialog.show(
                        alignment: Alignment.centerRight,
                        builder: (context) {
                          return const SearchTimeWidget();
                        },
                      );
                    });
                  },
                  id: 'updateTime',
                ),
              ],
            ).withPadding(
              left: 16.w,
              right: 16.w,
            ),
          ),
          BaseText(
            text: '收入 ¥ ${state.incomeTotal.bankBalance}',
            fontSize: 13,
            color: Color(0xff666666),
          ).withPadding(top: 10.w, left: 12.w),
          BaseText(
            text: '支出 ¥ ${state.expensesTotal.bankBalance}',
            fontSize: 13,
            color: Color(0xff666666),
          ).withPadding(top: 4.w, left: 12.w,bottom: 12.w),
          refreshWidget(
            child: ListView.separated(
                controller: state.controller,
                itemBuilder: (context, index) {
                  return SearchItemWidget(model: state.list[index]);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    width: 1.sw,
                    height: 0.5.w,
                    color: Color(0xffdedede),
                  );
                },
                itemCount: state.list.length)
          ).expanded()
        ],
      );
    },id: 'updateUI',);
  }
}

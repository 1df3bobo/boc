import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../utils/sp_util.dart';
import 'search_history_logic.dart';
import 'search_history_state.dart';

class SearchHistoryPage extends BaseStateless {
  SearchHistoryPage({Key? key}) : super(key: key, title: '收支记录');

  final SearchHistoryLogic logic = Get.put(SearchHistoryLogic());
  final SearchHistoryState state = Get.find<SearchHistoryLogic>().state;

  @override
  List<Widget>? get rightAction => [
    const BaseText(text: '取消').withContainer(
      padding: EdgeInsets.only(right: 12.w),
      alignment: Alignment.center,
      onTap: () => Get.back(),
    ),
  ];

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {

    return Column(
      children: [
        Container(
          width: 1.sw,
          height: 30.w,
          margin: EdgeInsets.only(left: 15.w,right: 15.w),
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
                hintStyle:  TextStyle(
                  fontSize: 12,
                ),
                controller: state.textController,
                onSubmitted: (v){
                  if(v !=' '){
                    List<String> searchList = searchHistoryValue1.split(',');
                    if (!searchList.contains(v)) {
                      searchList.add(v);
                    }
                    searchList.join(',').saveSearchHistory1;
                  }

                  Get.offAndToNamed(Routes.searchListPage,arguments: {
                    'name':v,
                  });
                },
              ).expanded()
            ],
          ),
        ).withContainer(
          color: Colors.white,
          padding: EdgeInsets.only(top: 10.w,bottom: 10.w,)
        ),
        ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText(
                  text: '历史搜索',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.w),
                ),
                const Icon(
                  Icons.delete_outline_sharp,
                  color: Color(0xff999999),
                ).withPadding(right: 15.w, bottom: 5.w)
              ],
            ).withPadding(left: 16.w, top: 24.w),
            SizedBox(
              height: 10.w,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 24.w,
              runSpacing: 20.w,
              children: searchHistoryValue1.split(',').map((e) {
                return Container(
                  padding: EdgeInsets.only(left: 8.w,right: 8.w,top: 3.w,bottom: 3.w),
                  decoration: BoxDecoration(
                      color: Color(0xffF6F6F9),
                      borderRadius: BorderRadius.all(Radius.circular(15.w))
                  ),
                  child: BaseText(
                    text: e,
                    fontSize: 14,
                  ).withOnTap(onTap: () {
                    Get.offAndToNamed(Routes.searchListPage,arguments: {
                      'name':e,
                    });
                  }),
                );
              }).toList(),
            ).withPadding(
              left: 25.w,
              right: 25.w,
            ),
            // BaseText(
            //   text: '快速搜索',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.w),
            // ).withPadding(left: 16.w, top: 24.w),
            // SizedBox(
            //   height: 10.w,
            // ),
            // Wrap(
            //   direction: Axis.horizontal,
            //   spacing: 24.w,
            //   runSpacing: 20.w,
            //   children: state.nameList.map((e) {
            //     return Container(
            //      padding: EdgeInsets.only(left: 8.w,right: 8.w,top: 3.w,bottom: 3.w),
            //       decoration: BoxDecoration(
            //         color: Color(0xffF6F6F9),
            //         borderRadius: BorderRadius.all(Radius.circular(15.w))
            //       ),
            //       child: BaseText(
            //         text: e,
            //         fontSize: 14,
            //       ).withOnTap(onTap: () {
            //         List<String> searchList = searchHistoryValue.split(',');
            //         if (!searchList.contains(e)) {
            //           searchList.add(e);
            //         }
            //         searchList.join(',').saveSearchHistory;
            //         // Get.offAndToNamed(Routes.billSearchPage,arguments: {
            //         //   'name':e,
            //         // });
            //       }),
            //     );
            //   }).toList(),
            // ).withPadding(
            //   left: 25.w,
            //   right: 25.w,
            // ),
          ],
        ).expanded()
      ],
    );
  }
}

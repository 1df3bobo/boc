import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/net_image_widget.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/color_util.dart';
import '../bank_list/bank_list_model.dart';
import 'contants_list_logic.dart';
import 'contants_list_state.dart';

class ContactsListPage extends BaseStateless {
  ContactsListPage({Key? key}) : super(key: key, title: '收款人');

  final ContactsListLogic logic = Get.put(ContactsListLogic());
  final ContactsListState state = Get.find<ContactsListLogic>().state;

  @override
  Color? get background => Colors.white;


  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        _searchWidget(),
        Expanded(
            child: GetBuilder(
          builder: (ContactsListLogic c) {
            return _tabViewWidget();
          },
          id: 'updateUI',
        ))
      ],
    );
  }

  Widget _searchWidget() {
    return Container(
      width: 1.sw,
      height: 30.w,
      margin: EdgeInsets.only(
        right: 15.w,
        top: 12.w,
        bottom: 12.w,
        left: 15.w,
      ),
      decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.all(Radius.circular(15.w))),
      child: Row(
        children: [
          Image(
            image: 'ic_search_left'.png3x,
            width: 15.w,
            height: 15.w,
          ).withPadding(left: 12.w, right: 12.w),
          TextFieldWidget(
            hintText: '搜索收款人',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
            ),
            controller: state.searchController,
            focusNode: state.focusNode,
            onSubmitted: (v){
              logic.loadData(name: v);
            },
          ).expanded()
        ],
      ),
    );
  }

  Widget _tabViewWidget() {
    return AzListView(
      data: logic.contactList,
      itemCount: logic.contactList.length,
      itemBuilder: (BuildContext context, int index) {
        ContactInfo model = logic.contactList[index];
        return Column(
          children: [
            _buildListItem(model),
            Container(
              width: 1.sw,
              height: 0.5.w,
              padding: EdgeInsets.only(
                left: 25.w,
                right: 25.w,
              ),
            )
          ],
        );
      },
      susItemHeight: 55.w,
      // padding: EdgeInsets.only(top: 32.w),
      susItemBuilder: (BuildContext context, int index) {
        ContactInfo model = logic.contactList[index];
        return getSusItem(context, model.getSuspensionTag(), susHeight: 30.w);
      },
      indexBarData: SuspensionUtil.getTagIndexList(logic.contactList),
      // indexBarOptions: IndexBarOptions(
      //   textStyle: TextStyle(fontSize: 12.sp, color: BColors.mainColor),
      // ),
    );

  }

  Widget getSusItem(BuildContext context, String tag, {double susHeight = 40}) {
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  Widget _buildListItem(ContactInfo model) {
    return Row(
      children: [
        NetImageWidget(
          url: model.icon,
          width: 32.w,
          height: 32.w,
        ).withPadding(right: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: model.name,
              fontSize: 15.sp,
            ),
            SizedBox(
              height: 4.w,
            ),
            Row(
              children: [
                BaseText(
                  text: model.bankName,
                  fontSize: 12.sp,
                  color: const Color(0xff666666),
                ),
                BaseText(
                  text: '（${model.bankCard.maskBankCardNumber()}）',
                  fontSize: 13.sp,
                  color: Color(0xff666666),
                )
              ],
            )
          ],
        )
      ],
    ).withContainer(
        color: Colors.white,
        height: 70.w,
        padding: EdgeInsets.all(12.w),
        onTap: () {
          Get.back(result: {
            'icon': model.icon,
            'bankName': model.bankName,
            'id': model.bankId,
            'name': model.name,
            'bankCard': model.bankCard,
          });
        });
  }
}

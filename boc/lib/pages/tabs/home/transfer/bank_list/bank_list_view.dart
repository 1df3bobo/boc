import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/component/net_image_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/color_util.dart';
import 'bank_list_logic.dart';
import 'bank_list_model.dart';
import 'bank_list_state.dart';

class BankListPage extends BaseStateless {
  BankListPage({super.key}) : super(title: '收款银行');

  final BankListLogic logic = Get.put(BankListLogic());
  final BankListState state = Get.find<BankListLogic>().state;

  Widget customHeader() {
    return  ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 28.w),
        itemBuilder: (context, index) {
          return getWeChatListItem(context, state.hotBankList[index]);
        },
        itemCount: state.hotBankList.length,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: 1.sw,
            height: 0.5.w,
            margin: EdgeInsets.only(left: 15.w),
            color: Color(0xffE9E9E9),
          );
        }, //
    ).withContainer(
      height: (state.hotBankList.length * 46).w + 28.w,
      width: 1.sw,
    );
  }

  @override
  Widget initBody(BuildContext context) {
    return GetBuilder(
      builder: (BankListLogic c) {
        return AzListView(
          data: state.contactList,
          itemCount: state.contactList.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) return customHeader();
            ContactInfo model = state.contactList[index];
            return getWeChatListItem(context, model);
          },
          susItemHeight: state.susItemHeight.w,
          susItemBuilder: (BuildContext context, int index) {
            ContactInfo model = state.contactList[index];
            if ('热' == model.getSuspensionTag()) {
              return Container(
                width: 1.sw,
                height: 28.w,
                padding: EdgeInsets.only(left: 16.w),
                color: const Color(0xFFF3F4F5),
                alignment: Alignment.centerLeft,
                child: BaseText(text: '热门银行'),
              );
            }
            return getSusItem(context, model.getSuspensionTag(),
                susHeight: state.susItemHeight);
          },
          indexBarData: SuspensionUtil.getTagIndexList(state.contactList),
          indexBarOptions: IndexBarOptions(
            needRebuild: true,
            selectTextStyle: TextStyle(
                fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.w500),
            selectItemDecoration:
                const BoxDecoration(shape: BoxShape.circle, color: BColors.mainColor),
            indexHintWidth: 97.w,
            indexHintHeight: 97.w,
            // indexHintDecoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(Utils.getImgPath('ic_index_bar_bubble_white')),
            //     fit: BoxFit.contain,
            //   ),
            // ),
            indexHintAlignment: Alignment.centerRight,
            indexHintTextStyle:
                TextStyle(fontSize: 24.0.sp, color: Colors.white),
            indexHintOffset: Offset(-30.w, 0),
          ),
        );
      },
      id: 'updateUI',
    );
  }

  Widget getSusItem(BuildContext context, String tag, {double susHeight = 40}) {
    return Container(
      height: susHeight.w,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.w),
      color: const Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: BaseText(
        text: tag,
        softWrap: false,
        fontSize: 14.sp,
        color: const Color(0xFF666666),
      ),
    );
  }

  Widget getWeChatListItem(
    BuildContext context,
    ContactInfo model,) {
    return Container(
      color: Colors.white,
      height: 45.w,
      child: Column(
        children: [
          Expanded(child: Row(
            children: [
              NetImageWidget(
                url: model.icon,
                width: 20.w,
                height: 20.w,
              ).withPadding(
                  left: 20.w,
                  right: 10.w
              ),
              BaseText(text: model.name),
            ],
          )),
          Container(
            width: 320.w,
            height: 0.3.w,
            color: const Color(0xffd2d2d2),
          )
        ],
      ),
    ).withOnTap(onTap: (){

      Get.back(
        result: {
          'icon':model.icon,
          'bankName':model.name,
          'id':model.id,
        }
      );
    });
  }

}

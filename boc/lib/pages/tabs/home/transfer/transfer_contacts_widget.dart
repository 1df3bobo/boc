import 'package:boc/pages/tabs/home/transfer/contacts_list/contants_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/widget_util.dart';
import '../../../../config/app_config.dart';
import '../../../../config/dio/network.dart';
import '../../../../config/model/contacts_model.dart';
import '../../../../config/net_config/apis.dart';
import '../../../../utils/color_util.dart';
import 'card_transfer/card_transfer_view.dart';


class TransferContactsWidget extends StatefulWidget {
  const TransferContactsWidget({super.key});

  @override
  State<TransferContactsWidget> createState() => _TransferContactsWidgetState();
}

class _TransferContactsWidgetState extends State<TransferContactsWidget>
    with SingleTickerProviderStateMixin {
  List<ContactsModel> contactList = [];

  bool showCard = false;

  @override
  void initState() {
    super.initState();

    Http.get(Apis.contactsList).then((v) {
      if (v is List) {
        contactList = v.map((e) => ContactsModel.fromJson(e)).toList();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 12.w,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.w))),
      child: Column(
        children: [
          Container(
            height: 45.w,
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText(
                  text: "最近收款人",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                BaseText(
                  text: "全部",
                  color: Color(0xff3E78DC),
                  fontSize: 14,
                ).withOnTap(onTap: (){
                  Get.to(() => ContactsListPage());
                }),
              ],
            ),
          ),
          Container(
            height: 55.w,
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image(
                      image: 'zz_head_img'.png3x,
                      width: 38.w,
                      height: 38.w,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    BaseText(
                      text: AppConfig.config.abcLogic.memberInfo.realName,
                      color: Color(0xff333333),
                      fontSize: 17,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 22.w,
                      alignment: Alignment.center,
                      child: BaseText(
                        text: '我的账户(1)',
                        fontSize: 15,
                        color: Color(0xff222222),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 18.w,
                  height: 18.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(image:showCard?'ic_jt_top'.png3x:'ic_jt_bottom'.png3x),
                      color: Color(0xffF9F9F9),
                      borderRadius:
                      BorderRadius.all(Radius.circular(15.w))),

                ).withOnTap(onTap: (){
                  showCard = !showCard;
                  setState(() {});
                }),
              ],
            ),
          ),
         showCard? Container(
            height: 72.w,
            padding: EdgeInsets.only(left: 15.w + 35.w, right: 15.w),
            child: Row(
              children: [
                Image(image: 'zg_icon'.png,width: 20.w,height: 20.w,),
                SizedBox(width: 8.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BaseText(
                          text: '中国银行',
                          color: Color(0xff333333),
                          fontSize: 16,
                        ).withContainer(width: 260.w),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    ).withContainer(width: 268.w),
                    SizedBox(height: 4.w),
                    BaseText(
                      text:
                      '尾号 ${AppConfig.config.abcLogic.cardFour()}',
                      color: Color(0xff666666),
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ):SizedBox.shrink(),
          Container(
            height: 3.w,
            color: Color(0xffF8F9FA),
          ),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              ContactsModel model = contactList[index];
              return Container(
                height: 72.w,
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Row(
                  children: [
                    netImage(url: model.icon, width: 25.w, height: 25.w),
                    SizedBox(width: 8.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            BaseText(
                              text: model.name,
                              color: Color(0xff333333),
                              fontSize: 16,
                            ).withContainer(width: 260.w),
                            SizedBox(
                              width: 5.w,
                            ),
                          ],
                        ).withContainer(width: 268.w),
                        SizedBox(height: 4.w),
                        BaseText(
                          text:
                          '尾号 ${model.bankCard.getLastFourByList()}  ${model.bankName}',
                          color: Color(0xff666666),
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ).withOnTap(onTap: () {
                Get.to(() => CardTransferPage(), arguments: {
                  'icon': model.icon,
                  'bankName': model.bankName,
                  'id': model.bankId,
                  'name': model.name,
                  'bankCard': model.bankCard,
                });
              });
            },
            separatorBuilder: (context, index) {
              return Container(
                color: Color(0xffF8F9FA),
                width: 1.sw,
                height: 1.w,
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
              );
            },
            itemCount: contactList.length,
          ),
        ],
      ),
    );
  }
}

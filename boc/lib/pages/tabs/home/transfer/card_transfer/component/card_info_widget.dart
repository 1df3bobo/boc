import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../bank_list/bank_list_view.dart';
import '../../contacts_list/contants_list_view.dart';
import '../card_transfer_logic.dart';
import '../card_transfer_state.dart';
import 'account_transfer_widget.dart';

class CardInfoWidget extends StatefulWidget {
  const CardInfoWidget({super.key});

  @override
  State<CardInfoWidget> createState() => _CardInfoWidgetState();
}

class _CardInfoWidgetState extends State<CardInfoWidget> {

  final CardTransferLogic logic = Get.find<CardTransferLogic>();
  final CardTransferState state = Get.find<CardTransferLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: Colors.white,
      child: Column(
        children: [
          BaseText(
            text: "收款人",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ).withContainer(
            width: 1.sw,
            height: 40.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.w),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 52.w,
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transfer.itemCellWidget(
                        title: "户名",
                        hintText: '支持首字母检索',
                        controller: state.nameTextController,
                        // textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        hintColor: const Color(0xffC7C7C7),
                        onChanged: (v) {
                          state.cardReq.realName = v;
                          logic.update(['updateCard']);
                        },
                        onSubmitted: (v) {
                          logic.update(['updateBottom','updateBottom']);
                        }),
                    Image(
                      image: 't_name'.png3x,
                      width: 16.w,
                      height: 16.w,
                    ).withPadding(right: 16.w).withOnTap(onTap: () {
                      Get.to(() => ContactsListPage())?.then((v) {
                        if (v != null && v is Map) {
                          state.cardReq.bankId = v['id'];
                          state.cardReq.realName = v['name'];
                          state.cardReq.bankName = v['bankName'];
                          state.cardReq.cardNo = v['bankCard'];
                          state.nameTextController.text = state.cardReq.realName;
                          state.accountTextController.text = state.cardReq.cardNo;
                          logic.update(['updateCard','updateBottom']);
                        }
                      });
                    }),
                  ],
                ),
              ),
              Container(
                width: 1.sw,
                height: 1.w,
                margin: EdgeInsets.only(left: 15.w),
                color: const Color(0xffE7E9EB),
              ),
              Container(
                height: 52.w,
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transfer.itemCellWidget(
                      title: "账户",
                      hintText: '支持手机号汇款',
                      keyboardType: TextInputType.datetime,
                      // textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14.sp,),
                      onChanged: (v) {
                        state.cardReq.cardNo = v;
                        logic.update(['updateCard']);
                      },
                      onSubmitted: (v) {
                        logic.update(['updateCard']);
                      },
                      hintColor: Color(0xffC7C7C7),
                      controller: state.accountTextController,
                      focusNode: state.accountFocusNode,
                    ),
                    Image(
                      image: 't_cardno'.png3x,
                      width: 20.w,
                      height: 20.w,
                    ).withPadding(right: 16.w),
                  ],
                ),
              ),
              Container(
                width: 1.sw,
                height: 1.w,
                margin: EdgeInsets.only(left: 15.w),
                color: const Color(0xffE7E9EB),
              ),
              GetBuilder(builder: (CardTransferLogic c){
                if(c.state.cardReq.cardNo == '') return const SizedBox.shrink();
                return Container(
                  height: 52.w,
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: '收款银行',
                            fontSize: 16.sp,
                            color: Color(0xff333333),
                          ).withContainer(
                            width: 108.w,
                            height: 45.w,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 15.w, top: 2.w),
                          ),
                          GetBuilder(
                            builder: (CardTransferLogic c) {
                              bool isSel = state.cardReq.bankName == '';
                              return BaseText(
                                text:isSel ?'请选择收款银行':state.cardReq.bankName ,
                                fontSize: 14.sp,
                                color:isSel? const Color(0xffC7C7C7):const Color(0xff333333),
                              ).withContainer(
                                width: 210.w,
                                // alignment: Alignment.centerRight,
                              ) ;
                            },
                            id: 'updateCard',
                          )
                        ],
                      ),
                      Image(
                        image: 'ic_jt_right'.png3x,
                        width: 24.w,
                        height: 24.w,
                      ).withPadding(right: 16.w),
                    ],
                  ).withOnTap(onTap: () {
                    Get.to(() => BankListPage())?.then((v) {
                      if (v != null && v is Map) {
                        state.cardReq.bankId = v['id'];
                        state.cardReq.bankName = v['bankName'];
                        logic.update(['updateCard']);
                      }
                    });
                    FocusScope.of(context).unfocus();
                  }),
                );
              },id: 'updateCard',)
            ],
          ),
        ],
      ),
    );
  }
}

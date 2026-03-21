import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/pay_ment_model.dart';
import '../../../../../utils/widget_util.dart';
import '../../../home/bill/bill_info/bill_info_view.dart';
import '../sz_detail/sz_detail_view.dart';

class Item1Widget extends StatefulWidget {
  final PayMentList model;

  const Item1Widget({super.key, required this.model});

  @override
  State<Item1Widget> createState() => _Item1WidgetState();
}

class _Item1WidgetState extends State<Item1Widget> {
  static const String _explanationText = '''1.收支记录的货币单位为人民币元，外币交易将按照上一日牌价自动折算为人民币;
2.本人中行卡互转、同名账户跨行互转、信用卡还款、结售汇、投资理财交易，均不计入收入和支出；
3.您可以在收支记录详情页，设置是否将该笔交易计入收支；
4.每一笔交易都将按照特征自动分类，您也可以在收支记录详情页修改分类；
5.您可以对交易添加备注以备查询；
6.您可以在收支记录列表中删除交易，交易删除后不可恢复，但不会影响账户交易记录；
7.收支记录的数据更新可能延迟，仅供参考，不作为对账凭证，具体交易信息以账户交易记录为准；
8.收支记录可查询自2018年1月1日起至今的交易。''';

  void _showExplanationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * 0.6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.w, bottom: 12.w),
                child: BaseText(
                  text: '说明',
                  fontSize: 16,
                  color: Color(0xff222222),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
                  child: BaseText(
                    text: _explanationText,
                    fontSize: 14,
                    color: Color(0xff333333),
                    style: TextStyle(height: 1.8),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
              SizedBox(
                width: double.infinity,
                height: 48.w,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: BaseText(
                    text: '确认',
                    fontSize: 16,
                    color: Color(0xffE82E4A),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _weekAdd(String week){
    if(week == '周一') return '星期一';
    if(week == '周二') return '星期二';
    if(week == '周三') return '星期三';
    if(week == '周四') return '星期四';
    if(week == '周五') return '星期五';
    if(week == '周六') return '星期六';
    if(week == '周日') return '星期日';
    return week;
  }
  @override
  Widget build(BuildContext context) {
    PayMentList m = widget.model;
    if (m.month != '') {
      String mh = m.month.split('-').last;

      return Stack(
        children: [
          Image(image: mh.png).withContainer(
              width: 345.w,
              height: 102.w,
              margin: EdgeInsets.only(left: 15.w, right: 15.w)),
          Positioned(
            top: 0,
              right: 10.w,
              child: Container(
                width: 40.w,
                height: 40.w,
              ).withOnTap(onTap: () {
                _showExplanationDialog(context);
              })),

          Positioned(
              left: 30.w,
              bottom: 24.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(
                      text:
                          '收入 ${double.parse(widget.model.incomeTotal == '' ? '0' : widget.model.incomeTotal).bankBalance}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  BaseText(
                      text:
                          '支出 ${double.parse(widget.model.expensesTotal == '' ? '0' : widget.model.expensesTotal).bankBalance}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ).withSizedBox(
                  width: 1.sw -60.w
              ))
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        m.day != ''
            ? Container(
          width: 1.sw,
          height: 30.w,
          padding: EdgeInsets.only(left: 15.w),
          alignment: Alignment.centerLeft,
          child: BaseText(
            text: '${m.day} ${_weekAdd(m.week)}',
            color: Color(0xff222222),
            fontSize: 13,
          ),
        )
            : const SizedBox.shrink(),
        Container(
          width: 1.sw,
          height: 70.w,
          color: Colors.white,
          padding:
          EdgeInsets.only(left: 15.w, top: 10.w, right: 15.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              netImage(url: m.icon, width: 21.w, height: 21.w),
              SizedBox(width: 8.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                      text: m.excerpt,
                      color: Color(0xff222222),
                      fontSize: 13),
                  SizedBox(
                    height: 8.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        text: "${m.transactionCategory}(${m.bankCard})",
                        fontSize: 13,
                        color: Color(0xff666666),
                      ),
                      Row(
                        children: [
                          BaseText(
                            text: '人民币元',
                            fontSize: 13,
                            color: Color(0xff666666),
                          ),
                          SizedBox(width: 8.w,),
                          BaseText(
                            text: (m.type == '1'?'+':'-') + double.parse(
                                m.amount == '' ? '0' : m.amount).abs()
                                .bankBalance,
                            style: TextStyle(
                                color: m.type == '1'
                                    ? Color(0xffE82E4A)
                                    : Color(0xff222222),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ).withSizedBox(
                      width: 1.sw - 60.w
                  )
                ],
              )
            ],
          ),
        ).withOnTap(onTap: (){
          Get.to((() => SzDetailPage()), arguments: {'model': m.billDetail});
        })
      ],
    );
  }
}

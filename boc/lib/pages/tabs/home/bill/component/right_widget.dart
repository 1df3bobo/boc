import 'package:boc/utils/abc_button.dart';
import 'package:boc/utils/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../bill_logic.dart';
import '../bill_state.dart';

class RightBillWidget extends StatefulWidget {
  const RightBillWidget({super.key});

  @override
  State<RightBillWidget> createState() => _RightBillWidgetState();
}

class _RightBillWidgetState extends State<RightBillWidget> {
  List title1 = ['全部', '少于1000', '1000-5000', '5000以上'];

  List title2 = ['全部', '工资', '网上快捷支付', '跨行转账', '转账收入', '其他'];

  List title3 = ['全部', '收入', '支出'];

  List title4 = ['人民币',];

  final BillLogic logic = Get.find<BillLogic>();
  final BillState state = Get.find<BillLogic>().state;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();


  void textFileValue({bool confirm = false}){
    if(state.selectPrice == '全部'){
      if(confirm){
        state.billData.minAmount = '';
        state.billData.maxAmount = '';
      }else {
        controller1.text = '';
        controller2.text = '';
      }


    }
    if(state.selectPrice == '少于1000'){
      if(confirm){
        state.billData.minAmount = '';
        state.billData.maxAmount = '1000';
      }else{
        controller1.text = '';
        controller2.text = '1000';
      }
    }
    if(state.selectPrice == '1000-5000'){
      if(confirm){
      }else{
        controller1.text = '1000';
        controller2.text = '5000';
      }
    }
    if(state.selectPrice == '5000以上'){
      if(confirm){
        state.billData.minAmount = '5000';
        state.billData.maxAmount = '';
      }else{
        controller1.text = '5000';
        controller2.text = '';
      }
    }
  }


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      controller1.text = state.billData.minAmount;
      controller2.text = state.billData.maxAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navHeight = MediaQuery.of(context).padding.top + 44.w;
    return Container(
      width: 1.sw * 0.88,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: navHeight,
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(
              right: 16.w,
              bottom: 12.w,
            ),
            child: BaseText(
              text: '取消',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: BColors.mainColor),
            ).withOnTap(onTap: (){
              SmartDialog.dismiss();
            }),
          ),
          Container(
            width: 1.sw,
            height: 0.5.w,
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            color: Color(0xffF4F4F4),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              ..._title1Widget(),
              ..._title2Widget(),
              ..._title3Widget(),
              ..._title4Widget(),
              ..._title5Widget(),
              SizedBox(height: 45.w,)
            ],
          ).expanded(),
          Row(
            children: [
              AbcButton(
                title: '重置',
                bgColor: Colors.white,
                titleColor: const Color(0xffCF0000),
                border: Border(
                  top: BorderSide(width: 1.w, color: const Color(0xFFE7E7E7)),
                ),
                onTap: (){
                  state.selectPrice = '全部';
                  state.selectType = ['全部'];
                  state.selectSzStr = '全部';
                  state.controller3.text = '';
                  state.controller4.text = '';
                  state.controller5.text = '';
                  textFileValue();
                  setState(() {});
                },
              ).expanded(),
              AbcButton(title: '确认',bgColor: Color(0xffCF0000),onTap: (){
                textFileValue(confirm: true);
                if(state.controller3.text == ''){
                  if(state.selectType.contains('全部')){
                    state.billData.transactionType = '';
                  }else {
                    state.billData.transactionType = state.selectType.join(',');
                  }
                }else {
                  state.billData.transactionType = '';
                }

                if(state.selectSzStr == '全部'){
                  state.billData.type = '';
                }
                if(state.selectSzStr == '收入'){
                  state.billData.type = '1';
                }
                if(state.selectSzStr == '支出'){
                  state.billData.type = '2';
                }
                state.billData.oppositeName = state.controller4.text;
                state.billData.oppositeAccount = state.controller4.text;
                state.billData.pageNum = 1;
                state.billData.endPageTime = '';
                logic.getData().then((_){
                  try {
                    state.controller.jumpTo(0);
                  }catch(e){}

                });
                SmartDialog.dismiss();
              },).expanded(),
            ],
          ),
          SizedBox(
            height: ScreenUtil().bottomBarHeight,
          )
        ],
      ),
    );
  }

  List<Widget> _title1Widget(){
    return [
      Container(
        width: 1.sw,
        padding: EdgeInsets.only(left: 12.w, top: 6.w, bottom: 12.w),
        alignment: Alignment.centerLeft,
        child: BaseText(
          text: '金额区间',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      VerticalGridView(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        widgetBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
                color: state.selectPrice == title1[index]
                    ? BColors.mainColor.withOpacity(0.06)
                    : const Color(0xffF4F4F4),
                border: Border.all(
                  color: state.selectPrice == title1[index]?BColors.mainColor:Colors.white,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.w))),
            alignment: Alignment.center,
            child: BaseText(
              text: title1[index],
              style: TextStyle(
                color: state.selectPrice == title1[index]
                    ? BColors.mainColor
                    : Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ).withOnTap(onTap: () {
            state.selectPrice = title1[index];
            textFileValue();
            setState(() {});
          });
        },
        itemCount: title1.length,
        crossCount: 2,
        mainHeight: 32.w,
        spacing: 10.w,
        crossSpacing: 15.w,
      ),

      SizedBox(height: 20.w),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFieldWidget(
            textAlign: TextAlign.center,
            hintText: '最低金额',
            controller: controller1,
            onChanged: (v){
              state.selectPrice = '';
              setState(() {});
            },
          ).withSizedBox(
            height: 32.w,
            width: (1.sw * 0.88 - 40.w)/2,
          ),
          Container(
            width: 6.w,
            height: 1,
            color: Color(0xff222222),
          ),
          TextFieldWidget(
            textAlign: TextAlign.center,
            hintText: '最高金额',
            controller: controller2,
            onChanged: (v){
              state.selectPrice = '';
              setState(() {});
            },
          ).withSizedBox(
            height: 32.w,
            width: (1.sw * 0.88 - 40.w)/2,
          ),
        ],
      ),
      SizedBox(height: 15.w),
    ];
  }

  List<Widget> _title2Widget(){
    return [
      Container(
        width: 1.sw,
        padding: EdgeInsets.only(left: 12.w, top: 6.w, bottom: 12.w),
        alignment: Alignment.centerLeft,
        child: BaseText(
          text: '交易类型',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      VerticalGridView(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        widgetBuilder: (_, index) {
          String name = title2[index];
          return Container(
            decoration: BoxDecoration(
                color: state.selectType.contains(name)
                    ? BColors.mainColor.withOpacity(0.06)
                    : const Color(0xffF4F4F4),
                border: Border.all(
                  color: state.selectType.contains(name)?BColors.mainColor:Colors.white,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.w))),
            alignment: Alignment.center,
            child: BaseText(
              text: name,
              style: TextStyle(
                color: state.selectType.contains(name)
                    ? BColors.mainColor
                    : Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ).withOnTap(onTap: () {
            state.controller3.text = '';
            FocusScope.of(context).unfocus();
            if(name == '全部'){
              if(state.selectType.contains(name)){
                state.selectType.remove(name);
              }else {
                state.selectType.clear();
                state.selectType.add(name);
              }
            }else {
              state. selectType.remove('全部');
              if(state.selectType.contains(name)){
                state.selectType.remove(name);
              }else{
                state.selectType.add(name);
              }
            }
            setState(() {});
          });
        },
        itemCount: title2.length,
        crossCount: 2,
        mainHeight: 32.w,
        spacing: 10.w,
        crossSpacing: 15.w,
      ),
      TextFieldWidget(hintText: '非必输',
      controller: state.controller3,
        onChanged: (v){
        state.selectType.clear();
        setState(() {});
        },
      ).withContainer(
          width: 1.sw * 0.8,
          padding: EdgeInsets.only(left: 15.w,top: 10.w,)
      ),
      SizedBox(height: 10.w),

    ];
  }

  List<Widget> _title3Widget(){
    return [
      Container(
        width: 1.sw,
        padding: EdgeInsets.only(left: 12.w, top: 6.w, bottom: 12.w),
        alignment: Alignment.centerLeft,
        child: BaseText(
          text: '收支',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      VerticalGridView(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        widgetBuilder: (_, index) {
          String name = title3[index];
          return Container(
            decoration: BoxDecoration(
                color: state.selectSzStr.contains(name)
                    ? BColors.mainColor.withOpacity(0.06)
                    : const Color(0xffF4F4F4),
                border: Border.all(
                  color: state.selectSzStr.contains(name)?BColors.mainColor:Colors.white,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.w))),
            alignment: Alignment.center,
            child: BaseText(
              text: name,
              style: TextStyle(
                color: state.selectSzStr.contains(name)
                    ? BColors.mainColor
                    : Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ).withOnTap(onTap: () {
            state.selectSzStr = name;
            setState(() {});
          });
        },
        itemCount: title3.length,
        crossCount: 3,
        mainHeight: 32.w,
        spacing: 10.w,
        crossSpacing: 15.w,
      ),
      SizedBox(height: 15.w),
    ];
  }

  List<Widget> _title4Widget(){
    return [
      Container(
        width: 1.sw,
        padding: EdgeInsets.only(left: 12.w, top: 6.w, bottom: 12.w),
        alignment: Alignment.centerLeft,
        child: BaseText(
          text: '币种',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      VerticalGridView(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        widgetBuilder: (_, index) {
          String name = title4[index];
          return Container(
            decoration: BoxDecoration(
                color: BColors.mainColor.withOpacity(0.06),
                border: Border.all(
                  color:BColors.mainColor,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.w))),
            alignment: Alignment.center,
            child: BaseText(
              text: name,
              style: TextStyle(
                color:  BColors.mainColor,
                fontSize: 12.sp,
              ),
            ),
          );
        },
        itemCount: title4.length,
        crossCount: 3,
        mainHeight: 32.w,
        spacing: 10.w,
        crossSpacing: 15.w,
      ),
      SizedBox(height: 15.w),
    ];
  }

  List<Widget> _title5Widget(){
    return [
      Container(
        width: 1.sw,
        padding: EdgeInsets.only(left: 12.w, top: 6.w, bottom: 12.w),
        alignment: Alignment.centerLeft,
        child: BaseText(
          text: '对方名称',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
      ),

      TextFieldWidget(hintText: '非必输',controller: state.controller4,).withContainer(
        width: 1.sw * 0.8,
        padding: EdgeInsets.only(left: 15.w,)
      ),
      SizedBox(height: 15.w),
      Container(
        width: 1.sw,
        padding: EdgeInsets.only(left: 12.w, top: 6.w, bottom: 12.w),
        alignment: Alignment.centerLeft,
        child: BaseText(
          text: '对方账号',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
      ),

      TextFieldWidget(hintText: '非必输',controller: state.controller5,).withContainer(
          width: 1.sw * 0.8,
          padding: EdgeInsets.only(left: 15.w,)
      ),
      SizedBox(height: 15.w),
    ];
  }
}

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

import '../sz_records_logic.dart';
import '../sz_records_state.dart';

class RightSzWidget extends StatefulWidget {
  const RightSzWidget({super.key});

  @override
  State<RightSzWidget> createState() => _RightSzWidgetState();
}

class _RightSzWidgetState extends State<RightSzWidget> {
  List title1 = ['全部', '少于1000', '1000-5000', '5000以上'];



  String qbZcTitle = '全部';
  bool showZc = true;
  List title2_0 = [
    "餐饮",
    "私家车",
    "服饰鞋包",
    "商超便利",
    "网上消费",
    "话费宽带",
    "水电物业",
    "电子数码",
    "休闲娱乐",
  ];

  List title2_1 = ["转账给他人", "人情往来", "其他还款"];

  String qbSrTitle = ' 全部 ';
  bool showSr = true;
  List title3_0 = [" 全部 ", "退款", "利息收入", "贷款借入", "其他收入"];

  String qbWLTitle = '  全部  ';
  bool showWl = true;
  List title4_0 = ["账户互转", "信用卡还款"];
  List title4_1 = ["基金", "债券"];

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  final SzRecordsLogic logic = Get.find<SzRecordsLogic>();
  final SzRecordsState state = Get.find<SzRecordsLogic>().state;

  String filterTitle(int index) {
    if (index == 0) {
      if (state.selectCategorys.contains(qbZcTitle)) {
        return '全部';
      }
      final setB = title2_0.toSet();
      final setC = title2_1.toSet();
      List result = state.selectCategorys
          .where((item) => setB.contains(item) || setC.contains(item))
          .toList();
      if (result.isEmpty) return '';
      return '已选${result.length}个';
    }
    if (index == 1) {
      if (state.selectCategorys.contains(qbSrTitle)) {
        return '全部';
      }
      final setB = title3_0.toSet();
      List result =
      state.selectCategorys.where((item) => setB.contains(item)).toList();
      if (result.isEmpty) return '';
      return '已选${result.length}个';
    }
    if (index == 2) {
      if (state.selectCategorys.contains(qbWLTitle)) {
        return '全部';
      }
      final setB = title4_0.toSet();
      final setC = title4_1.toSet();
      List result = state.selectCategorys
          .where((item) => setB.contains(item) || setC.contains(item))
          .toList();
      if (result.isEmpty) return '';
      return '已选${result.length}个';
    }
    return '';
  }

  void textFileValue({bool confirm = false}){
    if(state.selectPrice == '全部'){
      if(confirm){
        state.szData.minAmount = '';
        state.szData.maxAmount = '';
      }else {
        controller1.text = '';
        controller2.text = '';
      }


    }
    if(state.selectPrice == '少于1000'){
      if(confirm){
        state.szData.minAmount = '';
        state.szData.maxAmount = '1000';
      }else{
        controller1.text = '';
        controller2.text = '1000';
      }
    }
    if(state.selectPrice == '1000-5000'){
      if(confirm){
        state.szData.minAmount = '1000';
        state.szData.maxAmount = '5000';
      }else{
        controller1.text = '1000';
        controller2.text = '5000';
      }
    }
    if(state.selectPrice == '5000以上'){
      if(confirm){
        state.szData.minAmount = '5000';
        state.szData.maxAmount = '';
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
      controller1.text = state.szData.minAmount;
      controller2.text = state.szData.maxAmount;
      filterTitle(0);
      filterTitle(1);
      filterTitle(2);
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
            ).withOnTap(onTap: () {
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
            padding: EdgeInsets.only(bottom: 45.w),
            children: [
              _titleWidget('金额区间'),
              ..._title1Widget(),
              _titleWidget('交易种类'),
              ..._title2Widget(),
              ..._title3Widget(),
              ..._title4Widget(),
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
                  state.selectPrice = '';
                  state.selectCategorys.clear();
                  controller1.text = '';
                  controller2.text = '';
                  setState(() {});
                },
              ).expanded(),
              AbcButton(
                title: '确认',
                bgColor: Color(0xffCF0000),
                onTap: (){
                  List temCat = [...state.selectCategorys];
                  temCat.remove('全部');
                  temCat.remove(' 全部 ');
                  temCat.remove('  全部  ');
                  state.szData.categorys = temCat.join(',');
                  SmartDialog.dismiss();
                  textFileValue(confirm: true);
                  logic.update(['updatesx']);
                  state.szData.pageNum = 1;
                  state.szData.endPageTime = '';
                  if(logic.showRange){
                    logic.getData2().then((_){
                      try {
                        state.rangeController.jumpTo(0);
                      }catch(e){}
                    });
                  }else{
                    logic.getData1().then((_){
                      try {
                        state.controller.jumpTo(0);
                      }catch(e){}

                    });
                  }

                },
              ).expanded(),
            ],
          ),
          SizedBox(
            height: ScreenUtil().bottomBarHeight,
          )
        ],
      ),
    );
  }

  Widget _titleWidget(String name) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.only(left: 12.w, top: 12.w, bottom: 12.w),
      alignment: Alignment.centerLeft,
      child: BaseText(
        text: name,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<Widget> _title1Widget() {
    return [
      VerticalGridView(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        widgetBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
                color: state.selectPrice == title1[index]
                    ? BColors.mainColor.withOpacity(0.06)
                    : const Color(0xffF4F4F4),
                border: Border.all(
                  color: state.selectPrice == title1[index]
                      ? BColors.mainColor
                      : Colors.white,
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
        crossCount: 3,
        mainHeight: 32.w,
        spacing: 10.w,
        crossSpacing: 15.w,
      ),
      SizedBox(height: 30.w),
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
      SizedBox(
        height: 15.w,
      ),
    ];
  }

  List<Widget> _title2Widget() {
    return [
      Container(
        width: 1.sw * 0.88,
        height: 42.w,
        color: Color(0xffF9F9F9),
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: '支出',
              fontSize: 15,
            ),
            Row(
              children: [
                BaseText(text: filterTitle(0)),
                Image(
                  image: showZc ? 'ic_jt_top'.png3x : 'ic_jt_bottom'.png3x,
                  width: 25.w,
                )
              ],
            ).withOnTap(onTap: () {
              showZc = !showZc;
              setState(() {});
            })
          ],
        ),
      ),
      ...!showZc
          ? []
          : [
              SizedBox(height: 15.w),
              VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                widgetBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: state.selectCategorys.contains(qbZcTitle)
                            ? BColors.mainColor.withOpacity(0.06)
                            : const Color(0xffF4F4F4),
                        border: Border.all(
                          color: state.selectCategorys.contains(qbZcTitle)
                              ? BColors.mainColor
                              : Colors.white,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    alignment: Alignment.center,
                    child: BaseText(
                      text: qbZcTitle,
                      style: TextStyle(
                        color: state.selectCategorys.contains(qbZcTitle)
                            ? BColors.mainColor
                            : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ).withOnTap(onTap: () {
                    if (state.selectCategorys.contains(qbZcTitle)) {
                      state.selectCategorys.remove(qbZcTitle);
                    } else {
                      state.selectCategorys
                          .removeWhere((item) => title2_0.contains(item));
                      state.selectCategorys
                          .removeWhere((item) => title2_1.contains(item));
                      state.selectCategorys.add(qbZcTitle);
                    }
                    setState(() {});
                  });
                },
                itemCount: 1,
                crossCount: 3,
                mainHeight: 32.w,
                spacing: 10.w,
                crossSpacing: 15.w,
              ),
              BaseText(
                text: '日常支出',
                color: Color(0xff666666),
              ).withPadding(
                top: 15.w,
                left: 15.w,
                bottom: 8.w,
              ),
              VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                widgetBuilder: (_, index) {
                  String name = title2_0[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor.withOpacity(0.06)
                            : const Color(0xffF4F4F4),
                        border: Border.all(
                          color: state.selectCategorys.contains(name)
                              ? BColors.mainColor
                              : Colors.white,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    alignment: Alignment.center,
                    child: BaseText(
                      text: name,
                      style: TextStyle(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor
                            : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ).withOnTap(onTap: () {
                    state.selectCategorys.remove(qbZcTitle);
                    if (state.selectCategorys.contains(name)) {
                      state.selectCategorys.remove(name);
                    } else {
                      state.selectCategorys.add(name);
                    }
                    setState(() {});
                  });
                },
                itemCount: title2_0.length,
                crossCount: 3,
                mainHeight: 32.w,
                spacing: 10.w,
                crossSpacing: 15.w,
              ),
              BaseText(
                text: '日常支出',
                color: Color(0xff666666),
              ).withPadding(
                top: 15.w,
                left: 15.w,
                bottom: 8.w,
              ),
              VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                widgetBuilder: (_, index) {
                  String name = title2_1[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor.withOpacity(0.06)
                            : const Color(0xffF4F4F4),
                        border: Border.all(
                          color: state.selectCategorys.contains(name)
                              ? BColors.mainColor
                              : Colors.white,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    alignment: Alignment.center,
                    child: BaseText(
                      text: name,
                      style: TextStyle(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor
                            : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ).withOnTap(onTap: () {
                    state.selectCategorys.remove(qbZcTitle);
                    if (state.selectCategorys.contains(name)) {
                      state.selectCategorys.remove(name);
                    } else {
                      state.selectCategorys.add(name);
                    }
                    setState(() {});
                  });
                },
                itemCount: title2_1.length,
                crossCount: 3,
                mainHeight: 32.w,
                spacing: 10.w,
                crossSpacing: 15.w,
              ),
              SizedBox(height: 15.w),
            ]
    ];
  }

  List<Widget> _title3Widget() {
    return [
      Container(
        width: 1.sw * 0.88,
        height: 42.w,
        color: Color(0xffF9F9F9),
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: '收入',
              fontSize: 15,
            ),
            Row(
              children: [
                BaseText(text: filterTitle(1)),
                Image(
                  image: showSr ? 'ic_jt_top'.png3x : 'ic_jt_bottom'.png3x,
                  width: 25.w,
                )
              ],
            ).withOnTap(onTap: () {
              showSr = !showSr;
              setState(() {});
            })
          ],
        ),
      ),
      ...!showSr
          ? []
          : [
              SizedBox(height: 15.w),
              VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                widgetBuilder: (_, index) {
                  String name = title3_0[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor.withOpacity(0.06)
                            : const Color(0xffF4F4F4),
                        border: Border.all(
                          color: state.selectCategorys.contains(name)
                              ? BColors.mainColor
                              : Colors.white,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    alignment: Alignment.center,
                    child: BaseText(
                      text: name,
                      style: TextStyle(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor
                            : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ).withOnTap(onTap: () {
                    if (name == qbSrTitle) {
                      if (state.selectCategorys.contains(name)) {
                        state.selectCategorys.remove(name);
                      } else {
                        state.selectCategorys
                            .removeWhere((item) => title3_0.contains(item));
                        state.selectCategorys.add(name);
                      }
                    } else {
                      if (state.selectCategorys.contains(name)) {
                        state.selectCategorys.remove(name);
                      } else {
                        state.selectCategorys.remove(qbSrTitle);
                        state.selectCategorys.add(name);
                      }
                    }
                    setState(() {});
                  });
                },
                itemCount: title3_0.length,
                crossCount: 3,
                mainHeight: 32.w,
                spacing: 10.w,
                crossSpacing: 15.w,
              ),
              SizedBox(height: 15.w),
            ]
    ];
  }

  List<Widget> _title4Widget() {
    return [
      Container(
        width: 1.sw * 0.88,
        height: 42.w,
        color: Color(0xffF9F9F9),
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: '内部资金往来',
              fontSize: 15,
            ),
            Row(
              children: [
                BaseText(text: filterTitle(2)),
                Image(
                  image: showWl ? 'ic_jt_top'.png3x : 'ic_jt_bottom'.png3x,
                  width: 25.w,
                )
              ],
            ).withOnTap(onTap: () {
              showWl = !showWl;
              setState(() {});
            })
          ],
        ),
      ),
      ...!showWl
          ? []
          : [
              SizedBox(height: 15.w),
              VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                widgetBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: state.selectCategorys.contains(qbWLTitle)
                            ? BColors.mainColor.withOpacity(0.06)
                            : const Color(0xffF4F4F4),
                        border: Border.all(
                          color: state.selectCategorys.contains(qbWLTitle)
                              ? BColors.mainColor
                              : Colors.white,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    alignment: Alignment.center,
                    child: BaseText(
                      text: qbWLTitle,
                      style: TextStyle(
                        color: state.selectCategorys.contains(qbWLTitle)
                            ? BColors.mainColor
                            : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ).withOnTap(onTap: () {
                    if (state.selectCategorys.contains(qbWLTitle)) {
                      state.selectCategorys.remove(qbWLTitle);
                    } else {
                      state.selectCategorys
                          .removeWhere((item) => title4_0.contains(item));
                      state.selectCategorys
                          .removeWhere((item) => title4_1.contains(item));
                      state.selectCategorys.add(qbWLTitle);
                    }
                    setState(() {});
                  });
                },
                itemCount: 1,
                crossCount: 3,
                mainHeight: 32.w,
                spacing: 10.w,
                crossSpacing: 15.w,
              ),
              BaseText(
                text: '日常往来',
                color: Color(0xff666666),
              ).withPadding(
                top: 15.w,
                left: 15.w,
                bottom: 8.w,
              ),
              VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                widgetBuilder: (_, index) {
                  String name = title4_0[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor.withOpacity(0.06)
                            : const Color(0xffF4F4F4),
                        border: Border.all(
                          color: state.selectCategorys.contains(name)
                              ? BColors.mainColor
                              : Colors.white,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    alignment: Alignment.center,
                    child: BaseText(
                      text: name,
                      style: TextStyle(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor
                            : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ).withOnTap(onTap: () {
                    state.selectCategorys.remove(qbWLTitle);
                    if (state.selectCategorys.contains(name)) {
                      state.selectCategorys.remove(name);
                    } else {
                      state.selectCategorys.add(name);
                    }
                    setState(() {});
                  });
                },
                itemCount: title4_0.length,
                crossCount: 3,
                mainHeight: 32.w,
                spacing: 10.w,
                crossSpacing: 15.w,
              ),
              BaseText(
                text: '投资理财',
                color: Color(0xff666666),
              ).withPadding(
                top: 15.w,
                left: 15.w,
                bottom: 8.w,
              ),
              VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                widgetBuilder: (_, index) {
                  String name = title4_1[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor.withOpacity(0.06)
                            : const Color(0xffF4F4F4),
                        border: Border.all(
                          color: state.selectCategorys.contains(name)
                              ? BColors.mainColor
                              : Colors.white,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    alignment: Alignment.center,
                    child: BaseText(
                      text: name,
                      style: TextStyle(
                        color: state.selectCategorys.contains(name)
                            ? BColors.mainColor
                            : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ).withOnTap(onTap: () {
                    state.selectCategorys.remove(qbWLTitle);
                    if (state.selectCategorys.contains(name)) {
                      state.selectCategorys.remove(name);
                    } else {
                      state.selectCategorys.add(name);
                    }
                    setState(() {});
                  });
                },
                itemCount: title4_1.length,
                crossCount: 3,
                mainHeight: 32.w,
                spacing: 10.w,
                crossSpacing: 15.w,
              ),
            ]
    ];
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/app_config.dart';
import '../../../../../../utils/color_util.dart';
import '../card_transfer_logic.dart';
import '../card_transfer_state.dart';
import 'account_transfer_widget.dart';

class MoneyWidget extends StatefulWidget {
  const MoneyWidget({super.key});

  @override
  State<MoneyWidget> createState() => _MoneyWidgetState();
}

class _MoneyWidgetState extends State<MoneyWidget> with WidgetsBindingObserver {
  final CardTransferLogic logic = Get.put(CardTransferLogic());
  final CardTransferState state = Get.find<CardTransferLogic>().state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0 && state.moneyFocusNode.hasFocus) {
      state.moneyTextController.text = state.moneyStr;
    }
    if (bottomInset == 0) {
      if (state.moneyStr != '') {
        String money = NumberFormat("#,##0.00", "zh_CN")
            .format(double.parse(state.moneyStr));
        state.moneyTextController.text = money;
      }
      logic.update(['updateCardTransfer']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      color: Colors.white,
      margin: EdgeInsets.only(top: 15.w),
      child: Column(
        children: [
          Row(
            children: [
              BaseText(
                text: "转账金额",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff2E2E30),
                    fontWeight: FontWeight.bold),
              ),
              BaseText(
                text: ' (人民币元)',
                fontSize: 12,
              )
            ],
          ).withContainer(
              width: 1.sw,
              padding: EdgeInsets.only(top: 12.w, left: 15.w, bottom: 12.w)),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transfer.itemCellWidget(
                  title: "",
                  hintText: '请输入转账金额(免手续费)',
                  controller: state.moneyTextController,
                  focusNode: state.moneyFocusNode,
                  style:
                      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
                  hintColor: Color(0xff9B9B9B),
                  textColor: const Color(0xff333333),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                    _DecimalTextInputFormatter(),
                    _MaxValueInputFormatter(1000000000), // 自定义的最大值限制
                  ],
                  onSubmitted: (v) {
                    logic.update(['updateBottom']);
                  },
                  onChanged: (value) {
                    state.moneyStr = value;
                    state.cardReq.amount = state.moneyStr;
                    logic.update(['updateBottom']);
                  }).withContainer(
                  width: 1.sw,
                  height: 45.w,
                  margin: EdgeInsets.only(
                    bottom: 12.w,
                  )),
              Container(
                width: 1.sw,
                height: 0.5.w,
                margin: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                color: Color(0xffF4F4F4),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 15.w),
                child: Column(
                  spacing: 12.w,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText(
                          text: '付款账户',
                          color: Color(0xff333333),
                        ),
                        Row(
                          children: [
                            BaseText(
                              text: AppConfig.config.abcLogic.card(),
                              color: Color(0xff333333),
                            ),
                            Image(image: 'ic_jt_right'.png3x,width: 20.w,)
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        BaseText(
                          text: '可用余额',
                          fontSize: 12.w,
                          color: Color(0xff666666),
                        ),
                        BaseText(
                          text: '人民币元 ${AppConfig.config.abcLogic.balance()}',
                          fontSize: 12.w,
                          color: BColors.mainColor,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 如果新值包含多个小数点，则返回旧值
    if (newValue.text.split('.').length > 2) {
      return oldValue;
    }
    return newValue;
  }
}

// 自定义 TextInputFormatter 限制最大值
class _MaxValueInputFormatter extends TextInputFormatter {
  final double maxValue;

  _MaxValueInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    try {
      final number = double.parse(newValue.text);
      if (number > maxValue) {
        return oldValue; // 如果超过最大值，返回旧值
      }
      return newValue;
    } catch (e) {
      return oldValue;
    }
  }
}

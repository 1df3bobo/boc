import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

/// 交易明细 — 选择「交易对象」底部弹层（与设计稿一致）。
class TransactionCounterpartyBottomSheet {
  TransactionCounterpartyBottomSheet._();

  static const Color _titleBlue = Color(0xff3374ED);
  static const Color _checkGreen = Color(0xff2F805A);

  /// 与 [SzDetailLogic.loadCounterpartyOptions] 一致；列表未注入时的兜底
  static const List<String> _kFallbackOptions = [
    '本人',
    '家庭公用',
    '父母',
    'TA',
    '孩子',
    '亲人',
    '朋友',
  ];

  static Future<void> show(
    BuildContext context, {
    required List<String> options,
    required String current,
    required void Function(String value) onConfirm,
  }) {
    final opts =
        options.isNotEmpty ? List<String>.from(options) : _kFallbackOptions;
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.45),
      isScrollControlled: true,
      builder: (ctx) {
        return _CounterpartySheetBody(
          options: opts,
          current: current,
          onConfirm: (v) {
            onConfirm(v);
            Navigator.of(ctx).pop();
          },
          onCancel: () => Navigator.of(ctx).pop(),
          checkGreen: _checkGreen,
          titleBlue: _titleBlue,
        );
      },
    );
  }
}

class _CounterpartySheetBody extends StatefulWidget {
  const _CounterpartySheetBody({
    required this.options,
    required this.current,
    required this.onConfirm,
    required this.onCancel,
    required this.checkGreen,
    required this.titleBlue,
  });

  final List<String> options;
  final String current;
  final void Function(String value) onConfirm;
  final VoidCallback onCancel;
  final Color checkGreen;
  final Color titleBlue;

  @override
  State<_CounterpartySheetBody> createState() => _CounterpartySheetBodyState();
}

class _CounterpartySheetBodyState extends State<_CounterpartySheetBody> {
  late String _temp;

  @override
  void initState() {
    super.initState();
    _temp = widget.current.isNotEmpty &&
            widget.options.contains(widget.current)
        ? widget.current
        : (widget.options.isNotEmpty ? widget.options.first : '');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 12.w, 8.w, 10.w),
              child: Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: widget.onCancel,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 4.w),
                      child: BaseText(
                        text: '取消',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xff222222),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: BaseText(
                        text: '交易对象',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff222222),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (_temp.isNotEmpty) {
                        widget.onConfirm(_temp);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 4.w),
                      child: BaseText(
                        text: '确定',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: widget.titleBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: const Color(0xffEEEEEE)),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 1.sh * 0.5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < widget.options.length; i++) ...[
                      if (i > 0)
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xffEEEEEE),
                        ),
                      InkWell(
                        onTap: () =>
                            setState(() => _temp = widget.options[i]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 14.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: BaseText(
                                  text: widget.options[i],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xff222222),
                                  ),
                                ),
                              ),
                              _RadioDot(
                                selected: _temp == widget.options[i],
                                green: widget.checkGreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected, required this.green});

  final bool selected;
  final Color green;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Container(
        width: 22.w,
        height: 22.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: green,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check, size: 14.w, color: Colors.white),
      );
    }
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xffCCCCCC), width: 1.5),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 交易明细 — 修改交易备注：居中白底弹窗（与设计稿一致）。
///
/// 持久化由 SzDetailLocalStore 在详情页确认后写入。
class TransactionRemarkDialog {
  TransactionRemarkDialog._();

  static const Color _bocRed = Color(0xFFE60012);

  static Future<String?> show(
    BuildContext context, {
    String? initialText,
    int? billDetailId,
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 8,
          clipBehavior: Clip.antiAlias,
          insetPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: _TransactionRemarkDialogContent(
            initialText: initialText ?? '',
            billDetailId: billDetailId,
          ),
        );
      },
    );
  }
}

class _TransactionRemarkDialogContent extends StatefulWidget {
  const _TransactionRemarkDialogContent({
    required this.initialText,
    this.billDetailId,
  });

  final String initialText;
  final int? billDetailId;

  @override
  State<_TransactionRemarkDialogContent> createState() =>
      _TransactionRemarkDialogContentState();
}

class _TransactionRemarkDialogContentState
    extends State<_TransactionRemarkDialogContent> {
  static const int _maxLen = 160;

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final len = _controller.text.length;
    final radius = BorderRadius.circular(8.r);

    return ClipRRect(
      borderRadius: radius,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 18.w, 16.w, 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: 4,
                    minLines: 3,
                    maxLength: _maxLen,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xff222222),
                      height: 1.35,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: '请输入备注信息',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xffBBBBBB),
                      ),
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                SizedBox(height: 8.w),
                Text(
                  '$len/$_maxLen',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xff999999),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: const Color(0xffEEEEEE)),
          SizedBox(
            height: 48.w,
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Center(
                        child: Text(
                          '取消',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: TransactionRemarkDialog._bocRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: const Color(0xffEEEEEE),
                ),
                Expanded(
                  child: Material(
                    color: TransactionRemarkDialog._bocRed,
                    child: InkWell(
                      onTap: () =>
                          Navigator.of(context).pop(_controller.text.trim()),
                      child: Center(
                        child: Text(
                          '确认',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

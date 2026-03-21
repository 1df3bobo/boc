import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class WithdrawalPasswordDialog extends StatefulWidget {
  final String? fullCardNumber;
  final VoidCallback onRevealed;

  const WithdrawalPasswordDialog({
    super.key,
    this.fullCardNumber,
    required this.onRevealed,
  });

  @override
  State<WithdrawalPasswordDialog> createState() =>
      _WithdrawalPasswordDialogState();
}

class _WithdrawalPasswordDialogState extends State<WithdrawalPasswordDialog> {
  int _inputCount = 0;
  static const int _maxLength = 6;

  void _onKeyboardTap() {
    if (_inputCount >= _maxLength) return;
    setState(() => _inputCount++);
    if (_inputCount == _maxLength) {
      Future.delayed(const Duration(milliseconds: 150), () {
        SmartDialog.dismiss();
        if (widget.fullCardNumber?.isNotEmpty == true) {
          Clipboard.setData(ClipboardData(text: widget.fullCardNumber!));
          '复制成功，去粘贴'.showToast;
        }
        widget.onRevealed();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: Stack(
        children: [
          // 居中弹窗
          Center(
            child: Container(
              width: 1.sw * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题栏
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        text: '切换认证',
                        fontSize: 14.sp,
                        color: const Color(0xff2D70ED),
                      ),
                      BaseText(
                        text: '取款密码',
                        fontSize: 16.sp,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      BaseText(
                        text: '   ×',
                        fontSize: 20.sp,
                        color: const Color(0xff999999),
                      ).withOnTap(onTap: () => SmartDialog.dismiss()),
                    ],
                  ).withPadding(
                    top: 14.w,
                    bottom: 14.w,
                    left: 16.w,
                    right: 16.w,
                  ),

                  Container(height: 0.5.w, color: const Color(0xffD8D8E0)),

                  // 提示文字
                  BaseText(
                    text: '请输入取款密码',
                    fontSize: 14.sp,
                    color: const Color(0xff222222),
                  ).withPadding(top: 16.w, bottom: 16.w, left: 16.w),

                  // 圆点密码显示
                  Container(
                    height: 50.w,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xff666666), width: 0.8),
                    ),
                    child: Row(
                      children: List.generate(_maxLength, (i) {
                        final filled = i < _inputCount;
                        return Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: i < _maxLength - 1
                                    ? const BorderSide(
                                        color: Color(0xffdedede), width: 0.8)
                                    : BorderSide.none,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: filled
                                ? Container(
                                    width: 10.w,
                                    height: 10.w,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 12.w),

                  // 说明文字
                  BaseText(
                    text: '取款密码是您在ATM机取款时使用的6位数字密码，您可通过手机银行账户管理功能或携带身份证和银行卡前往营业网点修改。',
                    fontSize: 12.sp,
                    color: const Color(0xff666666),
                    maxLines: 3,
                  ).withPadding(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.w,
                  ),
                ],
              ),
            ),
          ),

          // 底部键盘图片
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: _onKeyboardTap,
              child: Image(
                image: 'safe_board'.png3x,
                width: 1.sw,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

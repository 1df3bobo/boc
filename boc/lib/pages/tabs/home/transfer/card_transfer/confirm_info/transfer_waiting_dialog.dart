import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../card_req.dart';
import '../trans_result_view.dart';

/// 转账等待全屏页：白底 + 顶图 + 环形倒计时。
/// 圆环按 [totalSeconds] 秒走完一整圈（仅视觉节奏）；剩余时间数到 [dismissAtRemainingSeconds] 秒时即关弹窗。
class TransferWaitingDialog extends StatefulWidget {
  const TransferWaitingDialog({super.key, required this.cardReq});

  final CardReq cardReq;

  /// 总时长（秒），圆环走满一圈对应的动画时长。
  static const int totalSeconds = 6;

  /// 剩余秒数显示为该值时关闭页面（不必等圆环走满）。
  static const int dismissAtRemainingSeconds = 3;

  @override
  State<TransferWaitingDialog> createState() => _TransferWaitingDialogState();
}

class _TransferWaitingDialogState extends State<TransferWaitingDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _ended = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: TransferWaitingDialog.totalSeconds),
    )..addListener(_onTick);
    _controller.forward();
  }

  void _onTick() {
    if (_ended || !mounted) return;
    final threshold = (TransferWaitingDialog.totalSeconds -
            TransferWaitingDialog.dismissAtRemainingSeconds) /
        TransferWaitingDialog.totalSeconds;
    if (_controller.value >= threshold) {
      _ended = true;
      _controller.stop();
      SmartDialog.dismiss();
      openTransferResultPage(widget.cardReq);
    }
  }

  int _displaySeconds(double progress) {
    if (progress >= 1.0) return 0;
    return (TransferWaitingDialog.totalSeconds * (1 - progress))
        .ceil()
        .clamp(1, TransferWaitingDialog.totalSeconds);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTick);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: ColoredBox(
        color: Colors.white,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final progress = _controller.value;
            final displaySec = _displaySeconds(progress);

            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Image(
                  image: 'trans_waiting_bg'.png3x,
                  width: 1.sw,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                    top: 80.w,
                    child: _CountdownRing(progress: progress, seconds: displaySec)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CountdownRing extends StatelessWidget {
  const _CountdownRing({
    required this.progress,
    required this.seconds,
  });

  final double progress;
  final int seconds;

  static const Color _teal = Color(0xff2DB89E);
  static const Color _track = Color(0xffE8E8E8);

  @override
  Widget build(BuildContext context) {
    final size = 100.w;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: progress,
              trackColor: _track,
              progressColor: _teal,
              strokeWidth: 6.w,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$seconds',
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff222222),
                  height: 1.0,
                ),
              ),
              Text(
                '秒',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff999999),
                  height: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final arcPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const start = -math.pi / 2;
    final sweep = 2 * math.pi * progress;
    canvas.drawArc(rect, start, sweep, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class CountdownLoader extends StatefulWidget {
  @override
  _CountdownLoaderState createState() => _CountdownLoaderState();
}

class _CountdownLoaderState extends State<CountdownLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _controller.forward();

    _controller.addListener(() {
      if (_controller.value >= 0.225) {
        _controller.stop(); // 停止动画防止多次触发
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 140.w),
      alignment: Alignment.topCenter,
      child:Column(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              int countdownValue = 8 - (_controller.value * 8).floor();
              return Stack(
                alignment: Alignment.center,
                children: [
                  // 背景圆环 (浅色，增加视觉导向)
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 8,
                      color: Colors.grey[200],
                    ),
                  ),
                  // 进度圆环 (动画进度)
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: _controller.value, // 进度跟随动画
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 3, 134, 91)),
                    ),
                  ),
                  // 中间的倒计时数字
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$countdownValue',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      BaseText(text: '秒',fontSize: 12,).withPadding(bottom: 4.w)
                    ],
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 25.w,),
          BaseText(text: '正在等待对方银行返回结果...\n结果返回前，请不要重复提交',style: TextStyle(
            fontSize: 18.w,
            fontWeight: FontWeight.bold
          ),)
        ],
      )
    );
  }
}

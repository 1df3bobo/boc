import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../routes/app_pages.dart';
import '../../utils/color_util.dart';
import 'login_logic.dart';
import 'login_state.dart';

class LoginPage extends BaseStateless {
  LoginPage({Key? key}) : super(key: key,);

  final LoginLogic logic = Get.put(LoginLogic());
  final LoginState state = Get.find<LoginLogic>().state;


  @override
  Color? get background => Colors.white;
  @override
  Widget? get leftItem => Container();

  @override
  bool get isChangeNav => true;

  @override
  Widget initBody(BuildContext context) {
    return Stack(children: [

      Image(image: 'login_bg'.png3x),
      Positioned(
        top: ScreenUtil().statusBarHeight + 45.w + 45.w,
        left: 15.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: '您好，',
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            BaseText(
              text: '欢迎来到中国银行',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff343434)
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 110.w + ScreenUtil().statusBarHeight + 25.w + 45.w, // 调整垂直位置
        left: 20.w, // 调整水平位置
        right: 20.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 4.w,
                ),
                TextField(
                  controller: state.phoneTextController,
                  decoration: InputDecoration(
                    border: InputBorder.none, // 隐藏边框
                    hintText: '请输入手机号',
                    hintStyle: TextStyle(
                      color: Color(0xff999999), // 设置提示文字颜色
                      fontSize: 16.0, // 可选：调整字体大小
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ).expanded(),
              ],
            ),
            Divider(
              color: Color(0xffEBEBEB),
              height: 0.5,
              thickness: 1,
            ),

            SizedBox(
              height: 25.w,
            ),

            Row(
              children: [
                SizedBox(
                  width: 4.w,
                ),
                TextField(
                  controller: state.psdTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none, // 隐藏边框
                    hintText: '请输入登录密码',
                    hintStyle: TextStyle(
                      color: Color(0xff999999), // 设置提示文字颜色
                      fontSize: 16.0, // 可选：调整字体大小
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ).expanded(),
              ],
            ),
            Divider(
              color: Color(0xffEBEBEB),
              height: 0.5,
              thickness: 1,
            ),

            SizedBox(
              height: 42.w,
            ),

            SizedBox(
              width: double.infinity, // 使按钮宽度和下划线一样长
              height: 44.w,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      BColors.mainColor),
                  elevation: WidgetStateProperty.all(0),
                ),
                onPressed:  () => logic.goLogin(),
                child: Text('立即登录',style: TextStyle(
                    fontSize: 17.sp
                ),),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 25.w)),

          ],
        ),
      ),
    ]);
  }
}

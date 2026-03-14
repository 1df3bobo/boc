import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:boc/pages/tabs/home/bill/bill_view.dart';
import 'package:boc/pages/tabs/mine/account_preview/account_preview_view.dart';
import 'package:boc/pages/tabs/mine/sz_records/sz_records_view.dart';
import 'package:boc/pages/other/print/print_view.dart';

import '../home_logic.dart';
import 'two_level_logic.dart';
import 'two_level_state.dart';

class TwoLevelPage extends StatelessWidget {
  const TwoLevelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TwoLevelLogic logic = Get.put(TwoLevelLogic());
    final TwoLevelState state = Get.find<TwoLevelLogic>().state;

    return Stack(
      children: [
        Image(
          image: 'home_two_transation_1'.png,
          fit: BoxFit.fill,
          width: 1.sw,
        ),
        Positioned(
            top: 70.w,
            left: 15.w,
            child: Container(
              width: (1.sw - 30.w) / 4,
              height: 100.w,
            ).withOnTap(onTap: () {
              Get.to(() => BillPage());
            }),
          ),
        Positioned(
          top: 70.w,
          left: 15.w + (1.sw - 30.w) / 4,
          child: Container(
            width: (1.sw - 30.w) / 4,
            height: 100.w,
          ).withOnTap(onTap: () {
            Get.to(() => AccountPreviewPage());
          }),
        ),
        Positioned(
          top: 70.w,
          left: 15.w + (1.sw - 30.w) / 2,
          child: Container(
            width: (1.sw - 30.w) / 4,
            height: 100.w,
          ).withOnTap(onTap: () {
            Get.to(() => PrintPage());
          }),
        ),
        Positioned(
          top: 70.w,
          left: 15.w + (1.sw - 30.w) / 4 * 3,
          child: Container(
            width: (1.sw - 30.w) / 4,
            height: 100.w,
          ).withOnTap(onTap: () {
            Get.to(() => SzRecordsPage());
          }),
        ),
        Positioned(
            bottom: 0.w,
            left: 0.w,
            child: Container(
              width: 1.sw,
              height: 50.w,
            ).withOnTap(onTap: () {
              Get.find<HomeLogic>().state.refreshController.twoLevelComplete();
            })),
        GetBuilder<TwoLevelLogic>(
          id: 'fullImage',
          builder: (_) {
            if (!state.showFullImage) return const SizedBox.shrink();
            return GestureDetector(
              onTap: () {
                logic.hideFullImage();
              },
              child: Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black.withOpacity(0.9),
                child: Center(
                  child: Image(
                    image: state.fullImageName.png,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

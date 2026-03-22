import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

/// 交易明细 — 修改分类：右侧抽屉（设计稿：交易种类 / 双 Tab / 分组网格 / 重置·确认）。
///
/// 选中样式：浅粉底 + 红描边（见设计）。
/// 持久化由 SzDetailLocalStore 在详情页确认后写入。
class TransactionCategorySideSheet {
  TransactionCategorySideSheet._();

  static const Color _bocRed = Color(0xFFE60012);
  static const Color _selectedBorder = Color(0xFFC0192F);
  static const Color _selectedFill = Color(0xFFFFF0F3);
  static const Color _chipFill = Color(0xFFF5F5F5);

  static Future<String?> show(
    BuildContext context, {
    String? initialSelection,
    int? billDetailId,
  }) {
    return Navigator.of(context).push<String>(
      PageRouteBuilder<String>(
        opaque: false,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (ctx, animation, __) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => Navigator.of(ctx).pop(),
                  behavior: HitTestBehavior.opaque,
                  child: ColoredBox(
                    color: Colors.black.withOpacity(0.45),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(curved),
                  child: _SheetPanel(
                    initialSelection: initialSelection,
                    billDetailId: billDetailId,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CategorySectionData {
  const _CategorySectionData(this.header, this.items);
  final String header;
  final List<String> items;
}

/// 支出 Tab
const List<_CategorySectionData> _kExpenseSections = [
  _CategorySectionData('日常支出', [
    '餐饮',
    '零食烟酒',
    '交通出行',
    '私家车',
    '服饰鞋包',
    '生活用品',
    '家私家电',
    '话费宽带',
    '水电物业',
    '房租房贷',
    '医疗保健',
    '美容护肤',
    '运动健身',
    '书籍教育',
    '电子数码',
    '休闲娱乐',
  ]),
  _CategorySectionData('专项支出', [
    '旅行',
    '商务差旅',
    '育儿',
    '装修',
    '生意',
    '宠物',
    '保险',
  ]),
  _CategorySectionData('其他支出', [
    '手续费',
    '人情往来',
    '其他还款',
    '其他支出',
  ]),
];

/// 内部资金往来 Tab
const List<_CategorySectionData> _kInternalSections = [
  _CategorySectionData('日常往来', [
    '账户互转',
    '信用卡还款',
    '购汇',
    '结汇',
    '分期',
  ]),
  _CategorySectionData('投资理财', [
    '基金',
    '股票',
    '理财产品',
    '定期',
    '投资型保险',
    '债券',
    '贵金属',
    '期货',
    '外汇',
    '其他投资',
  ]),
];

class _SheetPanel extends StatefulWidget {
  const _SheetPanel({
    this.initialSelection,
    this.billDetailId,
  });

  final String? initialSelection;
  final int? billDetailId;

  @override
  State<_SheetPanel> createState() => _SheetPanelState();
}

class _SheetPanelState extends State<_SheetPanel> {
  late int _tabIndex;
  String? _selected;
  String? _draftOnOpen;

  @override
  void initState() {
    super.initState();
    final init = widget.initialSelection;
    final inExpense = _containsInTabStatic(0, init);
    final inInternal = _containsInTabStatic(1, init);
    _tabIndex = (!inExpense && inInternal) ? 1 : 0;
    _selected = init;
    _draftOnOpen = init;
  }

  static bool _containsInTabStatic(int tab, String? label) {
    if (label == null || label.isEmpty) return false;
    final sections = tab == 0 ? _kExpenseSections : _kInternalSections;
    for (final s in sections) {
      if (s.items.contains(label)) return true;
    }
    return false;
  }

  bool _containsInTab(int tab, String? label) =>
      _SheetPanelState._containsInTabStatic(tab, label);

  void _reset() {
    setState(() {
      _selected = _draftOnOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = 1.sw * 0.88;
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: w,
        height: 1.sh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            _buildHeader(context),
            _buildTabs(),
            Expanded(child: _buildScrollGrid()),
            _buildFooter(context),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.w),
      child: Row(
        children: [
          BaseText(
            text: '交易种类',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.normal,
              color: const Color(0xff222222),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: BaseText(
              text: '取消',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: TransactionCategorySideSheet._bocRed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Column(
      children: [
        Container(
          color: Color(0xFFf9f9f9),
          child: Row(
            children: [
              SizedBox(width: 50.w,),
              _tabCell(0, '支出'),
              _tabCell(1, '内部资金往来'),
              SizedBox(width: 50.w,),

            ],
          ),
        ),
      ],
    );
  }

  Widget _tabCell(int index, String label) {
    final sel = _tabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tabIndex = index;
            if (!_containsInTab(index, _selected)) {
              _selected = null;
            }
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            SizedBox(height: 10.w),
            BaseText(
              text: label,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: sel
                    ? TransactionCategorySideSheet._bocRed
                    : const Color(0xff515151),
              ),
            ),
            SizedBox(height: 8.w),
            Container(
              height: 3.w,
              width: 30.w,
              decoration: BoxDecoration(
                color: sel ? TransactionCategorySideSheet._bocRed : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollGrid() {
    final sections = _tabIndex == 0 ? _kExpenseSections : _kInternalSections;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(12.w, 8.w, 12.w, 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var si = 0; si < sections.length; si++) ...[
            if (si > 0) SizedBox(height: 20.w),
            BaseText(
              text: sections[si].header,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff222222),
              ),
            ),
            SizedBox(height: 10.w),
            _sectionGrid(sections[si].items),
          ],
        ],
      ),
    );
  }

  Widget _sectionGrid(List<String> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 10.w,
        mainAxisExtent: 38.w,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final t = items[i];
        final on = _selected == t;
        return GestureDetector(
          onTap: () => setState(() => _selected = t),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: on ? TransactionCategorySideSheet._selectedFill : TransactionCategorySideSheet._chipFill,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: on ? TransactionCategorySideSheet._selectedBorder : Colors.transparent,
                width: 1,
              ),
            ),
            child: Center(
              child: BaseText(
                text: t,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: on ? TransactionCategorySideSheet._selectedBorder : const Color(0xff222222),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 10.w, 12.w, 10.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xffEEEEEE))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: OutlinedButton(
              onPressed: _reset,
              style: OutlinedButton.styleFrom(
                foregroundColor: TransactionCategorySideSheet._bocRed,
                side: const BorderSide(color: TransactionCategorySideSheet._bocRed, width: 1),
                padding: EdgeInsets.symmetric(vertical: 12.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                backgroundColor: Colors.white,
              ),
              child: BaseText(
                text: '重置',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: TransactionCategorySideSheet._bocRed,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              onPressed: () {
                if (_selected != null && _selected!.isNotEmpty) {
                  Navigator.of(context).pop(_selected);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TransactionCategorySideSheet._bocRed,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.w),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: BaseText(
                text: '确认',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

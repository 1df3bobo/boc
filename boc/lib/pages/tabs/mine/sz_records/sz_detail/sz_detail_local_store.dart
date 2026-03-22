import 'dart:convert';

import 'package:boc/config/model/bill_item_model.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

/// 收支明细详情页的本地编辑：分类、备注、交易对象、计入收支开关。
///
/// **存储策略（多笔、可扩展）**
/// - 每条明细一条 `SpUtil` 记录，键名 `szde_v1_...`，读写 O(1)，无需每次反序列化全量。
/// - **主键**：服务端 `id != 0` 时用 `szde_v1_i_{id}`；否则用多字段 [Object.hash] 生成 `szde_v1_h_{hash}`，
///   降低无 id 时的碰撞概率（仍极端情况下可能冲突，以后端唯一 id 为准）。
/// - 值体为短 JSON：`c` 分类、`r` 备注、`o` 交易对象、`i` 计入收支（与 [SzDetailLogic.noShow] 一致）。
class SzDetailLocalStore {
  SzDetailLocalStore._();

  static const String _keyPrefix = 'szde_v1_';

  /// 与列表/接口一致：用于生成稳定存储键
  static String storageKey(BillItemListBillDetail m) {
    if (m.id != 0) {
      return '${_keyPrefix}i_${m.id}';
    }
    final h = Object.hash(
      m.transactionTime,
      m.amount,
      m.oppositeAccount,
      m.oppositeName,
      m.transactionType,
      m.accountsTime,
      m.merchantBranch,
    );
    return '${_keyPrefix}h_$h';
  }

  static Map<String, dynamic>? _readRaw(String key) {
    final raw = SpUtil.getString(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final o = jsonDecode(raw);
      if (o is Map<String, dynamic>) return o;
      if (o is Map) return Map<String, dynamic>.from(o);
    } catch (_) {}
    return null;
  }

  static void _writeRaw(String key, Map<String, dynamic> data) {
    SpUtil.putString(key, jsonEncode(data));
  }

  /// 进入详情后把本地覆盖应用到内存模型与开关
  static void applyToDetail(BillItemListBillDetail m, RxBool noShow) {
    final key = storageKey(m);
    final p = _readRaw(key);
    if (p == null) return;
    if (p['c'] is String) m.transactionCategory = p['c'] as String;
    if (p['r'] is String) m.postscriptno = p['r'] as String;
    if (p['o'] is String) m.transactionObject = p['o'] as String;
    if (p['i'] is bool) noShow.value = p['i'] as bool;
  }

  /// 合并写入（只更新传入字段，其它键保留）
  static void savePartial(
    BillItemListBillDetail m, {
    String? category,
    String? remark,
    String? object,
    bool? includeInSz,
  }) {
    final key = storageKey(m);
    final next = Map<String, dynamic>.from(_readRaw(key) ?? {});
    if (category != null) next['c'] = category;
    if (remark != null) next['r'] = remark;
    if (object != null) next['o'] = object;
    if (includeInSz != null) next['i'] = includeInSz;
    _writeRaw(key, next);
  }
}

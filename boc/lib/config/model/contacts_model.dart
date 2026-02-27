import 'dart:convert';
import 'package:boc/generated/json/base/json_field.dart';
import 'package:boc/generated/json/contacts_model.g.dart';
@JsonSerializable()
class ContactsModel {
	String name = '';
	String bankName = '';
	String bankId = '';
	String bankCard = '';
	String icon = '';

	ContactsModel();

	factory ContactsModel.fromJson(Map<String, dynamic> json) => $ContactsModelFromJson(json);

	Map<String, dynamic> toJson() => $ContactsModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
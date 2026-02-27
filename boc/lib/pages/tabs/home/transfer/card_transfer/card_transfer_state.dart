import 'package:flutter/cupertino.dart';

import 'card_req.dart';

class CardTransferState {
  TextEditingController nameTextController = TextEditingController();

  TextEditingController accountTextController = TextEditingController();
  FocusNode accountFocusNode = FocusNode();
  bool showAccountTextField = false;


  TextEditingController moneyTextController = TextEditingController();
  FocusNode moneyFocusNode = FocusNode();
  String moneyStr = '';


  TextEditingController remarksTextController = TextEditingController();


  CardReq cardReq = CardReq();

  CardTransferState() {
    ///Initialize variables
  }
}

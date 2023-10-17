import 'dart:async';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class Read_SMS{


  String FilterMoney(String mes){

    List<String> parts = mes.split(" ");
    return parts[4];
  }

  List<String> ReadMonney(List<SmsMessage> sms, List<String> listmonney)  {

    sms.forEach((element) {
      String messBody = element.body!;
      listmonney.add(FilterMoney(messBody));
    });
    return listmonney;
}


///
///

}
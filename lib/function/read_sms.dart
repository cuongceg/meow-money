import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class ReadSMS{


  String filterMoney(String mes){

    List<String> parts = mes.split(" ");
    return parts[4];
  }

  List<String> readMonney(List<SmsMessage> sms, List<String> listmonney)  {

    for (var element in sms) {
      String messBody = element.body!;
      listmonney.add(filterMoney(messBody));
    }
    return listmonney;
}


///
///

}
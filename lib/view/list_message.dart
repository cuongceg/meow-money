import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({
    Key? key,
    required this.messages,
    required this.money
  }) : super(key: key);

  final List<SmsMessage> messages;
  final List<String> money;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int i) {
        var message = messages[i];

        return ListTile(
          title: Text('${message.date}'),
          subtitle: Text(money[i]),
        );
      },
    );
  }
}
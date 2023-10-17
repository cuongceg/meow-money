import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:monney_management/view/list_message.dart';
import '../function/read_sms.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  List<SmsMessage> _messages = [];
  List<String> money = [];
  final SmsQuery _query = SmsQuery();
  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.phone,
    ].request();
  }
  Future<void> startReadSms(DateTime after) async {
    ReadSMS readSMS = ReadSMS();
    DateTime now = DateTime.now();
    bool isPermissionGranted = await Permission.sms.isGranted;
    if (isPermissionGranted) {
      List<SmsMessage> smsList = await  _query.querySms();
      _messages = smsList.where((element) => element.sender =="VTMONEY"
          && element.body!.contains("TK ViettelPay 9704")).toList();
      _messages = _messages.where((data) => data.date!.isAfter(after) && data.date!.isBefore(now)).toList();
      money = readSMS.readMonney(_messages, money);
    } else {
      // Người dùng chưa cấp quyền, cần yêu cầu quyền truy cập.
      requestPermissions();
    }
  }
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();


  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }
  // select date time picker

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    final time = await _selectTime(context);

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      startReadSms(dateTime);
    });
  }

  void removeAll(){
    for(int i = 0; i < money.length;i++){
      money.removeAt(i);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Timer Picker'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  removeAll();
                  _selectDateTime(context);

                },
                child: const Text('Select Date and Time Picker'),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 400,
              child: _messages.isNotEmpty? MessagesListView(messages: _messages, money: money) :
              const Text("Nhap text"),
            )
          ],
        ),
      ),
    );
  }
}
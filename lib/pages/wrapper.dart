import 'package:monney_management/view/chose_datetime.dart';
import 'package:monney_management/widgets/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:monney_management/models/user.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser?>(context);
    if(user!=null){
      return const TextScreen();
    }
    else {
      return const Myscreen() ;
    }
  }
}

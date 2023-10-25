import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monney_management/pages/login/login.dart';
import 'package:monney_management/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex=0;
  List<Widget> widgetOptions=[
    const Text('Trang 1'),
    const Text("Trang 2"),
    const Text("Trang 3")
  ];
  void onItemTapped(int index){
    setState(() {
      selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.white
        )
    );
    return Scaffold(
      appBar:AppBar(
        leading:IconButton(
          icon: const Icon(Icons.logout),
          onPressed:(){
            AuthService().signOut();
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const Login()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar:BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon:Icon(Icons.home_outlined),
              label:"Home"
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.qr_code_2),
              label:"QR"
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.person),
              label:"Profile"
          )
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.purple[100],
        onTap: onItemTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/services/auth_service.dart';
import 'package:quickalert/quickalert.dart';
import 'set_goals.dart';
import 'items.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Widget>items=[
    Items(title:"Food", goals:10000,color:Colors.red.shade400,),
    Items(title:"Clothes", goals:10000,color:Colors.yellow.shade400),
    const Items(title:"Cosmetic", goals:10000,color:Colors.lightGreen,),
    const Items(title:"Pet", goals:10000,color:Colors.orange,)
  ];
  @override
  Widget build(BuildContext context) {
    double heightR=MediaQuery.of(context).size.height;
    //double widthR=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:Column(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage:AssetImage("assets/images/napping.png"),
            backgroundColor:Colors.white,
            radius: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("  Do Manh Cuong",style:Font().headingBlack,),
              IconButton(
                  onPressed:(){
                  },
                  icon:Image.asset("assets/images/pencil.png",height:25,width:25,)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:20.0,bottom: 20),
            child: CarouselSlider(
                items: items,
                options: CarouselOptions(
                  height: heightR/2.5,
                  enlargeCenterPage: true,
                  viewportFraction:0.8,
                  autoPlay:true,
                  autoPlayInterval: const Duration(seconds:6)
                ),),
          ),
          ConstWigdet().thickDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading:Image.asset('assets/images/money.png',height:30,width:30,),
              title:Text("Set your goals",style:Font().headingBlack,),
              onTap:(){
                showModalBottomSheet<void>(
                    context: context,
                    builder:(BuildContext context){
                      return const Settings();
                    },
                  shape:const RoundedRectangleBorder(
                    borderRadius:BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40))
                  )
                    );
              }
            ),
          ),
          ConstWigdet().thinDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading:Image.asset('assets/images/piggy-bank.png',height:30,width: 30,),
              title:Text("Your savings",style:Font().headingBlack,),
              onTap:(){
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.custom,
                    customAsset:"assets/images/cat_saving.gif",
                    widget:CircularPercentIndicator(
                      radius: 100,
                      percent:0.8,
                      progressColor: Colors.lightGreen,
                      backgroundColor: Colors.orange.shade100,
                    )
                );
              },
            ),
          ),
          ConstWigdet().thinDivider(),
          Padding(
            padding: const EdgeInsets.only(top:70),
            child:Container(
              height: 50,
              width: 200,
              decoration:BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(40)
              ),
              child: TextButton(
                onPressed:(){
                  AuthService().signOut();
                },
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/exit.png'),
                    Text("Sign out",style:Font().headingBlack,)
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

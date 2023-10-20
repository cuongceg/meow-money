//import 'package:monney_management/pages/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:size_config/size_config.dart';
import 'package:slider_button/slider_button.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/pages/login.dart';

class Myscreen extends StatefulWidget {
  const Myscreen({super.key});

  @override
  State<Myscreen> createState() => _MyscreenState();
}

class _MyscreenState extends State<Myscreen> {
  @override
  Widget build(BuildContext context) {
    double heightR=MediaQuery.of(context).size.height;
    double widthR=MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: SizeConfigInit(
        referenceHeight: heightR,
        referenceWidth: widthR, builder: (BuildContext context, Orientation orientation) {
        return MaterialApp(
            home: Scaffold(
              body: SizedBox(
                  width: widthR,
                  height:heightR,
                  child: Stack(children:[
                    Positioned(
                      top:100,
                      left: widthR/5,
                      child: FadeInDownBig(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 1500),
                        child: SizedBox(
                          width: widthR/2,
                          height: heightR/4,
                          child: Center(
                              child:Transform.rotate(
                                angle: 345 * 3.1415927 / 180,
                                child: Image.asset('assets/images/wallet.png',width:widthR/2,height: heightR/3,),
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      top:heightR/2.5,
                      left:10,
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 800),
                        duration: const Duration(milliseconds: 1000),
                        child: SizedBox(
                          width: widthR/1.5,
                          height: heightR /5,
                          child: Center(
                            child: Text(
                                "Easy money,\neasy life",
                                style:Font().title1
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top:heightR/1.8,
                      left:15,
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 1000),
                        child: SizedBox(
                          width: widthR,
                          height: heightR /5,
                          child: Center(
                            child: Text(
                                "Make safe payment and keep your money wise with our help",
                                style:Font().bodyBlack
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom:heightR/8,
                        left: widthR/12,
                        child: FadeInLeft(
                          delay: const Duration(milliseconds: 2000),
                          duration: const Duration(milliseconds: 1000),
                          child: Center(
                            child:SliderButton(
                              action: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));},
                              label:Text("Slide to start",style: Font().bodyWhite,),
                              icon: Image.asset("assets/images/coins.png",fit: BoxFit.fill,),
                              width: widthR/1.2,
                              height: heightR/15,
                              buttonSize: 50,
                              alignLabel: Alignment.center,
                              buttonColor:Colors.deepPurpleAccent,
                              highlightedColor: Colors.purple.shade600,
                              baseColor: Colors.white,
                              backgroundColor: Colors.deepPurple,
                              )
                          ),
                        )),
                  ],)
              ),
            )
        );
      },
      ),
    );
  }
}

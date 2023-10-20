import 'package:monney_management/view/chose_datetime.dart';
import 'package:monney_management/widgets/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:size_config/size_config.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:monney_management/const_value.dart';

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
                    FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 1000),
                      child: WaveWidget(
                        config: CustomConfig(
                            gradients: [
                              [Colors.white,Colors.purple],
                              [Colors.white,Colors.purple],
                              [Colors.white,Colors.white],
                            ],
                            durations: [3500,10000,6000],
                            heightPercentages:[0.35,0.45,0.75]
                        ),
                        size: Size(widthR,heightR),
                      ),
                    ),
                    Positioned(
                      top:100,
                      left: widthR/3.15,
                      child: FadeInUpBig(
                        delay: const Duration(milliseconds: 1300),
                        duration: const Duration(milliseconds: 1500),
                        child: SizedBox(
                          width: widthR/3,
                          height: heightR/3,
                          child: Center(
                              child:Transform.rotate(
                                angle: 35 * 3.1415927 / 180,
                                child: Image.asset('assets/images/wallet.png'),
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 0,
                      child: FadeInLeftBig(
                        delay: const Duration(milliseconds: 700),
                        duration: const Duration(milliseconds:1000),
                        child: SizedBox(
                          width: widthR/2.5,
                          height: heightR /7,
                          child: Center(
                            child: Text(
                                "Socium",
                                style:Font().title
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 90,
                      left:0,
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 800),
                        duration: const Duration(milliseconds: 1000),
                        child: SizedBox(
                          width: widthR/1.2,
                          height: heightR /5,
                          child: Center(
                            child: Text(
                                "We provide the\nbest partners\nfor you",
                                style:Font().title1
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 50,
                        left: 30,
                        child: FadeInLeft(
                          delay: const Duration(milliseconds: 3000),
                          duration: const Duration(milliseconds: 1000),
                          child: Center(
                            child: Container(
                              width: widthR/1.2,
                              height: heightR/15,
                              decoration: const BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(40))
                              ),
                              child: TextButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Start now',style:Font().bodyWhite,),
                                    const Icon(Icons.arrow_forward,color: Colors.white,size: 25,)
                                  ],
                                ),
                                onPressed:(){Navigator.of(context).push(_createRoute());},
                              ),
                            ),
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
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const TextScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
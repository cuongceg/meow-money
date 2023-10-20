import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monney_management/services/auth_service.dart';
import 'package:monney_management/widgets/sign_up.dart';
import 'package:monney_management/const_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login>{
  final AuthService auth= AuthService();
  @override
  Widget build(BuildContext context){
    double heightR=MediaQuery.of(context).size.height;
    double widthR=MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.purple[200],
      ),
      child:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade200,
              Colors.purple.shade800
            ],
            stops:const [
              0.1,
              0.99
            ],// red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child:Center(
            child:ListView(
              children:<Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: SizedBox(
                    height:heightR/4,
                    width: widthR/4,
                    child: const Center(child:CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo_ai_signin.png'),
                      radius: 80,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                      width: widthR/2,
                      height: heightR/6,
                      child: Center(
                          child:TextButton(
                            child:Text('By clicking Log In, you agree with our Terms. Learn how we process your data in our Privacy Policy and Cookies Policy.',style:GoogleFonts.roboto(fontSize: 15,color: Colors.white)),
                            onPressed: (){},
                          )
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 40),
                  child: SizedBox(
                    height: heightR/13,
                    width: widthR/2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: ConstValue().borderRadius
                      ),
                      child: TextButton(
                          onPressed:() async{
                            Get.to(() => const LoginWithUsername());
                          },
                          child:ListTile(
                            title: Text(
                                "LOGIN WITH EMAIL",
                                style: Font().bodyBlack
                            ),
                            leading: const Icon(Icons.person,color: Colors.blue,),
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                  child: SizedBox(
                    height: heightR/13,
                    width: widthR/2,
                    child: Container(
                      decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius:ConstValue().borderRadius
                      ),
                      child: TextButton(
                          onPressed:() async{
                            dynamic result =await auth.signInFacebook();
                            if(result!= null){
                              Get.to(()=> const HomePage());
                            }
                            else{
                              Get.to(()=>const Loading());
                            }
                          },
                          child:ListTile(
                            title: Text(
                                "LOGIN WITH FACEBOOK",
                                style: Font().bodyBlack
                            ),
                            leading: const Icon(Icons.facebook,color: Colors.blue,),
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 40),
                  child: SizedBox(
                    height: heightR/13,
                    width: widthR/2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: ConstValue().borderRadius
                      ),
                      child: TextButton(
                          onPressed:() async{
                            dynamic result= await auth.signInGoogle();
                          },
                          child:ListTile(
                            title: Text(
                                "LOGIN WITH GOOGLE",
                                style:Font().bodyBlack
                            ),
                            leading: Image.asset('assets/images/google.png',width: 20,height: 20,),
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightR/5,
                  width: widthR,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(onPressed: (){},
                        child:Text(
                            'Don\'t have account ?',
                            style: GoogleFonts.roboto(color: Colors.white,fontSize: 22)
                        ),
                      ),
                      TextButton(
                        onPressed:() =>Get.to(()=>const SignUp()),
                        child: Text(
                            "Sign up",
                            style: GoogleFonts.roboto(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
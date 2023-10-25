import 'package:monney_management/pages/home/home_page.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:monney_management/services/auth_service.dart';
import 'package:monney_management/pages/login/sign_up.dart';
import 'package:monney_management/const_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login>{
  final AuthService authService=AuthService();
  final _formKey=GlobalKey<FormState>();
  final AuthService auth= AuthService();
  String email='',password='';
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context){
    double heightR=MediaQuery.of(context).size.height;
    double widthR=MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.purple.shade400,
        systemNavigationBarDividerColor:Colors.purple[200]
      ),
      child:Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child:Form(
              key: _formKey,
              child: ListView(
                children:<Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          child:Container(
                            width: widthR,
                            height: heightR/5,
                            color: Colors.purple.shade400,
                          )),
                      WaveWidget(
                        config: CustomConfig(
                            gradients: [
                              [Colors.purple.shade200,Colors.purple],
                              [Colors.purple.shade200,Colors.purple],
                              [Colors.white,Colors.purple.shade200],
                            ],
                            durations: [5000,10000,6000],
                            heightPercentages:[0,0.35,0.7]
                        ),
                        size: Size(widthR,heightR/5),
                      ),
                      Positioned(child: Text("Welcome back",style: Font().welcomeWhite,),),
                      Positioned(
                          top: heightR/10,
                          left:widthR/3.1,
                          child:const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/logo_signin.png'),
                            radius: 60,
                          ))
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top:30,left:135),
                      child: Text('Log in',style: Font().welcomePurple,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30,left: 20,right: 20),
                    child:TextFormField(
                      validator:(val){
                        if(val==null||val.isEmpty){
                          return "Enter a valid email";
                        }
                        else {
                          return null;
                        }
                      },
                      controller: emailController,
                      onChanged: (text){
                        email=text;
                      },
                      decoration: ConstWigdet().inputDecoration("Your email"),
                    ),
                  ),
                  Padding(
                    padding:ConstValue().edgeInsetsInput,
                    child: TextFormField(
                      validator:(val){
                        if(val==null||val.length<6){
                          return "Enter a valid password";
                        }
                        else{
                          return null;
                        }
                      },
                      onChanged:(text){
                        password=text;
                      },
                      decoration: ConstWigdet().inputDecoration("Your password"),
                    ),
                  ),
                  Padding(
                    padding:ConstValue().edgeInsets,
                    child: Container(
                      decoration: ConstWigdet().boxDecoration(),
                      child: TextButton(
                        child:Text("Log in",style:Font().headingWhite,),
                        onPressed:()async{
                          dynamic result =authService.signInemailandpassword(email, password);
                          if(result == null){
                            final snackBar = SnackBar(
                              backgroundColor:Colors.purple[100],
                              content: Text('Invalid email or wrong password!',style: Font().bodyWhite,),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          else{
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>const HomePage()));
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:ConstValue().edgeInsets,
                    child: Container(
                      decoration: ConstWigdet().boxDecoration(),
                      child: TextButton(
                        child:Text("Sign up",style:Font().headingWhite,),
                        onPressed:(){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>const SignUp()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
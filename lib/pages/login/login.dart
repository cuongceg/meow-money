import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:monney_management/services/auth_service.dart';
import 'package:monney_management/pages/sign_up.dart';
import 'package:monney_management/const_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monney_management/view/chose_datetime.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login>{
  final _formKey=GlobalKey<FormState>();
  final AuthService auth= AuthService();
  String? email,password;
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
                            heightPercentages:[0,0.4,0.8]
                        ),
                        size: Size(widthR,heightR/5),
                      ),
                      Positioned(child: Text("Welcome back",style: Font().welcomeWhite,),),
                    ],
                  ),
                  Padding(
                      padding:const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: widthR/5,
                        height: heightR/6,
                        child: const Center(child:CircleAvatar(
                          backgroundImage: AssetImage('assets/images/logo_signin.png'),
                          radius: 60,
                        )),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
                        onPressed:(){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>const TextScreen()));
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
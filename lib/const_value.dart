import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:monney_management/pages/login.dart';
import 'package:flutter/material.dart';

class Font{
  final welcomeWhite=GoogleFonts.pacifico(fontSize:40,color: Colors.white);
  final bodyWhite=GoogleFonts.roboto(fontSize:19,color:Colors.white);
  final bodyBlack=GoogleFonts.roboto(fontSize: 19,color: Colors.black);
  final bodyError=GoogleFonts.roboto(fontSize:19,color: Colors.red);
  final bodyProfile=GoogleFonts.roboto(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold);
  final headingBlack=GoogleFonts.roboto(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold);
  final headingWhite=GoogleFonts.roboto(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold);
  final headingPurple=GoogleFonts.roboto(fontSize: 25,color: Colors.purple[200],fontWeight: FontWeight.bold);
  final title=GoogleFonts.roboto(color: Colors.deepPurple,fontSize:40,fontWeight: FontWeight.bold);
  final title1=GoogleFonts.lato(color: Colors.black,fontSize: 45,fontWeight: FontWeight.bold);
}

class ConstValue{
  BorderRadius borderRadius=BorderRadius.circular(40);
  BorderSide borderSidePurple=const BorderSide(color: Colors.deepPurple,width:2.0);
  BorderSide borderSideWhite=const BorderSide(color: Colors.white,width:2.0);
  BorderSide borderSideBlack=const BorderSide(color: Colors.black,width:2.0);
  EdgeInsets edgeInsets=const EdgeInsets.symmetric(vertical: 20,horizontal:50);
  EdgeInsets edgeInsetsInput=const EdgeInsets.symmetric(vertical: 30,horizontal: 20);
}

class ConstWigdet{
  Divider thinDivider(){
    return const Divider(
      height: 10,
      thickness: 0.5,
      color: Colors.black,
    );
  }
  Divider thickDivider(){
    return const Divider(
      height: 10,
      thickness:2,
      color: Colors.black,
    );
  }
  InputDecoration? inputDecoration(String label){
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius:ConstValue().borderRadius,
            borderSide:ConstValue().borderSideBlack
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: ConstValue().borderRadius,
            borderSide:ConstValue().borderSidePurple
        ),
        fillColor: Colors.white,
        filled: true,
        labelText: label
    );
  }
  Decoration? boxDecoration(){
    return BoxDecoration(
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
      borderRadius: ConstValue().borderRadius,
    );
  }
}

class ConstAppBar{
  AppBar goBackToLogin(String title) {
    return AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded, size: 30, color: Colors.black,),
                  onPressed: () {
                    Get.to(() => const Login());
                  }
              );
            }
        ),
        title: Text(title, style:GoogleFonts.roboto(fontSize:21,color: Colors.black,fontWeight: FontWeight.bold))
    );
  }
}
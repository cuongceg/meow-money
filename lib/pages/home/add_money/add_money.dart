import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';
//import 'package:monney_management/services/database.dart';
import 'package:monney_management/models/user.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:choice/choice.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String? note;
  DateTime? date;
  double _currentValue =0;
  final noteController=TextEditingController();
  final dateEditingController=TextEditingController();
  List<String> valueChoose=[];
  void setSelectedChoice(List<String> value){
    setState(() {
      valueChoose=value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser?>(context);
    final formKey=GlobalKey<FormState>();
    final double widthR=MediaQuery.of(context).size.width;
    final double heightR=MediaQuery.of(context).size.height;
    List<String>choices=["Cosmetic",'Clothes','Food','Pet','Travel',"Vehicles"];
    List<String>imageChoose=[
      'assets/images/cosmetic.png',
      'assets/images/clothes-hanger.png',
      'assets/images/burger.png',
      'assets/images/pets.png',
      'assets/images/travel.png',
      'assets/images/car.png'
    ];
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:Form(
        key: formKey,
        child:SizedBox(
          width: widthR,
          height: heightR,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: heightR*0.15,
                child: ShaderMask(
                      // gradient layer
                      shaderCallback: (bound) {
                        return  LinearGradient(
                            end: FractionalOffset.topCenter,
                            begin: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.white70,
                              Colors.orange.shade100,
                            ],
                            stops:const [0.0, 0.8])
                            .createShader(bound);
                      },
                      blendMode: BlendMode.srcOver,
                      child:Image.asset("assets/images/cat-money4.png",height:heightR*0.85,width:widthR,fit: BoxFit.cover,),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 100),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Enter your bills",style:Font().headingBlack,
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 30),
                      child: Container(
                        width: widthR*0.9,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.black,width: 2.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              child: Text(_currentValue==0?"Enter money (.000)":_currentValue.toString(),style:Font().bodyBlack,),
                              onPressed: (){
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context){
                                      return SizedBox(
                                        width: widthR,
                                        height: heightR/2,
                                        child: cal(),
                                      );
                                    }
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:30),
                      child: TextFormField(
                        validator: (val) {
                          if(val==null||val.isEmpty){
                            return 'Enter date';
                          }
                          else
                          {return null;}
                        },
                        controller: dateEditingController,
                        onTap: () async{
                          // Below line stops keyboard from appearing
                          FocusScope.of(context).requestFocus(FocusNode());
                          // Show Date Picker Here
                          await _selectDate(context);
                          dateEditingController.text = DateFormat('dd/MM/yyyy').format(date!);
                        },
                        decoration: ConstWigdet().inputDecoration("Enter date"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/kitty_write.png",width:40,height: 40,),
                          TextButton(
                              onPressed:(){
                                QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.custom,
                                    customAsset:"assets/images/add_money.gif",
                                    confirmBtnColor: Colors.brown,
                                    widget: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:5),
                                          child:Choice<String>.inline(
                                            itemCount: choices.length,
                                            itemBuilder:(state,i){
                                              return ChoiceChip(
                                                backgroundColor:Colors.orange.shade200,
                                                selectedColor: Colors.lightGreen,
                                                selected:state.selected(choices[i]),
                                                onSelected:state.onSelected(choices[i]),
                                                label:SizedBox(
                                                  height:40,
                                                  width:150,
                                                  child:Row(
                                                    mainAxisAlignment:MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(imageChoose[i],width:50,height: 40,),
                                                      Text(choices[i],style:Font().bodyBlack,)
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            multiple: true,
                                            clearable: true,
                                            value: valueChoose,
                                            onChanged: setSelectedChoice,
                                            listBuilder: ChoiceList.createScrollable(
                                              spacing: 10,
                                              runSpacing: 10,
                                              padding:  const EdgeInsets.symmetric(
                                                horizontal:10,
                                                vertical: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:40),
                                          child: TextFormField(
                                            controller: noteController,
                                            onChanged: (text){
                                              setState(() {
                                                note=text;
                                              });
                                            },
                                            decoration: ConstWigdet().inputDecoration("Your note"),
                                          ),
                                        )
                                      ],
                                    )
                                );
                              },
                              child:Text("More details",style:Font().headingBlack)),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: widthR/2.5,
                      decoration: BoxDecoration(
                        color: Colors.brown.shade400,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextButton(
                          onPressed:(){},
                          child:Text("Save",style:Font().bodyWhite,)),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top:heightR*0.11,
                  right: 40,
                  child:Transform.rotate(
                      angle:350*3.1415927/180,
                      child: Image.asset("assets/images/lazy-cat.png",height:150,width:150,))
              ),
            ],
          ),
        )
      ),
    );
  }
  Widget cal(){
    return SimpleCalculator(
      value: _currentValue,
      hideExpression: true,
      hideSurroundingBorder: true,
      autofocus: true,
      onChanged:(key,value,expression){
        setState(() {
          _currentValue=value??0;
        });
        if (kDebugMode) {
          print('$key\t$value\t$expression');
        }
      },
      theme: CalculatorThemeData(
        borderColor: Colors.black,
        borderWidth: 2,
        displayColor: Colors.orange.shade100,
        displayStyle: const TextStyle(fontSize: 80, color: Colors.black),
        expressionColor: Colors.indigo,
        expressionStyle: const TextStyle(fontSize: 20, color: Colors.white),
        operatorColor: Colors.lightGreen,
        operatorStyle: const TextStyle(fontSize: 30, color: Colors.white),
        commandColor: Colors.brown,
        commandStyle: const TextStyle(fontSize: 30, color: Colors.white),
        numColor: Colors.grey,
        numStyle: const TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date ?? now,
        firstDate: now,
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      print('$picked');
      setState(() {
        date = picked;
      });
    }
  }
}
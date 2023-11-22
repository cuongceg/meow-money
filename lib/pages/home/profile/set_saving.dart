import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/models/money.dart';
import 'package:monney_management/models/user.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class SetSaving extends StatefulWidget {
  const SetSaving({super.key,required this.expenses,required this.incomes});

  final double expenses,incomes;
  @override
  State<SetSaving> createState() => _SetSavingState();
}

class _SetSavingState extends State<SetSaving> {
  double _currentSliderValue=20;
  bool hidden=false;
  @override
  Widget build(BuildContext context) {
    final double heightR=MediaQuery.of(context).size.height;
    final double widthR=MediaQuery.of(context).size.width;
    final user=Provider.of<MyUser>(context);
    return Container(
      height: heightR/2.5,
      width: widthR,
      decoration:BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(40),
          border: Border.all(color: Colors.black,width: 2.0),
          color: Colors.orange.shade100
      ),
      child: Column(
        children: [
          Text(hidden?"Finish ${widget.incomes>widget.expenses?"${(widget.incomes-widget.expenses).toStringAsFixed(3)}.000":"0"}/${_currentSliderValue.toStringAsFixed(3)}.000":"Set your saving money",style: Font().headingBlack,),
          Text(hidden?"":"Once you press save you can't change it until it's done",style: Font().bodyBlack,),
          hidden?CircularPercentIndicator(
            radius: 100,
            percent:(widget.incomes-widget.expenses)/_currentSliderValue>1?1:(widget.incomes-widget.expenses)/_currentSliderValue,
            progressColor: Colors.lightGreen,
            backgroundColor: Colors.brown.shade400,
          ):Slider(
              value: _currentSliderValue,
              max: 55,
              min:5,
              divisions:10,
              activeColor:Colors.red.shade200,
              inactiveColor:Colors.lightGreen,
              label: "${_currentSliderValue.round().toStringAsFixed(3)}.000",
              onChanged:(double value){
                setState(() {
                  _currentSliderValue=value;
                });
              }),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height:heightR/19,
              width: widthR/3,
              decoration:BoxDecoration(
                  color: Colors.brown,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(40)
              ),
              child: TextButton(
                  onPressed:(){
                    setState(() {
                      hidden=true;
                      // if((widget.incomes-widget.expenses)/_currentSliderValue>1){
                      //   hidden=false;
                      // }
                    });
                    print(hidden);
                  },
                  child:Text(hidden?"Ok":"Save",style:Font().bodyWhite,)
              ),
            ),
          )
        ],
      ),
    );
  }
}

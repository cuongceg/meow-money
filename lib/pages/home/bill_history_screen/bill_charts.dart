import 'package:flutter/material.dart';
import 'charts.dart';
import 'package:monney_management/const_value.dart';
import 'package:quickalert/quickalert.dart';

class BillChart extends StatefulWidget {
  const BillChart({super.key});

  @override
  State<BillChart> createState() => _BillChartState();
}

class _BillChartState extends State<BillChart> {
  @override
  Widget build(BuildContext context) {
    double widthR=MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Center(
          child: Container(
            height:5,
            width: widthR/4,
            color:Colors.grey.shade400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:20),
          child: Text("Expenses:",style:Font().headingBlack,),
        ),
        const Charts(),
        const Expenses(text:"Tuition fee"),
        const Expenses(text:"Clothes"),
        const Expenses(text:"Food"),
        ConstWigdet().thinDivider(),
        Padding(
          padding: const EdgeInsets.only(right:0,top:20),
          child: Text("Incomes:",style:Font().headingBlack,),
        ),
        const Charts(),
        const Expenses(text:"Tuition fee"),
        const Expenses(text:"Clothes"),
        const Expenses(text:"Food"),
      ],
    );
  }
}

class Expenses extends StatelessWidget{
  const Expenses({super.key,required this.text});
  final String text;
  @override
  Widget build(BuildContext context){
    return ListTile(
      leading:const Icon(Icons.wallet,size:30,),
      title:Text(text, style:Font().bodyBlack,),
      onTap:(){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.custom,
          title:"Tuition fee",
          text: 'Details',
          customAsset:"assets/images/cat_money.gif",
          widget:Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                ConstWigdet().thinDivider(),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount:",style:Font().bodyBlack,),
                    Text("-0.100",style:Font().bodyBlack,)
                  ],
                ),
                ConstWigdet().thinDivider(),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time:",style:Font().bodyBlack,),
                    Text("12",style:Font().bodyBlack,)
                  ],
                ),
                ConstWigdet().thinDivider(),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Note:",style:Font().bodyBlack,),
                    Text(text,style:Font().bodyBlack,)
                  ],
                ),
                ConstWigdet().thinDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed:(){},
                        icon:Image.asset("assets/images/pencil.png",width:35,height:35,),),
                      IconButton(
                        onPressed:(){},
                        icon:Image.asset("assets/images/vip.png",width:40,height:40,),),
                      IconButton(
                        onPressed:(){},
                        icon:Image.asset("assets/images/delete.png",width:50,height:50,),),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
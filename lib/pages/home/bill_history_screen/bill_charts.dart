import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monney_management/models/money.dart';
import 'package:monney_management/models/user.dart';
import 'charts.dart';
import 'package:monney_management/const_value.dart';
import 'package:provider/provider.dart';

class BillChart extends StatefulWidget {
  const BillChart({super.key,this.first,this.second,this.third,this.fourth, required this.sfirst, required this.ssecond, required this.sthird});
  final double? first,second,third,fourth;
  final String sfirst,ssecond,sthird;
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
        Charts(first:widget.first,second:widget.second,third:widget.third,fourth:widget.fourth,sfirst:widget.sfirst,ssecond:widget.ssecond,sthird: widget.sthird),
        Expenses(text:widget.sfirst,color: Colors.red.shade400,),
        Expenses(text:widget.ssecond,color:Colors.orange.shade400,),
        Expenses(text:widget.sthird,color: Colors.yellow.shade400,),
        ConstWigdet().thinDivider(),
        Padding(
          padding: const EdgeInsets.only(right:0,top:20),
          child: Text("Incomes:",style:Font().headingBlack,),
        ),
        Charts(first:widget.first,second:widget.second,third:widget.third,fourth:widget.fourth,sfirst:widget.sfirst,ssecond:widget.ssecond,sthird: widget.sthird),
        Expenses(text:"Tuition fee",color: Colors.red.shade400,),
        Expenses(text:"Clothes",color:Colors.yellow.shade400,),
        Expenses(text:"Food",color: Colors.orange.shade400,),
      ],
    );
  }
}

class Expenses extends StatelessWidget{
  const Expenses({super.key,required this.text,required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context){
    final double heightR=MediaQuery.of(context).size.height;
    DateFormat format=DateFormat('dd-MM-yyyy');
    final user = Provider.of<MyUser>(context);
    final billClothesList=Provider.of<List<BillsClothes>?>(context);
    final billCosmeticList=Provider.of<List<BillsCosmetic>?>(context);
    final billFood=Provider.of<List<BillsFood>?>(context);
    final billPet=Provider.of<List<BillsPet>?>(context);
    final billTravel=Provider.of<List<BillsTravel>?>(context);
    final billVehicles=Provider.of<List<BillsVehicles>?>(context);
    List product=[];
    switch(text){
      case "Clothes":
        if(billClothesList!=null){
          for(int i=0;i<billClothesList.length;i++){
            if(billClothesList[i].uid==user.uid){
              product.add(billClothesList[i]);
            }
          }
        }
        break;
      case "Cosmetic":
        if(billCosmeticList!=null){
          for(int i=0;i<billCosmeticList.length;i++){
            if(billCosmeticList[i].uid==user.uid){
              product.add(billCosmeticList[i]);
            }
          }
        }
        break;
      case "Food":
        if(billFood!=null){
          for(int i=0;i<billFood.length;i++){
            if(billFood[i].uid==user.uid){
              product.add(billFood[i]);
            }
          }
        }
        break;
      case "Pet":
        if(billPet!=null){
          for(int i=0;i<billPet.length;i++){
            if(billPet[i].uid==user.uid){
              product.add(billPet[i]);
            }
          }
        }
        break;
      case "Travel":
        if(billTravel!=null){
          for(int i=0;i<billTravel.length;i++){
            if(billTravel[i].uid==user.uid){
              product.add(billTravel[i]);
            }
          }
        }
        break;
      case "Vehicles":
        if(billVehicles!=null){
          for(int i=0;i<billVehicles.length;i++){
            if(billVehicles[i].uid==user.uid){
              product.add(billVehicles[i]);
            }
          }
        }
        break;
      default:
        if(billClothesList!=null){
          product.addAll(billClothesList);
        }
        break;
    }
    return ListTile(
      leading:Image.asset("assets/images/payment.png",height:40,width:40,),
      title:Text(text, style:Font().bodyBlack,),
      subtitle: Container(
        color: color,
        height: 5,
      ),
      onTap:(){
        showModalBottomSheet(
            context: context,
            builder:(BuildContext context){
              return Container(
                decoration:  BoxDecoration(
                  color: Colors.orange.shade100,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.only(topRight:Radius.circular(40),topLeft:Radius.circular(40)),
                ),
                height: heightR/2,
                child: Column(
                  children: [
                    Text("Bills History",style:Font().headingBlack,),
                    ConstWigdet().thickDivider(),
                    Expanded(
                      child: ListView.builder(
                          itemCount: product.length,
                          itemBuilder:(context,index){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Bill ${index+1}:${(double.parse(product[index].money)>1000)?(double.parse(product[index].money)/1000).toStringAsFixed(3):product[index].money}.000",style:Font().bodyBlack,),
                                      Text(format.format(product[index].dateTime),style:Font().bodyBlack,),
                                    ],
                                  ),
                                ),
                                ConstWigdet().thinDivider()
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
            shape:const RoundedRectangleBorder(
                borderRadius:BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40))
            )
        );
      },
    );
  }
}
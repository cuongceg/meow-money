 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monney_management/models/money.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/pages/home/bill_history_screen/bill_charts.dart';
import 'package:provider/provider.dart';

class BillHistory extends StatefulWidget {
  const BillHistory({super.key});

  @override
  State<BillHistory> createState() => _BillHistoryState();
}

class _BillHistoryState extends State<BillHistory> {
  bool innerBoxIsScroll=true;
  int? groupValue;
  DateTime? date;
  List<String>months = ['Jan', 'Feb', 'Mar', 'Apr', 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  @override
  Widget build(BuildContext context) {
    double widthR=MediaQuery.of(context).size.width;
    double heightR=MediaQuery.of(context).size.height;
    final user = Provider.of<MyUser>(context);
    final billClothesList=Provider.of<List<BillsClothes>?>(context);
    final billCosmeticList=Provider.of<List<BillsCosmetic>?>(context);
    final billFood=Provider.of<List<BillsFood>?>(context);
    final billPet=Provider.of<List<BillsPet>?>(context);
    final billTravel=Provider.of<List<BillsTravel>?>(context);
    final billVehicles=Provider.of<List<BillsVehicles>?>(context);
    List product=[];
    double expenses=0,cloExpenses=0,cosExpenses=0,foodExpenses=0,petExpenses=0,travelExpenses=0,vehExpenses=0;//sum of money in 1 month
    if(billClothesList!=null){
      for(int i=0;i<billClothesList.length;i++){
        if(billClothesList[i].uid==user.uid){
          expenses+=double.parse(billClothesList[i].money);
          cloExpenses+=double.parse(billClothesList[i].money);
          product.add(billClothesList[i]);
        }
      }
    }
    if(billCosmeticList!=null){
      for(int i=0;i<billCosmeticList.length;i++){
        if(billCosmeticList[i].uid==user.uid){
          expenses+=double.parse(billCosmeticList[i].money);
          cosExpenses+=double.parse(billCosmeticList[i].money);
          product.add(billCosmeticList[i]);
        }
      }
    }
    if(billFood!=null){
      for(int i=0;i<billFood.length;i++){
        if(billFood[i].uid==user.uid){
          expenses+=double.parse(billFood[i].money);
          foodExpenses+=double.parse(billFood[i].money);
          product.add(billFood[i]);
        }
      }
    }
    if(billPet!=null){
      for(int i=0;i<billPet.length;i++){
        if(billPet[i].uid==user.uid){
          expenses+=double.parse(billPet[i].money);
          petExpenses+=double.parse(billPet[i].money);
          product.add(billPet[i]);
        }
      }
    }
    if(billTravel!=null){
      for(int i=0;i<billTravel.length;i++){
        if(billTravel[i].uid==user.uid){
          expenses+=double.parse(billTravel[i].money);
          travelExpenses+=double.parse(billTravel[i].money);
          product.add(billTravel[i]);
        }
      }
    }
    if(billVehicles!=null){
      for(int i=0;i<billVehicles.length;i++){
        if(billVehicles[i].uid==user.uid){
          expenses+=double.parse(billVehicles[i].money);
          vehExpenses+=double.parse(billVehicles[i].money);
          product.add(billVehicles[i]);
        }
      }
    }
    cloExpenses/=expenses;
    cosExpenses/=expenses;
    foodExpenses/=expenses;
    petExpenses/=expenses;
    travelExpenses/=expenses;
    vehExpenses/=expenses;
    Map<String,double>map={
      "Clothes":cloExpenses,
      "Cosmetic":cosExpenses,
      "Food":foodExpenses,
      "Pet":petExpenses,
      "Travel":travelExpenses,
      "Vehicles":vehExpenses
    };
    var mapEntries = map.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    map..clear()..addEntries(mapEntries);
    List options=map.keys.toList();
    List percent=map.values.toList();
    expenses/=1000;
    return AnnotatedRegion(
      value:SystemUiOverlayStyle(
        statusBarColor:Colors.orange.shade100,
      ),
      child: Scaffold(
        backgroundColor:Colors.orange.shade100,
        body:NestedScrollView(
          headerSliverBuilder:(context,innerBoxIsScroll){
            return <Widget>[
              SliverAppBar(
                leading:Image.asset('assets/images/kitty_computer.png',width:20,height:20,),
                title:Text("Bills",style:Font().headingBlack,),
                centerTitle: true,
                backgroundColor:Colors.orange.shade100,
                actions: [
                  MenuAnchor(
                    builder: (BuildContext context,MenuController controller,Widget? child){
                      return IconButton(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon:Image.asset("assets/images/sleepover-party.png",height:40,width:40,),);
                    },
                      menuChildren: [
                        MenuItemButton(
                          child: Text("Select day",style:Font().bodyBlack,),
                          onPressed:()async{
                            await _selectDate(context);
                          },),
                        MenuItemButton(
                          child:Text("Select month",style:Font().bodyBlack,),
                          onPressed: (){
                            showModalBottomSheet(
                                context: context,
                                builder:(BuildContext context){
                                  return SizedBox(
                                    height: heightR/2,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemBuilder:(BuildContext context,int index){
                                              return RadioListTile<int>(
                                                  value: index,
                                                  groupValue: groupValue,
                                                  title: Text(months[index],style:Font().bodyBlack,),
                                                  toggleable: true,
                                                  onChanged: (int? value){
                                                    setState(() {
                                                      groupValue=value;
                                                    });
                                                  });
                                            },
                                            itemCount: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );
                          },
                        )
                      ])
                ],
                floating:false,
                flexibleSpace:FlexibleSpaceBar(
                  background:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: widthR,
                        height: heightR/16,
                        color: Colors.orange.shade100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:20,top:15),
                            child: Text("Expenses",style: Font().headingBlack,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:80,top:15),
                            child: Text("Incomes",style: Font().headingBlack,),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:100,top:15,bottom:20),
                            child: Text('-${expenses.toStringAsFixed(3)}.000',style: Font().bodyBlack,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:15,top:15,bottom:20),
                            child: Text("+690.000",style: Font().bodyBlack,),
                          ),
                          Expanded(child: Image.asset("assets/images/kitty.png"),)
                        ],
                      ),
                    ],
                  ),
                ),
                expandedHeight:heightR/4.6,
              )
            ];
          },
          body:Container(
            decoration:BoxDecoration(
                color: Colors.orange.shade50,
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  )
                ],
                borderRadius:const BorderRadius.only(
                    topLeft:Radius.circular(40),
                    topRight:Radius.circular(40)
                )
            ),
            child:BillChart(first:percent[5]*100,second:percent[4]*100,third:percent[3]*100,fourth:(1-percent[5]-percent[4]-percent[3])*100
            ,sfirst:options[5],ssecond: options[4],sthird: options[3]),
          ),
        ),
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

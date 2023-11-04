import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/pages/home/bill_history_screen/bill_charts.dart';
import 'package:quickalert/quickalert.dart';


class BillHistory extends StatefulWidget {
  const BillHistory({super.key});

  @override
  State<BillHistory> createState() => _BillHistoryState();
}

class _BillHistoryState extends State<BillHistory> {
  bool innerBoxIsScroll=true;
  @override
  Widget build(BuildContext context) {
    double widthR=MediaQuery.of(context).size.width;
    double heightR=MediaQuery.of(context).size.height;
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
                  IconButton(
                      onPressed:(){
                        QuickAlert.show(
                            context: context,
                            type:QuickAlertType.info,
                          title:"Select day"
                        );
                      },
                      icon:Image.asset("assets/images/sleepover-party.png",height:40,width:40,),)
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
                            padding: const EdgeInsets.only(left:10,right:100,top:15),
                            child: Text("Incomes",style: Font().headingBlack,),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:100,top:15,bottom:20),
                            child: Text("-1.690.000",style: Font().bodyBlack,),
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
            child:const BillChart(),
          ),
        ),
      ),
    );
  }
}

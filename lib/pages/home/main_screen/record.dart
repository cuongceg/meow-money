import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:monney_management/models/user.dart';
import 'curved_list_item.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  bool innerBoxIsScroll=true;
  List<Color>colorListItems=[
    Colors.green.shade100,
    Colors.lightBlue.shade100,
    Colors.teal.shade200,
    Colors.purple.shade200,
    Colors.red.shade300,
    Colors.yellow.shade100,
    Colors.orange.shade100,
  ];
  @override
  Widget build(BuildContext context) {
    final authInfo = Provider.of<List<UserInfo>?>(context);
    double heightR= MediaQuery.of(context).size.height;
    double widthR= MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.orange.shade100,
      ),
      child: Scaffold(
        backgroundColor: Colors.orange.shade100,
        body: NestedScrollView(
          headerSliverBuilder:(context,innerBoxIsScroll){
            return <Widget>[
              SliverAppBar(
                leading:const CircleAvatar(backgroundImage:AssetImage("assets/images/napping.png"),backgroundColor:Colors.white,radius:30,),
                title:Text(authInfo!=null?"Hello ${authInfo[1].username}":"Welcome back",style:Font().bodyBlack,),
                actions: [
                  IconButton(
                    onPressed:(){
                      AuthService().signOut();
                    },
                    icon:const Icon(Icons.logout),color:Colors.black,),
                ],
                backgroundColor:Colors.orange.shade100,
                floating: false,
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:20,top:15),
                            child: Text("Nov-Expenses",style: Font().headingBlack,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:20,top:15),
                            child: Text("Nov-Incomes",style: Font().headingBlack,),
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
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight:heightR/4.6,
              ),
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
            child: Column(
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
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/kitty_write.png",width:40,height:40,),
                      Text("The latest 7 bills",style:Font().headingBlack,),
                      Image.asset("assets/images/kitty_computer.png",width:40,height:40,),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount:7,
                      itemBuilder:(context,index){
                        return CurvedListItem(
                          title:"Bill ${index+1}:-${(index+0.1).toStringAsFixed(3)}",
                          time:"${index+2}/11/2023",
                          subTitile:"Tuiton month ${index+1}",
                          color:colorListItems[index],
                          nextColor:index==6?Colors.orange.shade100:colorListItems[index+1],
                        );
                        }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


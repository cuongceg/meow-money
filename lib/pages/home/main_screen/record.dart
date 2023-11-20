import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/pages/home/add_money/add_money.dart';
import 'package:monney_management/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/models/money.dart';
import 'curved_list_item.dart';
import 'package:google_fonts/google_fonts.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  TextStyle fontBold=GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold);
  TextStyle fontBigBold=GoogleFonts.roboto(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold);
  DateFormat formatMonth=DateFormat.MMMM('en_US');
  DateFormat format=DateFormat('dd/MM/yyyy');
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
    final authInfo = Provider.of<List<UserInformation>?>(context);
    final user = Provider.of<MyUser>(context);
    final billClothesList=Provider.of<List<BillsClothes>?>(context);
    final billCosmeticList=Provider.of<List<BillsCosmetic>?>(context);
    final billFood=Provider.of<List<BillsFood>?>(context);
    final billPet=Provider.of<List<BillsPet>?>(context);
    final billTravel=Provider.of<List<BillsTravel>?>(context);
    final billVehicles=Provider.of<List<BillsVehicles>?>(context);
    //avatar data
    String username='';
    int index=0;
    if(authInfo!=null){
      for(int i=0;i<authInfo.length;i++){
        if(authInfo[i].uid==user.uid){
          // get true data user
          index=i;
          break;
        }
      }
      username=authInfo[index].username??"";//check null
    }
    //bill data
    List product=[];
    int cnt=0,sum=0;//sum is product.length, cnt= sum>7?7:cnt
    double expenses=0;//sum of money in 1 month
    if(billClothesList!=null){
      for(int i=0;i<billClothesList.length;i++){
        if(billClothesList[i].uid==user.uid){
          expenses+=double.parse(billClothesList[i].money);
          product.add(billClothesList[i]);
        }
      }
    }
    if(billCosmeticList!=null){
      for(int i=0;i<billCosmeticList.length;i++){
        if(billCosmeticList[i].uid==user.uid){
          expenses+=double.parse(billCosmeticList[i].money);
          product.add(billCosmeticList[i]);
        }
      }
    }
    if(billFood!=null){
      for(int i=0;i<billFood.length;i++){
        if(billFood[i].uid==user.uid){
          expenses+=double.parse(billFood[i].money);
          product.add(billFood[i]);
        }
      }
    }
    if(billPet!=null){
      for(int i=0;i<billPet.length;i++){
        if(billPet[i].uid==user.uid){
          expenses+=double.parse(billPet[i].money);
          product.add(billPet[i]);
        }
      }
    }
    if(billTravel!=null){
      for(int i=0;i<billTravel.length;i++){
        if(billTravel[i].uid==user.uid){
          expenses+=double.parse(billTravel[i].money);
          product.add(billTravel[i]);
        }
      }
    }
    if(billVehicles!=null){
      for(int i=0;i<billVehicles.length;i++){
        if(billVehicles[i].uid==user.uid){
          expenses+=double.parse(billVehicles[i].money);
          product.add(billVehicles[i]);
        }
      }
    }
    expenses/=1000;//display dot
    product.sort((a,b)=> a.nowDateTime.compareTo(b.nowDateTime));
    sum=product.length;
    cnt=sum>=7?7:sum;
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
                title:Text("Hello $username",style:fontBigBold,),
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
                        height: heightR/15,
                        color: Colors.orange.shade100,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:20,top:15),
                            child: Text("${formatMonth.format(DateTime.now())}-Expenses",style:fontBold,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:20,top:15),
                            child: Text("${formatMonth.format(DateTime.now())}-Incomes",style:fontBold,),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:90,top:0),
                            child: Text("-${expenses.toStringAsFixed(3)}.000",style: Font().bodyBlack,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:25,right:15,top:0),
                            child: Text("+690.000",style: Font().bodyBlack,),
                          ),
                          Expanded(child: Image.asset("assets/images/kitty.png",width:80,height:80,),)
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
                      Text("The latest $cnt bills",style:Font().headingBlack,),
                      Image.asset("assets/images/kitty_computer.png",width:40,height:40,),
                    ],
                  ),
                ),
                Expanded(
                  child:product.isNotEmpty?ListView.builder(
                      itemCount:cnt,
                      itemBuilder:(context,index){
                        return CurvedListItem(
                          title: "Bill ${index+1}:-${(double.parse(product[sum-1-index].money)>1000)?(double.parse(product[sum-1-index].money)/1000).toStringAsFixed(3):product[sum-1-index].money}.000",
                          time: format.format(product[sum-1-index].dateTime),
                          option: product[sum-1-index].option,
                          note: product[sum-1-index].note,
                          money: (double.parse(product[sum-1-index].money)>1000)?(double.parse(product[sum-1-index].money)/1000).toStringAsFixed(3):product[sum-1-index].money,
                          color:colorListItems[index],
                          nextColor:index==cnt-1?Colors.orange.shade100:colorListItems[index+1],
                          idTouch: product[sum-1-index].idTouch,
                        );
                        }):
                  SizedBox(
                    child: Padding(
                      padding:const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Text('Go to add your first bill',style:Font().headingBlack,),
                          IconButton(
                              onPressed:(){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>const Add()));
                              },
                              icon: Image.asset("assets/images/paw-print.png",height:50,width:50,))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monney_management/const_value.dart';
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
    String username='';
    int index=0;
    if(authInfo!=null){
      for(int i=0;i<authInfo.length;i++){
        if(authInfo[i].uid==user.uid){
          index=i;
          break;
        }
      }
      username=authInfo[index].username??"";
    }
    int cnt=0;
    int sum=0;
    double expenses=0;
    List product=[];
    if(billClothesList!=null){
      cnt=billClothesList.length>=7?7:billClothesList.length;
      for(int i=0;i<cnt;i++){
        expenses+=double.parse(billClothesList[i].money);
        product.add(billClothesList[i]);
      }
    }
    if(billCosmeticList!=null){
      cnt=(billCosmeticList.length+cnt)>=7?7:(billCosmeticList.length+cnt);
      for(int i=0;i<billCosmeticList.length;i++){
        expenses+=double.parse(billCosmeticList[i].money);
        // money.add((double.parse(billCosmeticList[i].money)>1000)?(double.parse(billCosmeticList[i].money)/1000).toStringAsFixed(3):billCosmeticList[i].money);
        // time.add(format.format(billCosmeticList[i].dateTime));
        product.add(billCosmeticList[i]);
      }
      expenses/=1000;
    }
    product.sort((a,b)=> a.nowDateTime.compareTo(b.nowDateTime));
    sum=product.length;
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
                      for(var bill in product){
                        print(bill.nowDateTime);
                      }
                      // AuthService().signOut();
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
                  child: ListView.builder(
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


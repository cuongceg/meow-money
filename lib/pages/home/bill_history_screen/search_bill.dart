import 'package:flutter/material.dart';
import 'package:monney_management/services/database.dart';
import 'package:monney_management/pages/home/main_screen/update_bill.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/models/money.dart';
import 'package:monney_management/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class SearchBill extends StatefulWidget {
  const SearchBill({super.key});

  @override
  State<SearchBill> createState() => _SearchBillState();
}

class _SearchBillState extends State<SearchBill> {
  DateTime? date;
  List search=[];
  DateFormat format=DateFormat('dd/MM/yyyy');
  final dateEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double heightR=MediaQuery.of(context).size.height;
    final double widthR=MediaQuery.of(context).size.width;
    final user = Provider.of<MyUser>(context);
    final billList=Provider.of<List<Bills>?>(context);
    List product=[];
    if(billList!=null){
      for(int i=0;i<billList.length;i++){
        if(billList[i].uid==user.uid){
          product.add(billList[i]);
        }
      }
    }
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:SizedBox(
        height: heightR,
        width: widthR,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            ShaderMask(
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
              child:Image.asset("assets/images/cat-money4.png",height:heightR,width:widthR,fit: BoxFit.cover,),
            ),
            Padding(
              padding:const EdgeInsets.only(left:0,top:40),
              child:Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded, size: 30, color: Colors.black,),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text("Search Bills",style:Font().headingBlack,),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30),
                    child: TextField(
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
                      padding:const EdgeInsets.only(top:30,left:0),
                      child:Container(
                        height: 50,
                        width: widthR/2.5,
                        decoration: BoxDecoration(
                          color: Colors.brown.shade400,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextButton(
                            onPressed:(){
                              setState(() {
                                search=[];
                                for(var pro in product){
                                  if(format.format(pro.dateTime)==format.format(date??DateTime.now())){
                                    search.add(pro);
                                  }
                                }
                              });
                            },
                            child:Text("Search",style:Font().bodyWhite,)),
                      ),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(top:30,left:0),
                    child:Text(date==null?"":format.format(date!),style:Font().headingBlack,)
                  ),
                  Expanded(
                    child:search.isNotEmpty?
                        ListView.builder(
                          itemCount: search.length,
                          itemBuilder:(BuildContext context,index){
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 80,
                                width: widthR,
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(40),
                                  border:Border.all(color:Colors.black,width:2.0),
                                ),
                                child: ListTile(
                                  title:Text("Money: -${(double.parse(search[index].money)>1000)?(double.parse(search[index].money)/1000).toStringAsFixed(3):search[index].money}.000 ",style: Font().bodyBlack,),
                                  subtitle: Text("Date: ${format.format(search[index].dateTime)}",style:Font().bodyBlack,),
                                    onTap:(){
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.custom,
                                        title: "Bill ${index+1}: -${(double.parse(search[index].money)>1000)?(double.parse(search[index].money)/1000).toStringAsFixed(3):search[index].money}.000 ",
                                        text: search[index].option??'Details',
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
                                                  Text("-${(double.parse(search[index].money)>1000)?(double.parse(search[index].money)/1000).toStringAsFixed(3):search[index].money}.000",style:Font().bodyBlack,)
                                                ],
                                              ),
                                              ConstWigdet().thinDivider(),
                                              Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Time:",style:Font().bodyBlack,),
                                                  Text(format.format(search[index].dateTime),style:Font().bodyBlack,)
                                                ],
                                              ),
                                              ConstWigdet().thinDivider(),
                                              Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Note:",style:Font().bodyBlack,),
                                                  Text(search[index].note??"",style:Font().bodyBlack,)
                                                ],
                                              ),
                                              ConstWigdet().thinDivider(),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    IconButton(
                                                      onPressed:(){
                                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateBill(idTouch: search[index].idTouch??"US6sYmwwE57DxJuG2ZOA",money:search[index].money,dateTime:format.format(search[index].dateTime),note:search[index].note,)));
                                                      },
                                                      icon:Image.asset("assets/images/pencil.png",width:35,height:35,),),
                                                    IconButton(
                                                      onPressed:(){},
                                                      icon:Image.asset("assets/images/vip.png",width:40,height:40,),),
                                                    IconButton(
                                                      onPressed:(){
                                                        Database().deleteDocument(search[index].idTouch??"US6sYmwwE57DxJuG2ZOA");
                                                        Navigator.pop(context);
                                                      },
                                                      icon:Image.asset("assets/images/delete.png",width:50,height:50,),),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            );
                          },
                        ):Center(child: Text("No bill in day",style:Font().bodyBlack,)
                    ),
                  )
                ],
              ),
            ),
          ],
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

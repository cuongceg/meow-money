import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/models/money.dart';

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({super.key,
    this.title,
    this.note,
    this.money,
    this.option,
    this.time,
    this.color,
    this.nextColor,
  });
  final String? title,note,time,money,option;
  final Color? color,nextColor;

  @override
  Widget build(BuildContext context) {
    final cosmetic=Provider.of<List<BillsCosmetic>?>(context);
    final clothes=Provider.of<List<BillsClothes>?>(context);
    return Container(
      color: nextColor,
      child: Container(
        height:120,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
          ),
        ),
        padding: const EdgeInsets.only(
          top: 30,
          left: 32,
        ),
        child:ListTile(
          leading:Image.asset("assets/images/payment.png",height:40,width: 40,),
          title:Text(time??"12", style:Font().bodyBlack,),
          subtitle: Text(title??"This is your record", style:Font().headingBlack,),
          onTap:(){
            print(clothes);
            print(cosmetic);
            QuickAlert.show(
              context: context,
              type: QuickAlertType.custom,
              title: title,
              text: option??'Details',
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
                        Text("$money.000",style:Font().bodyBlack,)
                      ],
                    ),
                    ConstWigdet().thinDivider(),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Time:",style:Font().bodyBlack,),
                        Text(time??"${DateTime.now()}",style:Font().bodyBlack,)
                      ],
                    ),
                    ConstWigdet().thinDivider(),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Note:",style:Font().bodyBlack,),
                        Text(note??"",style:Font().bodyBlack,)
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
        ),
      ),
    );
  }
}
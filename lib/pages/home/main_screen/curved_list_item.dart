import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({super.key,
    this.title,
    this.subTitile,
    this.time,
    this.icon,
    this.color,
    this.nextColor,
  });
  final String? title;
  final String? time;
  final String? subTitile;
  final IconData? icon;
  final Color? color;
  final Color? nextColor;

  @override
  Widget build(BuildContext context) {
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
          leading:Icon(icon??Icons.wallet,size:30,),
          title:Text(time??"12", style:Font().bodyBlack,),
          subtitle: Text(title??"This is your record", style:Font().headingBlack,),
          onTap:(){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.custom,
              title: title,
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
                        Text(time??"${DateTime.now()}",style:Font().bodyBlack,)
                      ],
                    ),
                    ConstWigdet().thinDivider(),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Note:",style:Font().bodyBlack,),
                        Text(subTitile??"Tuition",style:Font().bodyBlack,)
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
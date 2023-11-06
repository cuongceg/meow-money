import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {

  int touchedIndex=-1;
  TextStyle chartFont(double fontSize,List<Shadow>shadows){
    return GoogleFonts.roboto(
        fontSize:fontSize,
        fontWeight:FontWeight.bold,
        color: Colors.white,
        shadows:shadows
    );
  }
  List<PieChartSectionData>showingSections(){
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: Colors.red.shade400,
              value: 40,
              title: '40%',
              radius: radius,
              titleStyle:chartFont(fontSize, shadows)
          );
        case 1:
          return PieChartSectionData(
              color: Colors.yellow.shade400,
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle:chartFont(fontSize, shadows)
          );
        case 2:
          return PieChartSectionData(
              color: Colors.lightGreen,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle:chartFont(fontSize, shadows)
          );
        case 3:
          return PieChartSectionData(
              color: Colors.orange.shade400,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle:chartFont(fontSize, shadows)
          );
        default:
          throw Error();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final double widthR=MediaQuery.of(context).size.width;
    final double heightR=MediaQuery.of(context).size.height;
    return AspectRatio(
      aspectRatio: 1.25,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child:AspectRatio(
                    aspectRatio:1,
                    child:PieChart(
                        PieChartData(
                          pieTouchData:PieTouchData(
                              touchCallback:(FlTouchEvent event, pieTouchResponse){
                                setState(() {
                                  if(!event.isInterestedForInteractions||pieTouchResponse==null||pieTouchResponse.touchedSection==null){
                                    touchedIndex=-1;
                                    return;
                                  }
                                  touchedIndex=pieTouchResponse.touchedSection!.touchedSectionIndex;
                                });
                              }
                          ),
                          borderData:FlBorderData(show: false),
                          sectionsSpace:0,
                          centerSpaceRadius:55,
                          sections:showingSections(),
                        )
                    ),
                  )),
              SizedBox(
                width:widthR/2.2,
                height:heightR/3,
                child: Padding(
                  padding: const EdgeInsets.only(top:15),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child:Indicator(
                          color:Colors.red.shade400,
                          text:"Tuition fee",
                          subText: "-100.000",
                        ),
                      ),
                      Expanded(
                        child:Indicator(
                          color:Colors.yellow.shade400,
                          text:"Clothes",
                          subText: "-5.000",
                        ),
                      ),
                      const Expanded(
                        child:Indicator(
                          color:Colors.orange,
                          text:"Food",
                          subText: "-1.000",
                        ),
                      ),
                      const Expanded(
                        child:Indicator(
                          color:Colors.lightGreen,
                          text:"Others",
                          subText: "-1.000",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class Indicator extends StatelessWidget{
  const Indicator({super.key,required this.text,required this.subText,required this.color});
  final String text;
  final Color color;
  final String subText;

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading:Container(
        width:25,
        height:25,
        color:color,
      ),
      title:Text(text,style:Font().bodyBlack,),
      subtitle:Text(subText),
    );
  }
}
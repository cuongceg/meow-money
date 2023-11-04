import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class BillChart extends StatefulWidget {
  const BillChart({super.key});

  @override
  State<BillChart> createState() => _BillChartState();
}

class _BillChartState extends State<BillChart> {
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
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle:chartFont(fontSize, shadows)
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle:chartFont(fontSize, shadows)
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle:chartFont(fontSize, shadows)
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
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
    double widthR=MediaQuery.of(context).size.width;
    double heightR=MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            height:5,
            width: widthR/4,
            color:Colors.grey.shade400,
          ),
        ),
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
                      centerSpaceRadius:60,
                      sections:showingSections(),
                    )
                  ),
                )),
          ],
        ),
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
                    centerSpaceRadius:60,
                    sections:showingSections(),
                  )
              ),
            ))
      ],
    );
  }
}

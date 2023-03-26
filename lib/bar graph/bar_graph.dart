import 'package:daily_expense/bar%20graph/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });
  @override
  Widget build(BuildContext context) {
    //initialize Bar data
    BarData myBarData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thuAmount: thuAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
          maxY: maxY,
          minY: 0,
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
            getTitlesWidget: getBottomTiles,))
          ),
          gridData: FlGridData(show: false),
          barGroups: myBarData.barData
              .map(
                (data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                        toY: data.y,
                        color: Colors.black45,
                        width: 22,
                        borderRadius: BorderRadius.circular(4),
                        backDrawRodData: BackgroundBarChartRodData(
                            show: true, toY: maxY, color: Colors.white70)),
                  ],
                ),
              )
              .toList()),
    );
  }
}
Widget getBottomTiles (double value,TitleMeta meta){
  const style = TextStyle(color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontSize: 14);
  Widget text;
  switch(value.toInt()){
    case 0:
      text = Text('SUN',style: style,);
      break;
    case 1:
      text = Text('MON',style: style,);
      break;
    case 2:
      text = Text('TUE',style: style,);
      break;
      case 3:
    text = Text('WED',style: style,);
    break;
    case 4:
    text = Text('THU',style: style,);
    break;
  case 5:
    text = Text('FRI',style: style,);
  break;
  case 6:
    text = Text('SAT',style: style,);
  break;
    default:
      text = Text('TH',style: style,);
      break;}
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

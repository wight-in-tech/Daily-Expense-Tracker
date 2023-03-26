import 'package:daily_expense/bar%20graph/bar_graph.dart';
import 'package:daily_expense/data/expense_data.dart';
import 'package:daily_expense/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  //calculate max amount in bar graph
  double calculateMax(
      Expensedata value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    double? max = 100;
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];
//sort in ascending order
    values.sort();
    //get largest amount,which will be at last
    //increase size of graph , graph will be 1.2 times longer than max value
    max = values.last * 1.2;
    return max == 0 ? 100 : max;
  }
  //calculate the week total
  String calculateWeekTotal(
      Expensedata value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      )
  {List<double> values = [
    value.calculateDailyExpenseSummary()[sunday] ?? 0,
    value.calculateDailyExpenseSummary()[monday] ?? 0,
    value.calculateDailyExpenseSummary()[tuesday] ?? 0,
    value.calculateDailyExpenseSummary()[wednesday] ?? 0,
    value.calculateDailyExpenseSummary()[thursday] ?? 0,
    value.calculateDailyExpenseSummary()[friday] ?? 0,
    value.calculateDailyExpenseSummary()[saturday] ?? 0,
  ];
  double total =0;
  for(int i=0;i<values.length;i++){
    total+=values[i];
  }
  return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    //get ddmmyyyy for each day of this week
    String sunday = convertDateTimeToString(startOfWeek.add(Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 6)));
    return Consumer<Expensedata>(
        builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                     const Text(
                        "WeekTotal: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday))
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: MyBarGraph(
                    maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
                    sunAmount:
                        value.calculateDailyExpenseSummary()[sunday] ?? 0,
                    monAmount:
                        value.calculateDailyExpenseSummary()[monday] ?? 0,
                    tueAmount:
                        value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                    wedAmount:
                        value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                    thuAmount:
                        value.calculateDailyExpenseSummary()[thursday] ?? 0,
                    friAmount:
                        value.calculateDailyExpenseSummary()[friday] ?? 0,
                    satAmount:
                        value.calculateDailyExpenseSummary()[saturday] ?? 0,
                  ),
                ),
              ],
            ));
  }
}

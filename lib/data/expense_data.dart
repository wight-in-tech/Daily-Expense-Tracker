import 'package:daily_expense/data/hive_database.dart';
import 'package:daily_expense/datetime/date_time_helper.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import '../models/expense_item.dart';

class Expensedata extends ChangeNotifier{
  //list of all expenses
 List<ExpenseItem> overallExpenseList =[];
  //get expense list
List<ExpenseItem> getAllExpenseList(){
  return overallExpenseList;
}
//prepare data to display
  final db = HiveDataBase();
  void prepareData(){
  //if there is already existing data , get that data
  if(db.readData().isNotEmpty){
    overallExpenseList = db.readData();
  }
}


   //add new expense
void addNewExpense(ExpenseItem newExpense){
  overallExpenseList.add(newExpense);
  notifyListeners();
  db.saveData(overallExpenseList);
}
  //delete expense
 void deleteExpense(ExpenseItem newExpense){
   overallExpenseList.remove(newExpense);
   notifyListeners();
   db.saveData(overallExpenseList);
 }
  //get weekday
String getDayName(DateTime dateTime){
  switch(dateTime.weekday){
    case 1:
      return "Mon";
    case 2:
      return "Tue";
    case 3:
      return "Wed";
    case 4:
      return "Thu";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    case 7:
      return "Sun";
    default :
      return '';
  }
}
  //get the date for start of week
DateTime startOfWeekDate(){
DateTime? startOfWeek;

  //get todays date
  DateTime today= DateTime.now();

  // go backwards from today to find sunday
  for (int i=0;i<7;i++){
    if(getDayName(today.subtract(Duration(days: i)))=="Sun"){
      startOfWeek=today.subtract(Duration(days: i));
    }
  }
  return startOfWeek!;
}
  /*
  *
  * conveet overall list of expense into daily expense summary

  * DailyExpenseSummary
  * */
Map<String,double> calculateDailyExpenseSummary(){
  Map<String,double> dailyExpenseSummary ={
    //date(ddmmyyyy) : amountTodayofday
  };
  
  for(var expense in overallExpenseList){
    String date = convertDateTimeToString(expense.dateTime);
    double amount = double.parse(expense.amount);
    if(dailyExpenseSummary.containsKey(date)){
      double currentAmount = dailyExpenseSummary[date]!;
      currentAmount=currentAmount+amount;
      dailyExpenseSummary[date] =currentAmount;
    }
    else {
      dailyExpenseSummary.addAll({date:amount});
    }
  }
  return dailyExpenseSummary;
}

}
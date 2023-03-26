import 'package:hive_flutter/hive_flutter.dart';
import 'package:daily_expense/models/expense_item.dart';

class HiveDataBase {
  //reference our box
  final _myBox = Hive.box("expense_database");
  //write data
  void saveData(List<ExpenseItem> allExpense) {
    /*
  Hive can only store primitive data types , so for storing our objects like here Expense , we need to convert that
  * */
    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpense) {
      //converting into list of storable type
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
//storing it in our database
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  //read data
  List<ExpenseItem> readData() {
    /**
   Data is stored in hive as a list of string + dateTime
   */

    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      //collecting individual expense dat
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

//create expense item
      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      //add expense to overall expense list of expenses
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}

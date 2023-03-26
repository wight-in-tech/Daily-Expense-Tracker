import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:daily_expense/components/expense_tile.dart';
import 'package:daily_expense/data/expense_data.dart';
import 'package:daily_expense/models/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_expense/components/expense_summary.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //prepare data on startup
    Provider.of<Expensedata>(context, listen: false).prepareData();
  }

  //add new expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add new expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //expense name
                  TextField(
                    controller: newExpenseNameController,
                    decoration: InputDecoration(
                      hintText: "Enter expense name",
                    ),
                  ),

                  //expense amount
                  TextField(
                    controller: newExpenseAmountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter expense amount",
                    ),
                  ),
                ],
              ),
              actions: [
                //save button
                MaterialButton(
                  onPressed: save,
                  child: const Text("save"),
                ),

                //cancel button
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("cancel"),
                )
              ],
            ));
  }

//deleting an expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<Expensedata>(context, listen: false).deleteExpense(expense);
  }

  //save
  void save() {
    // only save if all fields are saved
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty)
    //create expense item
    {
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: newExpenseAmountController.text,
          dateTime: DateTime.now());
      Provider.of<Expensedata>(context, listen: false)
          .addNewExpense(newExpense);
      Navigator.pop(context);
      clear();
    }
  }

  //cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  //clear controllers
  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Expensedata>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(
            "Home",
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: GNav(
            backgroundColor: Colors.grey,
            rippleColor: Colors.white, // tab button ripple color when pressed
            hoverColor: Colors.grey, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            tabActiveBorder:
                Border.all(color: Colors.grey, width: 1), // tab button border
            tabBorder: Border.all(
                color: Colors.white10, width: 1), // tab button border
            tabShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
            ], // tab button shadow
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds:400), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: Colors.white, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor: Colors.blueGrey
                .withOpacity(0.1), // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            tabs: [
              GButton(
                  icon: CupertinoIcons.home,
                  gap: 8,
                  backgroundColor: Colors.grey,
                  // Within the `FirstScreen` widget
                  onPressed: () {
                    // Navigate to the second screen using a named route.
                    Navigator.pushNamed(context, '/');
                  }),
              GButton(
                  icon: Icons.group,
                  gap: 8,
                  backgroundColor: Colors.grey,
                  // Within the `FirstScreen` widget
                  onPressed: () {
                    // Navigate to the second screen using a named route.
                    Navigator.pushNamed(context, 'borrowed/');
                  }),
              GButton(
                  icon: Icons.payment_rounded,
                  gap: 8,
                  backgroundColor: Colors.grey,
                  // Within the `FirstScreen` widget
                  onPressed: () {
                    // Navigate to the second screen using a named route.
                    Navigator.pushNamed(context, 'lended/');
                  }),
            ]),
        body: ListView(
          children: [
            //weekly summary,
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),
            SizedBox(
              height: 20,
            ),
            //expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0) =>
                    deleteExpense(value.getAllExpenseList()[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

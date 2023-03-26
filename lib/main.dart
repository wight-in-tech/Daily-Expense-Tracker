import 'package:daily_expense/data/expense_data.dart';
import 'package:daily_expense/pages/borrowed.dart';
import 'package:daily_expense/pages/homepage.dart';
import 'package:daily_expense/pages/lended.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialize hive
  await Hive.initFlutter();

  //open a hive box
  await Hive.openBox("expense_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Expensedata(),
      builder: (context, child) => MaterialApp(
    //    home: MyHomePage(),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const MyHomePage(),
          'borrowed/': (context)=> const MyBorrowedPage(),
          'lended/': (context)=> const MyLendedPage(),
        },
        theme: ThemeData(platform: TargetPlatform.iOS),
      ),
    );
  }
}

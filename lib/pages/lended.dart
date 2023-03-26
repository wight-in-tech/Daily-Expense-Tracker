import 'package:daily_expense/data/expense_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../components/expense_summary.dart';

class MyLendedPage extends StatefulWidget {
  const MyLendedPage({
    super.key,
  });

  @override
  State<MyLendedPage> createState() => _MyLendedPageState();
}

class _MyLendedPageState extends State<MyLendedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(
            "Lent Money page",
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
            duration: Duration(milliseconds: 300), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
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
                  text: 'Borrowed',
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
        body: Center(
          child: Column(
            children: [
              Card(
                child: Text(
                    "This page will conatian money that you lended to your friends "
                    "still under construction but will be soon active"),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Text(
                    "This page will conatian money that you lended to your friends "
                    "still under construction but will be soon active"),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Text(
                    "This page will conatian money that you lended to your friends "
                    "still under construction but will be soon active"),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Text(
                    "This page will conatian money that you lended to your friends "
                    "still under construction but will be soon active"),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Text(
                    "This page will conatian money that you lended to your friends "
                    "still under construction but will be soon active",
                style: TextStyle(fontWeight: FontWeight.bold),),

              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Text(
                    "This page will conatian money that you lended to your friends "
                    "still under construction but will be soon active"),
              ),
            ],
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ));
  }
}

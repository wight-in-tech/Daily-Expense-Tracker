import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function (BuildContext)? deleteTapped;
  ExpenseTile({
    super.key,
    required this.amount,
    required this.dateTime,
    required this.name,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane:ActionPane(motion: const StretchMotion(),
          children: [
            //delete button 
            SlidableAction(onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.black54,
            borderRadius: BorderRadius.circular(2),),
          ],
        ),
        child: ListTile(
        title: Text(name),
        subtitle: Text(dateTime.day.toString() +
            '/' +
            dateTime.month.toString() +
            '/' +
            dateTime.year.toString()),
        trailing: Text('\₹ $amount'),));
  }
}

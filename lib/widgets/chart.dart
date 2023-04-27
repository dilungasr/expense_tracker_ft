import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get weekdayValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalVal = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        final Transaction tx = recentTransactions[i];

        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalVal += tx.amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalVal
      };
    });
  }

  double get _totalSpending {
    final double totalSpending =
        weekdayValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });

    if (totalSpending == 0.0) {
      return 0.001;
    }

    return totalSpending;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(weekdayValues);

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdayValues.map((val) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  val['day'] as String,
                  val['amount'] as double,
                  (val['amount'] as double) / _totalSpending,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

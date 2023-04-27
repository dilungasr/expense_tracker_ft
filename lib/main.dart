import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/add_tx.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/tx_list.dart';
import "package:flutter/material.dart";

void main() => runApp(const MyApp());

// NEXT: LEARN MORE FROM FREE YOUTUBE CHANNELS
//DON'T STOP! NO MATTER HOW TERRIBLE IT GETS! NO MATTER HOW TASTELESS IT GETS!
// IT WILL ALL BE GOOD IN THE END! If you feel slow do it slowly. If you feel
// bad, do it badly but makesure you always do it anyway!

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          backgroundColor: Colors.white,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.purple,
              ),
              bodyMedium: const TextStyle(fontFamily: "Montserrat"),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            fontSize: 17,
            letterSpacing: 1,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: DateTime.now().toString(),
    //   title: "Tambi",
    //   amount: 7.5,
    //   date: DateTime.now().subtract(const Duration(days: 1)),
    // ),
    // Transaction(
    //   id: DateTime.now().toString(),
    //   title: "Tambi",
    //   amount: 4.6,
    //   date: DateTime.now().subtract(const Duration(days: 2)),
    // ),
    // Transaction(
    //   id: DateTime.now().toString(),
    //   title: "Tambi",
    //   amount: 10.8,
    //   date: DateTime.now().subtract(const Duration(days: 5)),
    // )
  ];

  void _add(String title, double amount, DateTime time) {
    setState(() {
      _transactions.insert(
        0,
        Transaction(
          id: DateTime.now().toString(),
          amount: amount,
          title: title,
          date: time,
        ),
      );
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      final lastDay = DateTime.now().subtract(const Duration(days: 7));
      return tx.date.isAfter(lastDay);
    }).toList();
  }

  void _startAddingTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddTx(add: _add);
      },
    );
  }

  void _delete(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddingTransaction(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(
              recentTransactions: _recentTransactions,
            ),
            TxList(
              transactions: _transactions,
              delete: _delete,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddingTransaction(context),
      ),
    );
  }
}

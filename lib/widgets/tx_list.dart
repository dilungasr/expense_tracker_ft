import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/empty.dart';
import "package:flutter/material.dart";
import "package:intl/intl.dart";

class TxList extends StatelessWidget {
  final List<Transaction> transactions;

  const TxList({Key? key, required this.transactions, required this.delete})
      : super(key: key);

  final Function delete;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 470,
      child: transactions.isEmpty
          ? const Empty(emptyText: "Sorry, no transation yet")
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 8,
                  ),
                  child: Card(
                      elevation: 4,
                      child: ListTile(
                        // leading
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // title
                        title: Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),

                        subtitle: Text(
                          DateFormat.yMMMEd().format(transactions[index].date),
                        ),

                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () => delete(transactions[index].id),
                        ),
                      )),
                );
              },
            ),
    );
  }
}

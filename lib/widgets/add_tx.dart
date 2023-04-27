import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class AddTx extends StatefulWidget {
  final Function(String title, double amount, DateTime time) add;

  const AddTx({Key? key, required this.add}) : super(key: key);

  @override
  State<AddTx> createState() => _AddTxState();
}

class _AddTxState extends State<AddTx> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? _chosenDate;

  void _submitData() {
    final amount = double.parse(amountController.text);
    final title = titleController.text;

    // validate inputs
    if (amount <= 0 || title.isEmpty || _chosenDate == null) {
      return;
    }

    widget.add(
      title,
      amount,
      _chosenDate as DateTime,
    );

    Navigator.of(context).pop();
  }

  void _chooseDate(BuildContext context) async {
    final DateTime lastYear = DateTime.now().subtract(
      const Duration(days: 365),
    );
    final DateTime? dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: lastYear,
      lastDate: DateTime.now(),
    );

    if (dt == null) {
      return;
    }

    setState(() {
      _chosenDate = dt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    _chosenDate == null
                        ? "No chosen date yet"
                        : DateFormat.yMMMd().format(_chosenDate as DateTime),
                  ),
                ),
                TextButton(
                    onPressed: () => _chooseDate(context),
                    child: Text(
                      "Choose Date",
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
              ],
            ),
            ElevatedButton(
                onPressed: _submitData,
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:traversy_mmedia/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime pickedDateValue;

  void onSubmitt() {
    if (titleInput.text.isEmpty ||
        double.parse(amountInput.text) <= 0 ||
        pickedDateValue == null) return;
    widget.addTx(
        titleInput.text, double.parse(amountInput.text), pickedDateValue);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        pickedDateValue = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleInput,
              onSubmitted: (_) => onSubmitt(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountInput,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => onSubmitt(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(pickedDateValue == null
                    ? "No date Choose"
                    : DateFormat.yMd().format(pickedDateValue)),
                Container(
                  height: 70,
                  child: AdaptiveFlatButton("Choose Date", _presentDatePicker)
                )
              ],
            ),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text("Add Transaction"),
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: onSubmitt)
          ],
        ),
      ),
    );
  }
}

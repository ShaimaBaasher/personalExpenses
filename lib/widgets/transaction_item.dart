import 'package:flutter/material.dart';
import 'package:traversy_mmedia/models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {

  final Transaction userTransactions;
  final Function _deleteTransaction;

  const TransactionItem({
    Key key,
    @required this.userTransactions,
    @required Function deleteTransaction,
  })  : _deleteTransaction = deleteTransaction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                  '\$${userTransactions.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          userTransactions.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(userTransactions.date),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () => _deleteTransaction(userTransactions.id),
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                label: Text("Delete"))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    _deleteTransaction(userTransactions.id)),
      ),
    );
  }
}

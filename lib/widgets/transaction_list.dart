import 'package:flutter/material.dart';
import 'package:traversy_mmedia/widgets/transaction_item.dart';
import '../models/Transaction.dart';
import 'package:traversy_mmedia/models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function _deleteTransaction;

  TransactionList(this.userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, cons) {
              return Column(
                children: <Widget>[
                  Text("No Transaction"),
                  SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      height: cons.maxHeight * 0.4,
                      child: Image.asset(
                        'assests/images/waiting.png',
                        fit: BoxFit.scaleDown,
                      ))
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: userTransactions.length,
            itemBuilder: (ctx, index) {
              return TransactionItem(userTransactions: userTransactions[index], deleteTransaction: _deleteTransaction);
              // Card(
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin:
              //         EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //         padding: EdgeInsets.all(16),
              //         decoration: BoxDecoration(
              //             border: Border.all(color: Colors.black, width: 2)),
              //         child: Text(
              //           '\$${userTransactions[index].amount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //               fontFamily: "Cairo"),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             userTransactions[index].title,
              //             style: Theme.of(context).textTheme.title,
              //           ),
              //           Text(
              //             DateFormat('yyy-MM-dd')
              //                 .format(userTransactions[index].date),
              //             style: TextStyle(
              //                 color: Colors.grey, fontFamily: "Cairo"),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // )
            });
  }
}


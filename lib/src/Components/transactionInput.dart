import 'dart:ffi';

import 'package:firstapp/src/Utils/enums/TransactionType.dart';
import 'package:flutter/material.dart';

class TransactionInput extends StatelessWidget {
  const TransactionInput({super.key, required this.type, required this.amount});

  final String type;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return  
        Padding(
          padding: EdgeInsets.only(top: 10 ,bottom: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(type , style: TextStyle(fontSize: 16, color: Colors.green)),
              Text(amount.toString(), style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        );
  }
}

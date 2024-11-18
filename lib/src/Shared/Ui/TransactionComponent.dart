import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionComponent extends StatelessWidget {
  final String type;
  final String name;
  final String amount;
  final String date;
  const TransactionComponent(
      {super.key,
      required this.type,
      required this.name,
      required this.amount,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 114, 20, 106),
                Color(const Color.fromARGB(255, 209, 101, 168)!.value),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(80, 124, 124, 124),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  type == "Depot"? Icons.arrow_drop_up : type == "retrait" ? Icons.arrow_drop_down : type == "transfert" ? Icons.swap_horiz : Icons.wallet,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          type,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            
                            fontSize: 12,
                            color: Color.fromARGB(186, 255, 255, 255),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          type == "retrait" || type == "transfert" ? "- "+ amount : "+ "+ amount,
                          style:  TextStyle(
                            fontSize: 14,
                            color: type == "retrait" || type == "transfert" ? Colors.red : Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(186, 255, 255, 255),
                          ),
                        )
                      ],
                    )
                  ])),
            ],
          ),
        ));
  }
}

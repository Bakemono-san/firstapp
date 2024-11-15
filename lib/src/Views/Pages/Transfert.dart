import 'package:firstapp/src/Shared/Ui/CardButton.dart';
import 'package:firstapp/src/Shared/Ui/QrCodeCard.dart';
import 'package:firstapp/src/Shared/Ui/TransactionComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Transfert extends StatelessWidget {
  const Transfert({super.key});

  final Contact? selectedContact = null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Container( 
        color: const Color.fromARGB(255, 43, 43, 46),
          child: Column(
        children: [
          QrCodeCard(),
          Padding(
            padding: EdgeInsets.all(20),
            child: GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              children: [
                SizedBox(
                  height: 100, // Fixed height for CardButton
                  child: CardButton(
                      // onPressed: () => onPressed(),
                      label: "paiement",
                      icon: Icons.payment),
                ),
                SizedBox(
                  height: 100, // Fixed height for CardButton
                  child: CardButton(
                      // onPressed: () => onPressed(),
                      label: "Transfert",
                      icon: Icons.swap_horiz),
                ),
                SizedBox(
                  height: 100, // Fixed height for CardButton
                  child: CardButton(
                      // onPressed: () => onPressed(),
                      label: "Envoie",
                      icon: Icons.send),
                ),
                SizedBox(
                  height: 100, // Fixed height for CardButton
                  child: CardButton(
                      // onPressed: () => onPressed(),
                      label: "Depot",
                      icon: Icons.savings),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 10),
              shrinkWrap: true,
              children: [
                TransactionComponent(
                    name: "Issa diol",
                    type: "paiement",
                    amount: "100",
                    date: "2022/10/10"),
                TransactionComponent(
                    name: "Souleye",
                    type: "paiement",
                    amount: "100",
                    date: "2022/10/10"),
                TransactionComponent(
                    name: "Issa diol",
                    type: "paiement",
                    amount: "100",
                    date: "2022/10/10"),
                TransactionComponent(
                    name: "Souleye",
                    type: "paiement",
                    amount: "100",
                    date: "2022/10/10"),
                TransactionComponent(
                    name: "Issa diol",
                    type: "transfert",
                    amount: "100",
                    date: "2022/10/10"),
              ],
            ),
          )
        ],
      )),
    );
  }
}
import 'package:firstapp/src/Components/iconButton.dart';
import 'package:firstapp/src/Components/transactionInput.dart';
import 'package:firstapp/src/Controllers/TransactionsConstroller.dart';
import 'package:firstapp/src/Services/TokenManager.dart';
import 'package:firstapp/src/Shared/Ui/TransactionComponent.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/src/ResponseDtos/ReponseDto.dart';
import 'package:firstapp/src/Services/Fetch.dart';
import 'package:provider/provider.dart';

class Transaction {
  final String type;
  final String montant;
  final String date;
  final String receiver;

  Transaction(
      {required this.type,
      required this.montant,
      required this.date,
      required this.receiver});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'] as String,
      montant: json['montant'].toString(),
      date: json['date'] as String,
      receiver: json['receiver'].toString(),
    );
  }
}

class Acceuilmain extends StatefulWidget {
  final String qrCode;
  final Function(int) onTabChange;

  const Acceuilmain({Key? key, required this.qrCode, required this.onTabChange})
      : super(key: key);

  @override
  State<Acceuilmain> createState() => AcceuilMainState();
}

class AcceuilMainState extends State<Acceuilmain> {
  late String qrCode;
  String? solde;
  ValueNotifier<bool> _isSoldeVisibleNotifier = ValueNotifier<bool>(true);

  void _toggleSoldeVisibility() {
    _isSoldeVisibleNotifier.value = !_isSoldeVisibleNotifier.value;
  }

  @override
  void initState() {
    super.initState();
    qrCode = widget.qrCode;
    _fetchSolde();
    Provider.of<TransactionsController>(context, listen: false).loadTransactions();
  }

  // Fetch the solde value
  Future<void> _fetchSolde() async {
    try {
      final fetchedSolde =
          await TokenManager.getSolde(); // Assuming getSolde() returns a String
      setState(() {
        solde = fetchedSolde
            .toString(); // Update the state with the fetched solde value
      });
      print("Solde: $solde");
    } catch (error) {
      print("Error fetching solde: $error");
    }
  }

  Future<List<Transaction>> getDatas() async {
    try {
      var response = await Fetch.fetchUsers("Transaction");

      if (response is Map<String, dynamic> && response['data'] is List) {
        List<Transaction> transactions = (response['data'] as List)
            .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
            .toList();
        return transactions;
      } else {
        throw Exception("Invalid response format or missing data field");
      }
    } catch (error) {
      print("Error fetching data: $error");
      throw Exception("Failed to fetch data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 134, 62, 106),
        title: Center(child: Text("Home")), // Example title text
      ),
      body: Container(
      color: Color.fromARGB(255, 134, 62, 106),
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: _isSoldeVisibleNotifier,
                  builder: (context, isSoldeVisible, child) {
                    return Text(
                      isSoldeVisible
                          ? (solde ??
                              'Loading...') // Provide fallback text if solde is null
                          : '*******', // Mask balance if hidden
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    _isSoldeVisibleNotifier.value
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    color: Colors.white,
                  ),
                  onPressed:
                      _toggleSoldeVisibility, // Toggle visibility when clicked
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                ),
                Positioned.fill(
                  top: 90,
                  left: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width / 2,
                    height: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Wrap(
                            spacing: 30,
                            runSpacing: 10,
                            children: [
                              const CustomIconButton(
                                icon: Icon(Icons.person, color: Colors.white),
                                text: 'Send',
                              ),
                              const CustomIconButton(
                                icon: Icon(Icons.payment, color: Colors.white),
                                text: 'Payments',
                              ),
                              CustomIconButton(
                                icon: const Icon(Icons.airplane_ticket,
                                    color: Colors.white),
                                text: "Transfert",
                                onPressed: () {
                                  widget.onTabChange(3);
                                },
                              ),
                              const CustomIconButton(
                                icon: Icon(
                                  Icons.food_bank,
                                  color: Colors.white,
                                ),
                                text: "Bank",
                              ),
                              const CustomIconButton(
                                icon:
                                    Icon(Icons.sms_sharp, color: Colors.white),
                                text: "Rewards",
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                color: Color.fromARGB(255, 134, 62, 106),
                                child: Consumer<TransactionsController>(
                                  builder: (context, transactions, child) {
                                    if(transactions.transactions.isEmpty){
                                      return const Center(child: CircularProgressIndicator());
                                    }

                                    return ListView.builder(
                                      itemCount: transactions.transactions.length,
                                      itemBuilder: (context, index) {
                                        var transaction = transactions.transactions[index];
                                        return TransactionComponent(type: transaction.type, name: transaction.receiverTelephone!, amount: transaction.montant.toString(), date: transaction.date.toString());
                                      },
                                    );
                                  },
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 6,
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: MediaQuery.of(context).size.height / 5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 235, 6, 158),
                    ),
                    child: Center(
                      child: Image.network(
                        qrCode,
                        height: 100,
                        width: 150,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}


// FutureBuilder<List<Transaction>>(
//                                   future: getDatas(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return const Center(
//                                           child: CircularProgressIndicator());
//                                     } else if (snapshot.hasError) {
//                                       return Center(
//                                           child:
//                                               Text('Error: ${snapshot.error}'));
//                                     } else if (!snapshot.hasData ||
//                                         snapshot.data!.isEmpty) {
//                                       return const Center(
//                                           child: Text('No data available.'));
//                                     } else {
//                                       return ListView.builder(
//                                         itemCount: snapshot.data!.length,
//                                         itemBuilder: (context, index) {
//                                           var transaction =
//                                               snapshot.data![index];
//                                           return TransactionInput(
//                                             type: transaction.type,
//                                             amount: transaction.montant,
//                                           );
//                                         },
//                                       );
//                                     }
//                                   },
//                                 ),
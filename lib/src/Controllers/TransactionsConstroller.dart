import 'dart:ffi';

import 'package:firstapp/src/Controllers/ControllerInterface.dart';
import 'package:firstapp/src/Models/TransactionDto.dart';
import 'package:firstapp/src/RequestDtos/TransactionSimple.dart';
import 'package:firstapp/src/ResponseDtos/ReponseDto.dart';
import 'package:firstapp/src/Services/Fetch.dart';
import 'package:firstapp/src/Utils/Mixins/ProviderMixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class TransactionsController extends ChangeNotifier with Providermixin
    implements ControllerInterface<TransactionDto>{
  List<TransactionDto> transactions = [];

  

  List<TransactionDto> get transactionsData => transactions;

  Future<void> updateData(TransactionDto transaction) async {
    transactions.remove(transaction);
    transactions.add(transaction);
    this.context.notifierChangement();
  }

  Future<void> clearTransactions() async {
    transactions.clear();
  }

  Future<void> deleteData(TransactionDto transaction) async {
    transactions.remove(transaction);
    this.context.notifierChangement();
  }

  Future<void> addData(TransactionDto transaction) async {
    transactions.add(transaction);
    this.context.notifierChangement();
  }

  Future<TransactionDto> getDataById(Long id) async {
    return transactions.firstWhere((p) => p.id == id);
  }

  void loadTransactions() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      var response = await Fetch.fetchUsers("Transaction/myTransaction");

      // Access 'data' from the parsed JSON response
      var transactionsData =
          response['data']; // response is a Map, so use the key 'data'

      // Check if the data is not empty and then map it to TransactionDto objects
      if (transactionsData != null && transactionsData is List) {
        transactions = transactionsData
            .map(
                (item) => TransactionDto.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      // Notify listeners after the data is processed
      this.context.notifierChangement();
    } catch (e) {
      print('Error loading transactions: $e');
    }
  }
  
  Future<void> submitForm(
      {required String type,
      required double montant,
      required String receiverTelephone,
      String? agentTelephone,
      required DateTime date,
      required BuildContext context}) async {
    if (type.toString().isEmpty || montant <= 0 || receiverTelephone.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill out all fields correctly.")),
      );
      return;
    }

    TransactionDto newTransaction = TransactionDto(
      type: type,
      montant: montant,
      receiverTelephone: receiverTelephone,
      agentTelephone: agentTelephone,
      date: date,
    );

    print(newTransaction.toJson());

    try {
      ReponseDto response = await Fetch.postDatas("Transaction", newTransaction.toJson());

      print(response.data.data);
      
      if (response.data.data != null) {
        addData(newTransaction);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Transaction added successfully!"),backgroundColor: Colors.green,),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add transaction: ${response.message}"),backgroundColor: Colors.red,),
        );
      }
    } catch (e) {
      print("Error in submitForm: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add transaction: ${e}")),
      );
    }
  }


  Future<void> submitMultiForm(
      {
      required double montant,
      required String type,
      required DateTime date,
      required List<Contact> telephones,
      required BuildContext context}) async {
        if(telephones.isEmpty || montant <= 0){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please fill out all fields correctly.")),
          );
          return;
        }

    List<String> receiverTelephone = telephones.map((el)=> el.phones.first.normalizedNumber).toList();

    print(receiverTelephone);
    
    TransactionMultiple transaction = TransactionMultiple(
      montant: montant,
      ids: receiverTelephone,
    );

    // Send the transfer request to the server
    ReponseDto trans = await Fetch.postDatas(
        "Transaction/groupe", TransactionMultiple.toJson(transaction));

    print(trans.data.data);

    if (trans.data.data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Transfer echouee! : ${trans.message}"),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Transfer state!: ${trans.message}"),
          backgroundColor: Color.fromARGB(255, 62, 109, 51),
        ),
      );
    }

  }
      
  Future<void> PaiementMarchand({
    required String type,
    required double montant,
    required String receiverTelephone,
    required DateTime date,
    required BuildContext context,
  }) async {
    
    TransactionDto newTransaction = TransactionDto(
      type: type,
      montant: montant,
      receiverTelephone: receiverTelephone,
      date: date,
    );

    print(newTransaction.toJson());

    try {
      ReponseDto response = await Fetch.postDatas("Transaction/paiements", newTransaction.toJson());

      print(response.data.data);
      
      if (response.data.data != null) {
        addData(newTransaction);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Transaction added successfully!"),backgroundColor: Colors.green,),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add transaction: ${response.message}"),backgroundColor: Colors.red,),
        );
      }
    } catch (e) {
      print("Error in submitForm: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add transaction: ${e}")),
      );
    }
  }
}

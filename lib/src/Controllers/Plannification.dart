import 'dart:ffi';

import 'package:firstapp/src/Controllers/ControllerInterface.dart';
import 'package:firstapp/src/Models/PlannificationDto.dart';
import 'package:firstapp/src/Providers/Provider.dart';
import 'package:firstapp/src/ResponseDtos/ReponseDto.dart';
import 'package:firstapp/src/Services/Fetch.dart';
import 'package:firstapp/src/Utils/Mixins/ProviderMixin.dart';
import 'package:firstapp/src/Utils/enums/Period.dart';
import 'package:flutter/material.dart';

class PlannificationController extends ChangeNotifier with Providermixin implements ControllerInterface<PlannificationDto> {
  List<PlannificationDto> plannifications = [];

  List<PlannificationDto> get plannificationsData => plannifications;

  Future<void> addData(PlannificationDto plannification) async {

    plannifications.add(plannification);
    this.context.notifierChangement();
  }

  Future<void> deleteData(PlannificationDto plannification) async {
    plannifications.remove(plannification);
    this.context.notifierChangement();
  }

  Future<void> updateData(PlannificationDto plannification) async {
    plannifications.remove(plannification);
    plannifications.add(plannification);
    this.context.notifierChangement();
  }

  Future<void> clearPlannifications() async {
    plannifications.clear();
  }

  Future<PlannificationDto> getDataById(Long id) async {
    return plannifications.firstWhere((p) => p.id == id);
  }

   Future<void> submitForm({
      required double montant,
      required String receiverTelephone,
      required String period,
      required BuildContext context}) async {
    if (period.toString().isEmpty || montant <= 0 || receiverTelephone.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill out all fields correctly.")),
      );
      return;
    }

    

    PlannificationDto newTransaction = PlannificationDto(
      montant: montant,
      receiverId: receiverTelephone,
      period: period.toString(),
    );

    print(newTransaction.toJson());

    try {
      ReponseDto response = await Fetch.postDatas("Planning", newTransaction.toJson());

      print("response: ${response.data}");
      
      if (response.data.data != null) {
        addData(newTransaction);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Plannification added successfully!"),backgroundColor: Colors.green,),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add Plannification: ${response.message}"),backgroundColor: Colors.red,),
        );
      }
    } catch (e) {
      print("Error in submitForm: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add Plannification: ${e}")),
      );
    }
  }


}
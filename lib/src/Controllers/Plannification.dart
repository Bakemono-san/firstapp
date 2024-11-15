import 'dart:ffi';

import 'package:firstapp/src/Controllers/ControllerInterface.dart';
import 'package:firstapp/src/Models/PlannificationDto.dart';
import 'package:firstapp/src/Providers/Provider.dart';
import 'package:firstapp/src/Utils/Mixins/ProviderMixin.dart';
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

}
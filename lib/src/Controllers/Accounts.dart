import 'dart:ffi';

import 'package:firstapp/src/Controllers/ControllerInterface.dart';
import 'package:firstapp/src/Models/AccountDto.dart';
import 'package:firstapp/src/Providers/Provider.dart';
import 'package:firstapp/src/Utils/Mixins/ProviderMixin.dart';
import 'package:flutter/material.dart';

class Accounts extends ChangeNotifier with Providermixin implements ControllerInterface<Accountdto> {
  List<Accountdto> accounts = [];

  List<Accountdto> get acountsData => accounts;

  Future<void> updateData(Accountdto account) async {
    accounts.remove(account);
    accounts.add(account);
    this.context.notifierChangement();
  }

  Future<void> clearAccounts() async {
    accounts.clear();
  }

  Future<void> deleteData(Accountdto account) async {
    accounts.remove(account);
    this.context.notifierChangement();
  }

  Future<void> addData(Accountdto account) async {
    accounts.add(account);
    this.context.notifierChangement();
  }

  Future<Accountdto> getDataById(Long id) async {
    return accounts.firstWhere((p) => p.id == id);
  }
}

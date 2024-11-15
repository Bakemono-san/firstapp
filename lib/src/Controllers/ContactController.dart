import 'dart:ffi';

import 'package:firstapp/src/Controllers/ControllerInterface.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/src/Utils/Mixins/ProviderMixin.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactController extends ChangeNotifier with Providermixin implements ControllerInterface{

  List<Contact> contacts = [];

  List<Contact> filteredContacts = [];

  ContactController() {
    _initialize();
  }

  Future<void> _initialize() async {
    await loadContacts();
  }

  @override
  Future<void> addData(data) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(data) {
    throw UnimplementedError();
  }

  @override
  Future getDataById(Long id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateData(data) {
    throw UnimplementedError();
  }
  
  Future<void> loadContacts() async {
    bool permissionGranted = await FlutterContacts.requestPermission();
    print(permissionGranted);
    if (permissionGranted) {
      final fetchedContacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      contacts = fetchedContacts;
      filteredContacts = fetchedContacts;
      context.notifierChangement();
    } else {
      throw Exception("Permission denied to access contacts");
    }
    return;
  }

  void filterContacts(String query) {
    if (query.isEmpty) {
      filteredContacts = contacts;
    } else {
      filteredContacts = contacts.where((contact) {
        final name = contact.displayName.toLowerCase();
        final phone = contact.phones.isNotEmpty ? contact.phones.first.number : '';
        return name.contains(query.toLowerCase()) || phone.contains(query);
      }).toList();
    }
    notifyListeners(); // Notify listeners for UI update
  }
}
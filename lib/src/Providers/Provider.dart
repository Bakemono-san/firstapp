import 'package:firstapp/src/Providers/ProviderInterface.dart';
import 'package:flutter/material.dart';

class Provider extends ChangeNotifier implements ProviderInterface {
  void notifierChangement(){
    notifyListeners();
  }
}
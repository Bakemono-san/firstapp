import 'package:firstapp/src/Providers/ContextProvider.dart';
import 'package:firstapp/src/Providers/ProviderInterface.dart';
import 'package:flutter/material.dart';

mixin Providermixin on ChangeNotifier{
  ProviderInterface get context => Contextprovider.getContext();
}
import 'package:firstapp/src/Views/Pages/MainPage.dart';
import 'package:firstapp/src/Views/Pages/Plannification.dart';
import 'package:firstapp/src/Views/Pages/acceuil.dart';
import 'package:firstapp/src/Views/Pages/home.dart';
import 'package:firstapp/src/Views/Pages/login.dart';
import 'package:firstapp/src/Views/Pages/register.dart';
import 'package:firstapp/src/Views/Pages/transfert.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = '/';

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => Home(),
    '/login': (context) => LoginForm(),
    '/register': (context) => Plannification(),
    '/acceuil': (context) => Acceuil(),
    '/transfert': (context) => Transfert(),
  };
  
  
}
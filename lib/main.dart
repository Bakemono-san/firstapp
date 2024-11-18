import 'package:firstapp/src/Controllers/ContactController.dart';
import 'package:firstapp/src/Controllers/Plannification.dart';
import 'package:firstapp/src/Controllers/TransactionsConstroller.dart';
import 'package:firstapp/src/Services/DependencyLoader.dart';
import 'package:firstapp/src/Utils/Constantes/Constants.dart';
import 'package:firstapp/src/Utils/Themes/ThemeConfig.dart';
import 'package:firstapp/src/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  
  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {

  void initState() {
    super.initState();
    DependencyLoader.load();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Move MediaQuery calls here
    Constants.setConstant("screenWidth", MediaQuery.of(context).size.width);
    Constants.setConstant("screenHeight", MediaQuery.of(context).size.height);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Use MultiProvider to provide multiple providers
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionsController()),
        ChangeNotifierProvider(create: (_) => ContactController()),
        ChangeNotifierProvider(create: (_) => PlannificationController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initialRoute,
        theme: Themeconfig.themeData,
        routes: Routes.routes,
      ),
    );
  }
}

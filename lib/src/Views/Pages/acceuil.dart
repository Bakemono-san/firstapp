import 'package:firstapp/src/Services/UserEntity.dart';
import 'package:firstapp/src/Views/Pages/MultiContactTransferScreen.dart';
import 'package:firstapp/src/Views/Pages/PaiementMarchand.dart';
import 'package:firstapp/src/Views/Pages/TransfertGroupePage.dart';
import 'package:firstapp/src/Views/Pages/TransfertPage.dart';
import 'package:firstapp/src/Views/Pages/paiement.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/src/Views/Pages/acceuilMain.dart';
import 'package:firstapp/src/Views/Pages/transfert.dart';
import 'package:firstapp/src/Services/TokenManager.dart';
import 'package:firstapp/src/Views/Pages/Setting.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  int index = 0;  // Track the selected tab index
  User? user;
  List<int> navigationHistory = [0]; // History stack for navigation

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  // Fetch user details
  Future<void> _fetchUser() async {
    var connectedUser = await TokenManager.getUser();
    setState(() {
      user = connectedUser;
    });
    print("user : " + user.toString());
  }

  // Change tab when a BottomNavigationBar item is tapped
  void changeTab(int newIndex) {
    setState(() {
      if (newIndex != index) {
        navigationHistory.add(newIndex); // Add new tab to history
        index = newIndex;
      }
    });
  }

  // Handle back navigation
  Future<bool> _onWillPop() async {
    if (navigationHistory.length > 1) {
      setState(() {
        navigationHistory.removeLast(); // Remove current tab from history
        index = navigationHistory.last; // Go back to the previous tab
      });
      return false; // Prevent exiting the app
    }
    return true; // Exit the app if history is empty
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Define the list of pages (tabs) based on user data
    final List<Widget> tabs = [
      Acceuilmain(qrCode: user!.qrCode, onTabChange: changeTab),  // Home screen
      PaiementMarchand(),  // Payment screen
      Transfertgroupepage(),  // Group transfer screen
      Setting(),  // Settings screen
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            // Only show the currently selected tab by index
            for (int i = 0; i < tabs.length; i++)
              Offstage(offstage: index != i, child: tabs[i]),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Color.fromARGB(255, 255, 0, 191),
          selectedItemColor: const Color.fromARGB(255, 112, 36, 96),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: index,
          onTap: changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Transfert',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sync_alt),
              label: 'Multi-Transfer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

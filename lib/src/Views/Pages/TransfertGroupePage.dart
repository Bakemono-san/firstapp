import 'package:firstapp/src/Controllers/ContactController.dart';
import 'package:firstapp/src/Controllers/TransactionsConstroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';

class Transfertgroupepage extends StatefulWidget {
  const Transfertgroupepage({super.key});

  @override
  _TransfertgroupepageState createState() => _TransfertgroupepageState();
}

class _TransfertgroupepageState extends State<Transfertgroupepage> {
  final Set<Contact> selectedContacts = {};
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final transfertController =
        Provider.of<TransactionsController>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 62, 106),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Send Money",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () {
              // Transaction history
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Amount Input Section
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 235, 6, 158),
                    Color.fromARGB(255, 134, 62, 106),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amount to Send",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _amountController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: Colors.white70,
                        size: 28,
                      ),
                      hintText: "0.00",
                      hintStyle: TextStyle(
                        color: Colors.white38,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),

            // Contacts Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Contacts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white70),
                    onPressed: () {
                      // Implement search
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(72, 235, 147, 205),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Consumer<ContactController>(
                  builder: (context, contactController, child) {
                    var contacts = contactController.contacts;
                    if (contacts.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        var contact = contacts[index];
                        bool isSelected = selectedContacts.contains(contact);

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color.fromARGB(255, 236, 14, 170)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedContacts.remove(contact);
                                } else {
                                  selectedContacts.add(contact);
                                }
                              });
                            },
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 235, 6, 158),
                                    Color.fromARGB(255, 134, 62, 106),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  contact.displayName
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              contact.displayName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              contact.phones.isNotEmpty
                                  ? contact.phones.first.number
                                  : "No phone number",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(Icons.check_circle,
                                    color: Color.fromARGB(255, 235, 193, 221))
                                : null,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // Send Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed:
                    selectedContacts.isEmpty || _amountController.text.isEmpty
                        ? null
                        : () {
                            final amountText = _amountController.text;
                            final amount = double.tryParse(amountText);

                            transfertController.submitMultiForm(
                              type: "Transfert",
                              date: DateTime.now(),
                              montant: amount!,
                              telephones: selectedContacts.toList(),
                              context: context,
                            );

                            setState(() {
                              selectedContacts.clear();
                              _amountController.clear();
                            });
                          },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  backgroundColor: Color.fromARGB(255, 235, 6, 158),
                ),
                child: Text(
                  "Send Money",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}

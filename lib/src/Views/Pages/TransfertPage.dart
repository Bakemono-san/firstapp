import 'package:firstapp/src/Controllers/ContactController.dart';
import 'package:firstapp/src/Controllers/TransactionsConstroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';

const Color pinkColor = Color.fromARGB(255, 235, 6, 158);
const Color purpleColor = Color.fromARGB(255, 134, 62, 106);
const Color darkBackgroundColor = Color(0xFF1E1E1E);
const Color lightCardColor = Color(0xFF2A2A2A);

class TransfertPage extends StatefulWidget {
  const TransfertPage({super.key});

  @override
  _TransfertPageState createState() => _TransfertPageState();
}

class _TransfertPageState extends State<TransfertPage> {
  Contact? selectedContact;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final transfertController = Provider.of<TransactionsController>(context, listen: false);

    return Scaffold(
      backgroundColor: darkBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Send Money",
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              // Transaction history
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Input Section
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: lightCardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Amount to Send", style: TextStyle(color: Colors.white70, fontSize: 16)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _amountController,
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money, color: Colors.white70, size: 28),
                        hintText: "0.00",
                        hintStyle: const TextStyle(color: Colors.white38, fontSize: 28, fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),

              // Search and Contacts Section
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search contacts",
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: pinkColor),
                  filled: true,
                  fillColor: lightCardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (query) {
                  Provider.of<ContactController>(context, listen: false).filterContacts(query);
                },
              ),
              
              const SizedBox(height: 16),

              Expanded(
                child: Consumer<ContactController>(
                  builder: (context, contactController, child) {
                    var contacts = contactController.filteredContacts;
                    if (contacts.isEmpty) {
                      return const Center(child: CircularProgressIndicator(color: pinkColor));
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        var contact = contacts[index];
                        bool isSelected = selectedContact != null &&
                            selectedContact!.phones.isNotEmpty &&
                            contact.phones.isNotEmpty &&
                            selectedContact!.phones.first.number == contact.phones.first.number;

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? pinkColor.withOpacity(0.2) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                selectedContact = contact;
                              });
                            },
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [pinkColor, purpleColor]),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  contact.displayName[0].toUpperCase(),
                                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            title: Text(
                              contact.displayName,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              contact.phones.isNotEmpty ? contact.phones.first.number : "No phone number",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: isSelected ? const Icon(Icons.check_circle, color: pinkColor) : null,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectedContact == null || _amountController.text.isEmpty
            ? null
            : () {
                final amountText = _amountController.text;
                final phoneNumber = selectedContact?.phones.isNotEmpty == true
                    ? selectedContact!.phones.first.number
                    : null;

                if (phoneNumber != null && double.tryParse(amountText) != null) {
                  final amount = double.parse(amountText);
                  transfertController.submitForm(
                      type: "Transfert", date: DateTime.now(), montant: amount, receiverTelephone: phoneNumber, context: context);
                }
              },
        backgroundColor: pinkColor,
        icon: const Icon(Icons.send, color: Colors.white),
        label: const Text("Send Money", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

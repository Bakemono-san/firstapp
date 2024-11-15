import 'package:firstapp/src/RequestDtos/TransactionSimple.dart';
import 'package:firstapp/src/ResponseDtos/ReponseDto.dart';
import 'package:firstapp/src/Services/Fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class MultiContactTransferScreen extends StatefulWidget {
  const MultiContactTransferScreen({super.key});

  @override
  State<MultiContactTransferScreen> createState() => _MultiContactTransferScreenState();
}

class _MultiContactTransferScreenState extends State<MultiContactTransferScreen> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  Set<Contact> _selectedContacts = {};
  final _searchController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    if (await FlutterContacts.requestPermission()) {
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
        _isLoading = false;
      });
    }
  }

  void _filterContacts(String query) {
    setState(() {
      _filteredContacts = _contacts
          .where((contact) =>
              contact.displayName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showConfirmationDialog() {
    if (_selectedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one contact')),
      );
      return;
    }

    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an amount')),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Transfer'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount: \$${amount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Selected Contacts:'),
              const SizedBox(height: 8),
              ..._selectedContacts.map((contact) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('• ${contact.displayName}'),
                  )),
              const SizedBox(height: 16),
              Text(
                'Total Transfer: \$${(amount * _selectedContacts.length).toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              transfert();
              Navigator.pop(context);
              setState(() {
                _selectedContacts.clear();
                _amountController.clear();
              });
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search contacts',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: _filterContacts,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter amount',
                          prefixIcon: const Icon(Icons.attach_money),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredContacts.length,
                    itemBuilder: (context, index) {
                      final contact = _filteredContacts[index];
                      return CheckboxListTile(
                        value: _selectedContacts.contains(contact),
                        onChanged: (selected) {
                          setState(() {
                            if (selected!) {
                              _selectedContacts.add(contact);
                            } else {
                              _selectedContacts.remove(contact);
                            }
                          });
                        },
                        title: Text(contact.displayName),
                        subtitle: Text(
                          contact.phones.isNotEmpty
                              ? contact.phones.first.number
                              : 'No phone number',
                        ),
                        secondary: CircleAvatar(
                          child: Text(
                            contact.displayName[0].toUpperCase(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${_selectedContacts.length} contacts selected',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _showConfirmationDialog,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Continue'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void transfert() async {
    final selectedContact = this._selectedContacts;
    final contacts = selectedContact.map((e) => e.phones.first.normalizedNumber).toList();

    final amount = double.parse(this._amountController.text);

    TransactionMultiple transaction = TransactionMultiple(
      montant: amount,
      ids: contacts,
    );

    // Send the transfer request to the server
    ReponseDto trans = await Fetch.postDatas(
        "Transaction/groupe", TransactionMultiple.toJson(transaction));

    print(trans.data.data);

    if (trans.data.data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Transfer echouee! : ${trans.message}"),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Transfer state!: ${trans.message}"),
          backgroundColor: Color.fromARGB(255, 62, 109, 51),
        ),
      );
    }

  }
}
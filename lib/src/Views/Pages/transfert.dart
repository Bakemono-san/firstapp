import 'package:firstapp/src/RequestDtos/TransactionSimple.dart';
import 'package:firstapp/src/ResponseDtos/ReponseDto.dart';
import 'package:firstapp/src/Services/Fetch.dart';
import 'package:firstapp/src/Utils/enums/TransactionType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Transfert extends StatefulWidget {
  @override
  _TransfertState createState() => _TransfertState();
}

class _TransfertState extends State<Transfert> {
  List<Contact> contacts = [];
  Contact? selectedContact;
  TextEditingController amountController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  bool showConfirmation = false;
  List<Contact> filteredContacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<void> getContacts() async {
    bool permissionGranted = await FlutterContacts.requestPermission();
    print(permissionGranted);
    if (permissionGranted) {
      final fetchedContacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      setState(() {
        contacts = fetchedContacts;
        filteredContacts = fetchedContacts;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permission denied to access contacts'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void filterContacts(String query) {
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
              contact.displayName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget buildContactAvatar(Contact contact) {
    return FutureBuilder<Contact?>(
      future: contact.photo == null
          ? null
          : FlutterContacts.getContact(contact.id, withPhoto: true),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.photo != null) {
          return Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromARGB(255, 235, 6, 158),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.memory(
                snapshot.data!.photo!,
                fit: BoxFit.cover,
              ),
            ),
          );
        }

        // Fallback to initials
        String initials = contact.displayName.isNotEmpty
            ? contact.displayName.substring(0, 1).toUpperCase()
            : "?";
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 134, 62, 106),
            shape: BoxShape.circle,
            border: Border.all(
              color: Color.fromARGB(255, 235, 6, 158),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildNumericKeypad() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          for (int i = 0; i < 3; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int j = 1; j <= 3; j++)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        amountController.text += (i * 3 + j).toString();
                      });
                    },
                    child: Text(
                      (i * 3 + j).toString(),
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 134, 62, 106),
                      ),
                    ),
                  ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  if (!amountController.text.contains('.')) {
                    setState(() {
                      amountController.text += ".";
                    });
                  }
                },
                child: Text(
                  ".",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 134, 62, 106),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    amountController.text += "0";
                  });
                },
                child: Text(
                  "0",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 134, 62, 106),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (amountController.text.isNotEmpty) {
                    setState(() {
                      amountController.text = amountController.text
                          .substring(0, amountController.text.length - 1);
                    });
                  }
                },
                icon: Icon(
                  Icons.backspace,
                  color: Color.fromARGB(255, 134, 62, 106),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildConfirmationDialog() {
    String phoneNumber = selectedContact?.phones.isNotEmpty == true
        ? selectedContact!.phones.first.number
        : 'No phone number';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Transfer Confirmation",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 134, 62, 106),
            ),
          ),
          SizedBox(height: 20),
          if (selectedContact != null) buildContactAvatar(selectedContact!),
          SizedBox(height: 15),
          Text(
            selectedContact?.displayName ?? 'Unknown',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            phoneNumber,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 134, 62, 106).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "\$${amountController.text}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 134, 62, 106),
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    showConfirmation = false;
                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement transfer logic here
                  transfert();
                  setState(() {
                    showConfirmation = false;
                    selectedContact = null;
                    amountController.clear();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 134, 62, 106),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: searchController,
                  onChanged: filterContacts,
                  decoration: InputDecoration(
                    hintText: "Search contacts...",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 134, 62, 106),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 235, 6, 158),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 134, 62, 106),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),

              // Contacts List
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 134, 62, 106),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = filteredContacts[index];
                          return ListTile(
                            leading: buildContactAvatar(contact),
                            title: Text(contact.displayName),
                            subtitle: Text(
                              contact.phones.isNotEmpty
                                  ? contact.phones.first.number
                                  : "No phone number",
                            ),
                            selected: selectedContact == contact,
                            selectedTileColor: Color.fromARGB(255, 134, 62, 106)
                                .withOpacity(0.1),
                            onTap: () {
                              setState(() {
                                selectedContact = contact;
                              });
                            },
                          );
                        },
                      ),
              ),

              // Amount Input
              if (selectedContact != null) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: amountController,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      color: Color.fromARGB(255, 134, 62, 106),
                    ),
                    decoration: InputDecoration(
                      prefixText: "\$",
                      prefixStyle: TextStyle(
                        fontSize: 32,
                        color: Color.fromARGB(255, 134, 62, 106),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 235, 6, 158),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                buildNumericKeypad(),
                SizedBox(height: 20),
                if (amountController.text.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showConfirmation = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 134, 62, 106),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ],
          ),
          if (showConfirmation)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: buildConfirmationDialog(),
              ),
            ),
        ],
      ),
    );
  }

  void transfert() async {
    final selectedContact = this.selectedContact;
    final amount = double.parse(this.amountController.text);

    TransactionSimple transaction = TransactionSimple(
      type: Transactiontype.Transfert,
      montant: amount,
      receiverTelephone: selectedContact!.phones.first.normalizedNumber,
      date: DateTime.now(),
    );

    // Send the transfer request to the server
    ReponseDto trans = await Fetch.postDatas(
        "Transaction", TransactionSimple.toJson(transaction));

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
          content: Text("Transfer successful!"),
          backgroundColor: Color.fromARGB(255, 51, 255, 0),
        ),
      );
    }

    print(
        "${selectedContact?.displayName} : ${selectedContact?.phones.first.normalizedNumber} has been transferred $amount");
  }
}

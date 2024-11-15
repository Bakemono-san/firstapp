import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Paiement extends StatefulWidget {
  const Paiement({Key? key}) : super(key: key);

  @override
  _PaiementState createState() => _PaiementState();
}

class _PaiementState extends State<Paiement> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedRecipient;
  String _selectedPaymentMethod = 'Credit Card';
  bool _savePaymentDetails = false;
  final List<String> _recipients = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Wilson'
  ];

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Help'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FAQ:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('• Minimum payment amount is \$1'),
            Text('• Maximum payment amount is \$10,000'),
            Text('• Transaction fees may apply'),
            Text('• Payments are processed instantly'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Payment Amount Field
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Amount (USD)',
                            prefixText: '\$',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.help_outline),
                        onPressed: _showHelpDialog,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Recipient Selection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select Recipient',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedRecipient,
                    items: _recipients.map((String recipient) {
                      return DropdownMenuItem<String>(
                        value: recipient,
                        child: Text(recipient),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRecipient = value;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Payment Methods
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Method',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPaymentMethodButton(
                            'Credit Card',
                            Icons.credit_card,
                            _selectedPaymentMethod == 'Credit Card',
                          ),
                          _buildPaymentMethodButton(
                            'Bank',
                            Icons.account_balance,
                            _selectedPaymentMethod == 'Bank',
                          ),
                          _buildPaymentMethodButton(
                            'Mobile',
                            Icons.phone_android,
                            _selectedPaymentMethod == 'Mobile',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Transaction Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaction Summary',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      _buildSummaryRow('Amount:', '\$${_amountController.text}'),
                      _buildSummaryRow('Recipient:', _selectedRecipient ?? 'Not selected'),
                      _buildSummaryRow('Payment Method:', _selectedPaymentMethod),
                      _buildSummaryRow('Fee:', '\$0.00'),
                      const Divider(),
                      _buildSummaryRow(
                        'Total:',
                        '\$${_amountController.text}',
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Save Payment Details
              CheckboxListTile(
                title: const Text('Save Payment Details'),
                value: _savePaymentDetails,
                onChanged: (bool? value) {
                  setState(() {
                    _savePaymentDetails = value ?? false;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Confirm Button
              ElevatedButton(
                onPressed: () {
                  // Add payment processing logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 16),

              // Security Information
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.security, size: 20, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    'Secured by SecurePayments™',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodButton(String label, IconData icon, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
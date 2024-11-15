import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

const Color pinkColor = Color.fromARGB(255, 235, 6, 158);
const Color purpleColor = Color.fromARGB(255, 134, 62, 106);
const Color darkBackgroundColor = Color(0xFF1E1E1E);
const Color lightCardColor = Color(0xFF2A2A2A);

class PaiementMarchand extends StatefulWidget {
  @override
  _PaiementMarchandState createState() => _PaiementMarchandState();
}

class _PaiementMarchandState extends State<PaiementMarchand> {
  final TextEditingController _amountController = TextEditingController();
  String? _scannedQrCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: purpleColor,
        title: Text(
          "Paiement Marchand",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        
      ),
      body: Container(
        color: purpleColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildQrCodeSection(),
              SizedBox(height: 24),
              _buildAmountSection(),
              SizedBox(height: 24),
              _buildPayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrCodeSection() {
    return Card(
      color: pinkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter or Scan Merchant Code",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: () {
                  _scanQrCode(context);
                },
                icon: Icon(LucideIcons.camera, color: Colors.black),
                label: Text("Scan QR Code"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
              ),
              SizedBox(height: 14),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _scannedQrCode = value.isNotEmpty ? value : null;
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter merchant code",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              if (_scannedQrCode != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    "Code: $_scannedQrCode",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountSection() {
    return Card(
      color: pinkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Amount to Pay",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "0.00",
                hintStyle: TextStyle(
                  color: Colors.white38,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: Colors.white70,
                  size: 28,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    bool isPaymentReady =
        _scannedQrCode != null && _amountController.text.isNotEmpty;

    return ElevatedButton(
      onPressed: isPaymentReady
          ? () {
              final amountText = _amountController.text;
              if (double.tryParse(amountText) != null) {
                final amount = double.parse(amountText);
                // Call payment processing logic here
              }
            }
          : null,
      child: Text(
        "Payer",
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
    );
  }

  Future<void> _scanQrCode(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QrScannerPage(),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _scannedQrCode = result;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}

class QrScannerPage extends StatefulWidget {
  @override
  _QrScannerPageState createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  String _scannedResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "QR Code Scanner",
          style: TextStyle(
            color: Color.fromARGB(255, 235, 6, 158),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_scannedResult.isEmpty)
              SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: MobileScanner(
                      onDetect: (BarcodeCapture barcode) {
                        final String code =
                            barcode.barcodes.first.rawValue ?? 'Unknown';
                        setState(() {
                          _scannedResult = code;
                        });
                        Navigator.pop(context, _scannedResult);
                      },
                    ),
                  ))
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Scanned QR Code: $_scannedResult",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _scannedResult = "";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Scan Again'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

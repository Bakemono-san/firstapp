import 'package:firstapp/src/Controllers/TransactionsConstroller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _amountController = TextEditingController();
  String? scannedQrCode;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final transactionController =
        Provider.of<TransactionsController>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Paiement Marchand",
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
            // QR Code Section
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2A2A2A),
                    Color(0xFF1A1A1A),
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
                    "Scan Merchant QR Code",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          // Open QR Code scanner
                          await _scanQRCode();
                        },
                        icon: Icon(Icons.qr_code_scanner),
                        label: Text("Scan QR Code"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          scannedQrCode ?? "No QR code scanned",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Amount Input Section
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2A2A2A),
                    Color(0xFF1A1A1A),
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
                    "Amount to Pay",
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

            // Pay Button
            Container(
              
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed:
                    scannedQrCode == null || _amountController.text.isEmpty
                        ? null
                        : () {
                            final amountText = _amountController.text;

                            if (double.tryParse(amountText) != null) {
                              final amount = double.parse(amountText);
                              transactionController.PaiementMarchand(
                                type: "Paiement",
                                date: DateTime.now(),
                                montant: amount,
                                receiverTelephone: scannedQrCode!,
                                context: context,
                              );
                            }
                          },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  "Payer",
                  style: TextStyle(
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

  Future<void> _scanQRCode() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerPage(),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        scannedQrCode = result; // Update the scanned QR code
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}

// class QRViewExample extends StatelessWidget {
//   final Function(String) onScan;

//   QRViewExample({required this.onScan});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: QRView(
//           key: GlobalKey(debugLabel: 'QR'),
//           onQRViewCreated: (QRViewController controller) {
//             controller.scannedDataStream.listen((scanData) {
//               onScan(scanData.code!);
//               controller.dispose();
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String scannedResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanner"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (scannedResult.isEmpty)
              // Wrap with a SizedBox that gives it a definite height
              SizedBox(
                height: 400, // Define a fixed height
                width: double.infinity, // Ensure it takes the full width
                child: MobileScanner(
                  onDetect: (BarcodeCapture barcode) {
                    final String code = barcode.barcodes.first.rawValue ?? 'Unknown';
                    setState(() {
                      scannedResult = code;
                    });

                    // Once a QR code is detected, stop scanning and send back result
                    Navigator.pop(context, scannedResult);
                  },
                ),
              )
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Scanned QR Code: $scannedResult",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        scannedResult = ""; // Reset the result to scan again
                      });
                    },
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

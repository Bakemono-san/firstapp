import 'package:flutter/material.dart';

class QrCodeCard extends StatelessWidget {
  const QrCodeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Image.network(
                "https://res.cloudinary.com/dorovcxxj/image/upload/v1730381604/qr_1_ietpvh.png",
              ),
            ),
          ),
        ));
  }
}

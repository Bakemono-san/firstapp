import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const CardButton({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 150, 0, 117),
        // color: Colors.grey[600],
        gradient: LinearGradient(
          colors: [
          Color(Colors.grey[800]!.value),
          Color(Colors.grey[800]!.value),
          Colors.black,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(29, 255, 255, 255),
            ),
            padding: const EdgeInsets.all(18),
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

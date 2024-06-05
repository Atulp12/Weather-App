import 'package:flutter/material.dart';

class AddInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final String value;
  const AddInfo({super.key, required this.icon, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 8,),
          Text(text),
          const SizedBox(height: 8,),
          Text(value)
        ],
      ),
    );
  }
}
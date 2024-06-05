import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final IconData icon;
  final double temp;
  const HourlyForecast({super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 100,
        child:  Column(
          children: [
            Text(time.toString(), style: const TextStyle(fontSize: 18)),
            const SizedBox(
              height: 10,
            ),
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(temp.toString(), style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

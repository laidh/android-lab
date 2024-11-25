import 'package:flutter/material.dart';

class AboutInfoWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Про себе",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          maxLines: 12,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.blueGrey[50],
          ),
        ),
      ),
    ]);
  }
}

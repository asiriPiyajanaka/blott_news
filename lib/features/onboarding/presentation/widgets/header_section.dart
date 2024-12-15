import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Text(
          "Your legal name",
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 18.0),
        Text(
          "We need to know a bit about you so that we can create your account.",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(height: 2.0),
      ],
    );
  }
}

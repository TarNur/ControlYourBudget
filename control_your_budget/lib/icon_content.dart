import 'package:flutter/material.dart';

const labelTextStyle = TextStyle(
  fontSize: 15.0,
);

class IconContent extends StatelessWidget {
  IconContent({this.icon, this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 40,
        ),
        SizedBox(
          height: 15.0,
          width: double.infinity,
        ),
        Text(
          label,
          style: labelTextStyle,
        )
      ],
    );
  }
}

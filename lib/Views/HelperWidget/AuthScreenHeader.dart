import 'package:flutter/material.dart';

class AuthScreenHeader extends StatelessWidget {

  final String headerText;

  const AuthScreenHeader({
    super.key,
    required this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
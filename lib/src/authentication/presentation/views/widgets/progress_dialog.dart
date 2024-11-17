import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget{
  const ProgressDialog({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 10),
        Text(message)
      ],
    );
  }

}
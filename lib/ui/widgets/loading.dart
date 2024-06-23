import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Center(
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

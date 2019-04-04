import 'package:flutter/material.dart';

class BroLoadingIndicator extends StatelessWidget {
  final bool isDark;

  BroLoadingIndicator({this.isDark = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            isDark ? Colors.black54 : Colors.white70),
      ),
    );
  }
}

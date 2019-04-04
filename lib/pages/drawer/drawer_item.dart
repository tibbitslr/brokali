import 'package:flutter/material.dart';

class BroDrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool pro;

  BroDrawerItem({this.label, this.icon, this.onTap, this.pro = false});

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        pro ? Color(0xFFF9A504) : Color.fromRGBO(0, 0, 0, 0.87);
    final Color iconColor = pro ? Color(0xFFF9A504) : Color(0xFF757575);
    final FontWeight fontWeight = pro ? FontWeight.bold : FontWeight.w500;

    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        label,
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 15,
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
      onTap: onTap,
    );
  }
}

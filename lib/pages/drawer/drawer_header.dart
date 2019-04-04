import 'package:flutter/material.dart';

class BroDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName:
          Text('BroKali Team', style: TextStyle(color: Color(0xFFFFFFFF))),
      accountEmail: Text('team@brokali.com',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.7))),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.jpg'),
      ),
      decoration: BoxDecoration(color: Color(0xFF256600)),
    );
  }
}

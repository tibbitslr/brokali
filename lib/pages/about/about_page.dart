import 'package:flutter/material.dart';

class BroAboutPage extends StatelessWidget {
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    print('about');
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[],
      ),
      body: Center(
        child: Text(
          'About here!',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

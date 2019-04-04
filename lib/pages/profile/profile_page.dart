import 'package:flutter/material.dart';

class BroProfilePage extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _BroProfilePageState createState() => _BroProfilePageState();
}

class _BroProfilePageState extends State<BroProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('profile');
    return Scaffold(
      // use common widget app bar!
      appBar: AppBar(
        title: Text('Profile'),
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
          'Profile here!',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

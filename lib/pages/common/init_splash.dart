import 'package:flutter/material.dart';

import 'package:brokali/platform/_platform.dart' show BroServices;
import 'package:brokali/pages/common/_common.dart';

class BroInitSplash extends StatefulWidget {
  @override
  _BroInitSplashState createState() => _BroInitSplashState();
}

class _BroInitSplashState extends State<BroInitSplash> {
  @override
  void initState() {
    super.initState();

    BroServices.setStatusBarColor(0xFF8FC72E);
  }

  @override
  Widget build(BuildContext context) {
    return BroInitWidget(
      child: Center(
        child: Container(
          height: 120.0,
          width: 120.0,
          child: Image.asset('assets/images/splash.png'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

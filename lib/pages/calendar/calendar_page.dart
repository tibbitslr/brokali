import 'package:flutter/material.dart';

import 'package:brokali/pages/common/_common.dart' show BroComingSoonWidget;

class BroCalendarPage extends StatefulWidget {
  @override
  _BroCalendarPageState createState() => _BroCalendarPageState();
}

class _BroCalendarPageState extends State<BroCalendarPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BroComingSoonWidget(child: Container());
  }

  @override
  void dispose() {
    super.dispose();
  }
}

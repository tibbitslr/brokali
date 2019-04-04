import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:brokali/pages/drawer/_drawer.dart';
import 'package:brokali/pages/stacks/_stacks.dart';
import 'package:brokali/pages/products/_products.dart';
import 'package:brokali/pages/calendar/_calendar.dart';
import 'package:brokali/pages/feeds/_feeds.dart';

import '_home.dart';

class BroHomePage extends StatefulWidget {
  @override
  _BroHomePageState createState() => _BroHomePageState();
}

class _BroHomePageState extends State<BroHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: BroDrawerPage(),
      appBar: BroHomeAppBar(
        openDrawer: () => scaffoldKey.currentState.openDrawer(),
        tabController: tabController,
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          BroStacksPage(),
          BroProductsPage(),
          BroCalendarPage(),
          BroFeedsPage(),
        ],
      ),
      bottomNavigationBar: BroHomeNavigationBar(tabController: tabController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BroHomeAddButton(),
    );
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }
}

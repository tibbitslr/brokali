import 'package:flutter/material.dart';

class BroHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback openDrawer;
  final TabController tabController;

  BroHomeAppBar({this.openDrawer, this.tabController});

  @override
  Size get preferredSize {
    return Size.fromHeight(56.0);
  }

  @override
  _BroHomeAppBarState createState() => _BroHomeAppBarState();
}

class _BroHomeAppBarState extends State<BroHomeAppBar> {
  int index;

  @override
  void initState() {
    super.initState();

    index = widget.tabController.index;
    widget.tabController.addListener(() {
      if (index != widget.tabController.index) {
        setState(() {
          index = widget.tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget title;
    Widget leading;

    switch (index) {
      case 1:
        title = Text('Products');
        leading = null;
        break;
      case 2:
        title = Text('Calendar');
        leading = null;
        break;
      case 3:
        title = Text('Feed');
        leading = null;
        break;

      case 0:
      default:
        title = Container(
          height: 18,
          child: Image.asset(
            'assets/images/brokali3.png',
            fit: BoxFit.fill,
          ),
        );

        leading = IconButton(
          icon: Icon(Icons.menu, color: Color(0xEE2E2E2E)),
          onPressed: () => widget.openDrawer(),
        );
    }

    return AppBar(title: title, leading: leading);
  }
}

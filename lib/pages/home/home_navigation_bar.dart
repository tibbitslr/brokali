import 'package:flutter/material.dart';

class BroHomeNavigationBarItem {
  BroHomeNavigationBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

class BroHomeNavigationBar extends StatefulWidget {
  final TabController tabController;

  final List<BroHomeNavigationBarItem> items = [
    BroHomeNavigationBarItem(
      iconData: Icons.store,
      text: 'Lists',
    ),
    BroHomeNavigationBarItem(
      iconData: Icons.subject,
      text: 'Products',
    ),
    BroHomeNavigationBarItem(
      iconData: Icons.calendar_today,
      text: 'Calendar',
    ),
    BroHomeNavigationBarItem(
      iconData: Icons.notifications,
      text: 'Feed',
    ),
  ];

  BroHomeNavigationBar({this.tabController});

  @override
  State<StatefulWidget> createState() => BroHomeNavigationBarState();
}

class BroHomeNavigationBarState extends State<BroHomeNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(item: widget.items[index], index: index);
    });
    items.insert(
        2, Expanded(child: SizedBox(height: 60.0, child: Container())));

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: Theme.of(context).bottomAppBarColor,
    );
  }

  Widget _buildTabItem({
    BroHomeNavigationBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Widget tabTitle = _selectedIndex == index
        ? Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              item.text,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        : Container();

    return Expanded(
      child: SizedBox(
        height: 60.0,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              widget.tabController.animateTo(index);

              setState(() {
                _selectedIndex = index;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: Colors.white, size: 24.0),
                tabTitle
              ],
            ),
          ),
        ),
      ),
    );
  }
}

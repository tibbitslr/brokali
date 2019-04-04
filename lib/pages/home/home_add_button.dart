import 'package:flutter/material.dart';

import '_home.dart';

class BroHomeAddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        switch (await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return BroHomeAddDialog();
            })) {
          case 'CREATE':
            // Navigator.of(context)
            //     .push(CupertinoPageRoute(builder: (_) => BroListPage()));
            break;
          case 'CANCEL':
            break;
        }
      },
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      elevation: 2.0,
    );
  }
}

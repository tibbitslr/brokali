import 'package:flutter/material.dart';

import 'package:brokali/models/_models.dart' show BroStackModel;

import '_list.dart';

class BroListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BroStackModel stackModel;

  BroListAppBar(this.stackModel);

  @override
  Size get preferredSize {
    return Size.fromHeight(56.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(stackModel.label),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Color(0xFF2E2E2E),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
            color: Color(0xFF2E2E2E),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) => BroSharePopup(stackModel),
            );
          },
        ),
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Color(0xFF2E2E2E),
            ),
            onPressed: () {
              // share
            }),
      ],
    );
  }
}

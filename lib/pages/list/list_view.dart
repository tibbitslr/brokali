import 'package:flutter/material.dart';

import 'package:brokali/models/_models.dart' show BroStackListItemModel;

import '_list.dart';

class BroListView extends StatelessWidget {
  final bool isPurchased;
  final bool showInput;
  final List<BroStackListItemModel> stackList;
  final Function onSelect;
  final Function onDismissed;
  final Function onEditResult;

  BroListView({
    this.isPurchased,
    this.showInput,
    this.stackList,
    this.onDismissed,
    this.onSelect,
    this.onEditResult,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.only(bottom: 68.0),
          physics: showInput ? NeverScrollableScrollPhysics() : ScrollPhysics(),
          itemCount: stackList.length,
          itemBuilder: (context, i) {
            return Dismissible(
              background: Container(
                color: Colors.redAccent,
              ),
              key: Key(stackList[i].id),
              onDismissed: (direction) {
                onDismissed(i);
              },
              child: BroListItem(
                model: stackList[i],
                enabled: !showInput,
                onSelect: onSelect,
              ),
            );
          },
        ),
        isPurchased
            ? Container(
                color: Colors.white30,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'List was purchased!\n',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      FlatButton(
                        color: Colors.green,
                        child: Text('Edit List'),
                        onPressed: onEditResult,
                      )
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

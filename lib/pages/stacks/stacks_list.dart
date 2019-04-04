import 'package:flutter/material.dart';

import 'package:brokali/models/stack_model.dart';

class BroStacksList extends StatelessWidget {
  final BroStackModel model;
  final VoidCallback onTap;

  BroStacksList({this.model, this.onTap}) : super(key: ValueKey(model.id));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: ShapeDecoration(
          color: Color(0xFF256600), //state.model[i].color,
          shape: CircleBorder(),
        ),
        width: 40,
        height: 40,
        child: Icon(
          Icons.fastfood, //state.model[i].icon,
          color: Colors.white,
          size: 22.0,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 2),
              child: Text(
                model.label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Color.fromRGBO(0, 0, 0, 0.87),
                  decoration: model.purchased
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
      subtitle: Text(
        '${model.list.length} items',
        style: TextStyle(color: Colors.grey, fontSize: 14.0),
      ),
      onTap: onTap,
    );
  }
}

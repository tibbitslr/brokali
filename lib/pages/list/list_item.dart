import 'package:flutter/material.dart';

import 'package:brokali/models/_models.dart' show BroStackListItemModel;
import 'package:brokali/utils/_utils.dart' show BroProductUnit;

class BroListItem extends StatelessWidget {
  final BroStackListItemModel model;
  final bool enabled;
  final Function(String id) onSelect;

  BroListItem({
    this.model,
    this.enabled = true,
    this.onSelect,
  }) : super(key: ValueKey(model.id));

  @override
  Widget build(BuildContext context) {
    TextDecoration textDecoration =
        model.purchased ? TextDecoration.lineThrough : TextDecoration.none;
    Color textColor = model.purchased ? Colors.black38 : Colors.black87;
    String package =
        '${model.package}${BroProductUnit.from(model.productUnit)}';

    return ListTile(
      enabled: enabled,
      onTap: () => onSelect(model.id),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 2),
              child: Text(
                model.label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  decoration: textDecoration,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4, right: 16),
            child: Text(
              package,
              style: TextStyle(
                color: textColor,
                decoration: textDecoration,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Text(
            model.qty.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: textColor,
              decoration: textDecoration,
            ),
          )
        ],
      ),
    );
  }
}

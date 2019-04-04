import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/models/_models.dart' show BroFeedModel;
import 'package:brokali/blocs/_blocs.dart'
    show BroFeedsBloc, BroFeedsMarkAsReadEvent, BroFeedsAcceptShareStackEvent;

class BroFeedItem extends StatelessWidget {
  final BroFeedModel data;

  BroFeedItem({this.data});

  @override
  Widget build(BuildContext context) {
    final BroFeedsBloc feedsBloc = BlocProvider.of<BroFeedsBloc>(context);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF8CD0AF),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      padding: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.message,
                  overflow: TextOverflow.visible,
                ),
                data.meta != null ? data.meta.toTextWidget() : Container(),
              ],
            ),
          ),
          Container(
            width: 50,
            child: FlatButton(
              padding: EdgeInsets.all(0.0),
              child: Text('OK'),
              onPressed: () =>
                  feedsBloc.dispatch(BroFeedsAcceptShareStackEvent(feed: data)),
            ),
          ),
          Container(
            width: 30,
            child: FlatButton(
              padding: EdgeInsets.all(0.0),
              child: Icon(
                Icons.close,
                size: 18,
              ),
              onPressed: () =>
                  feedsBloc.dispatch(BroFeedsMarkAsReadEvent(feed: data)),
            ),
          )
        ],
      ),
    );
  }
}

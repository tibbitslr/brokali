import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/_blocs.dart'
    show BroFeedsBloc, BroFeedsPushShareStackEvent;
import 'package:brokali/models/_models.dart' show BroStackModel;

class BroSharePopup extends StatelessWidget {
  final BroStackModel stackModel;

  BroSharePopup(this.stackModel);

  @override
  Widget build(BuildContext context) {
    BroFeedsBloc feedsBloc = BlocProvider.of<BroFeedsBloc>(context);

    return Container(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Add a friend',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF256600),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: FloatingActionButton(
                  mini: true,
                  elevation: 0,
                  heroTag: 'invite_friend',
                  backgroundColor: Color(0xFF256600),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    var email = await Navigator.of(context).popAndPushNamed(
                      '/list_invitation',
                      arguments: stackModel.label,
                    );

                    if (email != null) {
                      feedsBloc.dispatch(BroFeedsPushShareStackEvent(
                        stack: stackModel,
                        withEmail: email,
                      ));
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, top: 4.0),
                child: Text('Invite', style: TextStyle(fontSize: 16)),
              )
            ],
          )
        ],
      ),
    );
  }
}

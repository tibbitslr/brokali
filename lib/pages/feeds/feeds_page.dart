import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/_blocs.dart'
    show BroDataBlocEvent, BroDataBlocState, BroFeedsBloc;
import 'package:brokali/models/_models.dart' show BroFeedModel;
import 'package:brokali/pages/common/_common.dart' show BroLoadingWidget;

import '_feeds.dart';

class BroFeedsPage extends StatefulWidget {
  @override
  _BroFeedsPageState createState() => _BroFeedsPageState();
}

class _BroFeedsPageState extends State<BroFeedsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BroFeedsBloc feedsBloc = BlocProvider.of<BroFeedsBloc>(context);

    return BlocBuilder<BroDataBlocEvent, BroDataBlocState>(
      bloc: feedsBloc,
      builder: (BuildContext context, BroDataBlocState state) {
        List<BroFeedModel> values = state.data.toList<BroFeedModel>();
        values = values.where((value) => !value.isRead()).toList();

        return BroLoadingWidget(
          loading: state.data.loading,
          isEmpty: values.length == 0,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                height: 4.0,
                color: Colors.white,
              );
            },
            padding: EdgeInsets.all(8.0),
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              return BroFeedItem(data: values[index]);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

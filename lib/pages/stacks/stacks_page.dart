import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/_blocs.dart'
    show BroDataBlocEvent, BroDataBlocState, BroStacksBloc;
import 'package:brokali/pages/common/_common.dart' show BroLoadingWidget;

import '_stacks.dart';

class BroStacksPage extends StatefulWidget {
  @override
  _BroStacksPageState createState() => _BroStacksPageState();
}

class _BroStacksPageState extends State<BroStacksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BroStacksBloc stacksBloc = BlocProvider.of<BroStacksBloc>(context);

    return BlocBuilder<BroDataBlocEvent, BroDataBlocState>(
      bloc: stacksBloc,
      builder: (BuildContext context, BroDataBlocState state) {
        List models = state.data.toList();

        return BroLoadingWidget(
          loading: state.data.loading,
          isEmpty: models.length == 0,
          child: ListView.builder(
            itemCount: models.length,
            itemBuilder: (BuildContext context, int index) {
              return BroStacksList(
                model: models[index],
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/list',
                    arguments: models[index],
                  );
                },
              );
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

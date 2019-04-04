import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/_blocs.dart'
    show BroDataBlocEvent, BroDataBlocState, BroProductsBloc;
import 'package:brokali/pages/common/_common.dart' show BroLoadingWidget;

import '_products.dart';

class BroProductsPage extends StatefulWidget {
  @override
  _BroProductsPageState createState() => _BroProductsPageState();
}

class _BroProductsPageState extends State<BroProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BroProductsBloc productsBloc =
        BlocProvider.of<BroProductsBloc>(context);

    return BlocBuilder<BroDataBlocEvent, BroDataBlocState>(
      bloc: productsBloc,
      builder: (BuildContext context, BroDataBlocState state) {
        List values = state.data.toList();

        return BroLoadingWidget(
          loading: state.data.loading,
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemExtent: 40.0,
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              return BroProductItem(model: values[index]);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/data_bloc.dart';
import 'package:brokali/blocs/main_bloc.dart';
import 'package:brokali/blocs/login_bloc.dart';
import 'package:brokali/pages/common/_common.dart'
    show BroInitWidget, BroLoadingWidget;

import '_login.dart';

class BroLoginPage extends StatefulWidget {
  final BroMainBloc mainBloc;

  BroLoginPage(this.mainBloc);

  @override
  _BroLoginPageState createState() => _BroLoginPageState();
}

class _BroLoginPageState extends State<BroLoginPage> {
  BroLoginBloc loginBloc;

  @override
  void initState() {
    super.initState();

    loginBloc = BroLoginBloc(widget.mainBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BroLoginBloc>(
      bloc: loginBloc,
      child: BlocBuilder<BroDataBlocEvent, BroDataBlocState>(
        bloc: loginBloc,
        builder: (BuildContext context, BroDataBlocState state) {
          Widget widget;

          if (state.data.value == BroLoginStep.PREVIW) {
            widget = BroLoginPreviewPage();
          }

          if (state.data.value == BroLoginStep.SIGN_IN) {
            widget = BroLoginSignIn();
          }

          if (state.data.value == BroLoginStep.SIGN_UP) {
            widget = BroLoginSignUp();
          }

          return BroInitWidget(
            child: BroLoadingWidget(
              loading: state.data.loading,
              child: widget,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    loginBloc.dispose();

    super.dispose();
  }
}

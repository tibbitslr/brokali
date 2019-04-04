import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:brokali/blocs/_blocs.dart';
import 'package:brokali/pages/login/_login.dart';
import 'package:brokali/pages/home/_home.dart';
import 'package:brokali/pages/common/_common.dart';

import 'theme.dart';
import 'routes.dart';

class BroBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    // print(transition);
  }
}

Future<void> main() async {
  final Firestore firestore = Firestore();
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  BlocSupervisor().delegate = BroBlocDelegate();

  runApp(BroApp());
}

class BroApp extends StatefulWidget {
  @override
  State<BroApp> createState() => _BroAppState();
}

class _BroAppState extends State<BroApp> {
  List<BlocProvider> providers;
  BroMainBloc mainBloc;

  @override
  void initState() {
    super.initState();

    BroSettingsBloc settingsBloc = BroSettingsBloc();
    BroUserBloc userBloc = BroUserBloc();
    BroProductsBloc productsBloc = BroProductsBloc();
    BroCategoriesBloc categoriesBloc = BroCategoriesBloc();
    BroStacksBloc stacksBloc = BroStacksBloc();
    BroFeedsBloc feedsBloc = BroFeedsBloc(stacksBloc);

    stacksBloc.waitFor([productsBloc]);

    providers = [
      BlocProvider<BroSettingsBloc>(bloc: settingsBloc),
      BlocProvider<BroUserBloc>(bloc: userBloc),
      BlocProvider<BroProductsBloc>(bloc: productsBloc),
      BlocProvider<BroCategoriesBloc>(bloc: categoriesBloc),
      BlocProvider<BroFeedsBloc>(bloc: feedsBloc),
      BlocProvider<BroStacksBloc>(bloc: stacksBloc),
    ];

    mainBloc = BroMainBloc([
      settingsBloc,
      userBloc,
      productsBloc,
      categoriesBloc,
      feedsBloc,
      stacksBloc,
    ]);
    mainBloc.dispatch(BroDataInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: providers + [BlocProvider<BroMainBloc>(bloc: mainBloc)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BroKali',
        theme: broTheme,
        onGenerateRoute: broRoutes,
        home: BlocBuilder<BroDataBlocEvent, BroDataBlocState>(
          bloc: mainBloc,
          builder: (BuildContext context, BroDataBlocState state) {
            if (state.data.value == BroMainStep.INIT) {
              return BroInitSplash();
            }

            if (state.data.value == BroMainStep.LOGIN) {
              return BroLoginPage(mainBloc);
            }

            if (state.data.value == BroMainStep.HOME) {
              return BroHomePage();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    mainBloc.dispose();

    super.dispose();
  }
}

import 'dart:async';

import 'package:brokali/models/_models.dart'
    show BroSettingsModel, BroBaseModelMap;
import 'package:brokali/utils/_utils.dart' show BroError;

import 'data_bloc.dart';

class BroSettingsBloc extends BroDataBloc {
  @override
  BroSettingsState get initialState => BroSettingsState.initial();

  @override
  Stream<BroDataBlocState> mapEventToState(BroDataBlocEvent event) async* {
    if (event is BroDataInitEvent) {
      // BroSettingsModel data = await repo.loadSettings();

      // yield currentState.copyWith(data: event.data, loading: false);
    }
  }
}

// EVENTS

// class BroSettingsEvent extends BroDataBlocEvent {}

// STATE

class BroSettingsState extends BroDataBlocState {
  BroSettingsState({BroDataState data}) : super(data);

  factory BroSettingsState.initial() {
    return BroSettingsState(data: BroDataState({}));
  }

  @override
  BroSettingsState copyWith({BroDataState data}) {
    return BroSettingsState(data: data);
  }
}

import 'dart:async';

import 'package:brokali/repository/_repository.dart' show BroUserProvider;

import 'data_bloc.dart';

class BroUserBloc extends BroDataBloc {
  @override
  BroUserProvider get provider => repo.provider('user');

  @override
  BroUserState get initialState => BroUserState.initial();

  @override
  Stream<BroDataBlocState> mapEventToState(BroDataBlocEvent event) async* {
    if (event is BroDataInitEvent) {
      // yield currentState.copyWith(data: event.data, loading: false);

      // BroUserModel data = await repo.users.loadUserData();
      //     bloc.dispatch(BroDataInitEvent<BroUserModel>(data));
    }
  }
}

// EVENTS

// class BroUserEvent extends BroDataBlocEvent {}

// STATE

class BroUserState extends BroDataBlocState {
  BroUserState({BroDataState data}) : super(data);

  factory BroUserState.initial() {
    return BroUserState(data: BroDataState({}));
  }

  @override
  BroUserState copyWith({BroDataState data}) {
    return BroUserState(data: data);
  }
}

import 'dart:async';

import 'data_bloc.dart';

class BroMainBloc extends BroDataBloc {
  final List<BroDataBloc> blocs;

  BroMainBloc(this.blocs);

  @override
  BroMainState get initialState => BroMainState.initial();

  @override
  Stream<BroDataBlocState> mapEventToState(BroDataBlocEvent event) async* {
    if (event is BroDataInitEvent) {
      await repo.init();

      String uid = await repo.auth.getUserId();
      bool isGuestMode = await repo.pref.isGuestMode();

      if (uid == null && !isGuestMode) {
        yield currentState.copyWith(data: BroDataState(BroMainStep.LOGIN));
      } else {
        blocs.forEach((bloc) => bloc.dispatch(BroDataInitEvent()));
        yield currentState.copyWith(data: BroDataState(BroMainStep.HOME));
      }
    }

    if (event is BroMainHomeEvent) {
      yield currentState.copyWith(data: BroDataState(BroMainStep.HOME));
    }

    if (event is BroMainSignOutEvent) {
      yield currentState.copyWith(data: BroDataState(BroMainStep.LOGIN));
      await repo.auth.signOut();
    }

    if (event is BroMainGuestModeEvent) {
      // await repo.markAsGuestMode();
    }
  }

  @override
  void dispose() {
    this.blocs.forEach((bloc) => bloc.dispose());

    super.dispose();
  }
}

// EVENTS

class BroMainHomeEvent extends BroDataBlocEvent {}

class BroMainSignOutEvent extends BroDataBlocEvent {}

class BroMainGuestModeEvent extends BroDataBlocEvent {}

// STATE

class BroMainState extends BroDataBlocState {
  BroMainState({BroDataState data}) : super(data);

  factory BroMainState.initial() {
    return BroMainState(data: BroDataState(BroMainStep.INIT));
  }

  @override
  BroMainState copyWith({BroDataState data}) {
    return BroMainState(data: data);
  }
}

// ETC

enum BroMainStep {
  INIT,
  LOGIN,
  HOME,
}

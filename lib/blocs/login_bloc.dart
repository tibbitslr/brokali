import 'dart:async';

import 'package:brokali/blocs/_blocs.dart';

import 'data_bloc.dart';

class BroLoginBloc extends BroDataBloc {
  final BroMainBloc mainBloc;

  BroLoginBloc(this.mainBloc);

  @override
  BroLoginState get initialState => BroLoginState.initial();

  @override
  Stream<BroDataBlocState> mapEventToState(BroDataBlocEvent event) async* {
    if (event is BroLoginPreviewEvent) {
      yield currentState.copyWith(data: BroDataState(BroLoginStep.PREVIW));
    }

    if (event is BroLoginSignInEvent) {
      yield currentState.copyWith(data: BroDataState(BroLoginStep.SIGN_IN));
    }

    if (event is BroLoginSignInWithEmailEvent) {
      yield currentState.copyWith(
        data: BroDataState(BroLoginStep.SIGN_IN, loading: true),
      );

      Map data = await repo.auth.signInWithEmail(event.email, event.password);

      if (data['uid'] != null) {
        mainBloc.dispatch(BroMainHomeEvent());
      }
    }

    if (event is BroLoginSignUpEvent) {
      yield currentState.copyWith(data: BroDataState(BroLoginStep.SIGN_UP));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// EVENTS

class BroLoginPreviewEvent extends BroDataBlocEvent {}

class BroLoginSignInEvent extends BroDataBlocEvent {}

class BroLoginSignUpEvent extends BroDataBlocEvent {}

class BroLoginSignInWithEmailEvent extends BroDataBlocEvent {
  final String email;
  final String password;

  BroLoginSignInWithEmailEvent(this.email, this.password);
}

class BroLoginSignUpWithEmailEvent extends BroDataBlocEvent {
  final String name;
  final String email;
  final String password;

  BroLoginSignUpWithEmailEvent(this.name, this.email, this.password);
}

// STATE

class BroLoginState extends BroDataBlocState {
  BroLoginState({BroDataState data}) : super(data);

  factory BroLoginState.initial() {
    return BroLoginState(data: BroDataState(BroLoginStep.PREVIW));
  }

  @override
  BroLoginState copyWith({BroDataState data}) {
    return BroLoginState(data: data);
  }
}

// ETC

enum BroLoginStep {
  PREVIW,
  SIGN_IN,
  SIGN_UP,
}

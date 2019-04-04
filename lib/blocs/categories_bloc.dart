import 'dart:async';

import 'package:brokali/repository/_repository.dart' show BroCategoriesProvider;

import 'data_bloc.dart';

class BroCategoriesBloc extends BroDataBloc {
  @override
  BroCategoriesProvider get provider => repo.provider('categories');

  @override
  BroCategoriesState get initialState => BroCategoriesState.initial();

  @override
  Stream<BroDataBlocState> mapEventToState(BroDataBlocEvent event) async* {
    yield* super.mapEventToState(event);
  }
}

// EVENTS

class BroCategoriesEvent extends BroDataBlocEvent {}

// STATE

class BroCategoriesState extends BroDataBlocState {
  BroCategoriesState({BroDataState data}) : super(data);

  factory BroCategoriesState.initial() {
    return BroCategoriesState(data: BroDataState({}));
  }

  @override
  BroCategoriesState copyWith({BroDataState data}) {
    return BroCategoriesState(data: data);
  }
}

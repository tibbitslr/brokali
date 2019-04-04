import 'dart:async';

import 'package:brokali/repository/_repository.dart' show BroProductsProvider;

import 'data_bloc.dart';

class BroProductsBloc extends BroDataBloc {
  @override
  BroProductsProvider get provider => repo.provider('products');

  @override
  BroProductsState get initialState => BroProductsState.initial();

  @override
  Stream<BroDataBlocState> mapEventToState(BroDataBlocEvent event) async* {
    yield* super.mapEventToState(event);
  }
}

// EVENTS

// class BroProductsEvent extends BroDataBlocEvent {}

// STATE

class BroProductsState extends BroDataBlocState {
  BroProductsState({BroDataState data}) : super(data);

  factory BroProductsState.initial() {
    return BroProductsState(data: BroDataState({}));
  }

  @override
  BroProductsState copyWith({BroDataState data}) {
    return BroProductsState(data: data);
  }
}

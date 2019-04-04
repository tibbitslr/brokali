import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:brokali/repository/_repository.dart'
    show BroRepository, BroBaseProvider;
import 'package:brokali/utils/_utils.dart' show BroError;

abstract class BroDataBloc extends Bloc<BroDataBlocEvent, BroDataBlocState> {
  final BroRepository repo;
  final List<Future> _waitFor;
  final Completer completed;

  BroDataBloc()
      : _waitFor = [],
        completed = Completer(),
        repo = BroRepository.get();

  BroBaseProvider get provider => null;

  Future<void> waitFor(List<BroDataBloc> blocs) async {
    blocs.forEach((bloc) => _waitFor.add(bloc.completed.future));
  }

  @override
  Stream<BroDataBlocState> mapEventToState(BroDataBlocEvent event) async* {
    if (event is BroDataInitEvent) {
      // TODO refactor null value
      yield currentState.copyWith(data: BroDataState({}, loading: true));

      await Future.wait(_waitFor);
      dynamic data = await provider?.loadAll();

      yield currentState.copyWith(data: BroDataState(data, loading: false));

      completed.complete();
    }
  }

  T getDataValue<T>() => currentState.data.value as T;
  // T findDataItemInMapById<T>(String id) {
  //   dynamic value = getDataValue();
  //   return value is Map ? value[id] : null;
  // }
  // BroDataState updateDataItemInMap(Map item) {
  //   dynamic value = getDataValue();
  //   if (value is Map) {
  //     currentState.data.value = (value as Map)
  //   }

  //   return null;
  // }
}

// EVENTS

@immutable
abstract class BroDataBlocEvent extends Equatable {}

class BroDataInitEvent extends BroDataBlocEvent {}

// STATE

@immutable
abstract class BroDataBlocState {
  final BroDataState data;

  BroDataBlocState(this.data);

  BroDataBlocState copyWith({BroDataState data});
}

// DATA

@immutable
class BroDataState {
  final dynamic value;
  final bool loading;
  final BroError error;

  BroDataState(this.value, {this.loading = false, this.error});

  List<T> toList<T>() {
    if (value is Map) {
      return (value.values ?? []).toList();
    } else if (value is List) {
      return value;
    }

    return [];
  }
}

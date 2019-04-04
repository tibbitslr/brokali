import 'dart:async';

import 'package:brokali/repository/_repository.dart'
    show BroStacksProvider, BroUserProvider;
import 'package:brokali/models/_models.dart' show BroStackModel;

import 'data_bloc.dart';

class BroStacksBloc extends BroDataBloc {
  @override
  BroStacksProvider get provider => repo.provider('stacks');

  @override
  BroStacksState get initialState => BroStacksState.initial();

  @override
  Stream<BroDataBlocState> mapEventToState(BroDataBlocEvent event) async* {
    yield* super.mapEventToState(event);

    if (event is BroStacksCreateEvent) {
      String userEmail = repo.provider<BroUserProvider>('user').getUser().email;
      BroStackModel stack = BroStackModel.fromJSON({
        'label': event.name,
        'emails': [userEmail],
        'list': [],
        'comments': [],
      });

      provider.add(stack);

      Map value = getDataValue();
      // TODO refactor ID
      value[DateTime.now().millisecondsSinceEpoch.toString()] = stack;
      yield currentState.copyWith(data: BroDataState(value));
    }

    if (event is BroStacksAddToDataEvent) {
      Map value = getDataValue();
      value[event.stack.id] = event.stack;
      yield currentState.copyWith(data: BroDataState(value));
    }

    if (event is BroStacksAddToRepoEvent) {
      provider.add(event.stack);
    }

    if (event is BroStacksUpdateInDataEvent) {
      Map value = getDataValue();
      value[event.stack.id] = event.stack;
      yield currentState.copyWith(data: BroDataState(value));
    }

    if (event is BroStacksUpdateInRepoEvent) {
      provider.update(event.stack);
    }
  }
}

// EVENTS

class BroStacksCreateEvent extends BroDataBlocEvent {
  final String name;

  BroStacksCreateEvent({this.name});
}

class BroStacksAddToDataEvent extends BroDataBlocEvent {
  final BroStackModel stack;

  BroStacksAddToDataEvent({this.stack});
}

class BroStacksAddToRepoEvent extends BroDataBlocEvent {
  final BroStackModel stack;

  BroStacksAddToRepoEvent({this.stack});
}

class BroStacksUpdateInDataEvent extends BroDataBlocEvent {
  final BroStackModel stack;

  BroStacksUpdateInDataEvent({this.stack});
}

class BroStacksUpdateInRepoEvent extends BroDataBlocEvent {
  final BroStackModel stack;

  BroStacksUpdateInRepoEvent({this.stack});
}

// STATE

class BroStacksState extends BroDataBlocState {
  BroStacksState({BroDataState data}) : super(data);

  factory BroStacksState.initial() {
    return BroStacksState(data: BroDataState({}));
  }

  @override
  BroStacksState copyWith({BroDataState data}) {
    return BroStacksState(data: data);
  }
}

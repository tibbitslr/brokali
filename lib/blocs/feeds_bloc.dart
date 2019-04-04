import 'dart:async';

import 'package:brokali/models/feed_model.dart';
import 'package:brokali/models/stack_model.dart';
import 'package:brokali/blocs/_blocs.dart'
    show BroStacksBloc, BroStacksAddToDataEvent, BroStacksUpdateInRepoEvent;
import 'package:brokali/repository/_repository.dart'
    show BroFeedsProvider, BroUserProvider, BroStacksProvider;

import 'data_bloc.dart';

class BroFeedsBloc extends BroDataBloc {
  final BroStacksBloc stacksBloc;

  BroFeedsBloc(this.stacksBloc) : super();

  @override
  BroFeedsProvider get provider => repo.provider('feeds');

  @override
  BroFeedsState get initialState => BroFeedsState.initial();

  @override
  Stream<BroDataBlocState> mapEventToState(BroDataBlocEvent event) async* {
    yield* super.mapEventToState(event);

    String userEmail = repo.provider<BroUserProvider>('user').getUser().email;

    if (event is BroFeedsPushShareStackEvent) {
      BroFeedModel feed = BroFeedModel.fromJSON({
        'type': BroFeedModel.SHARE_STACK,
        'message': 'Hello! I want to share my list with you.',
        'date': DateTime.now(),
        'email': event.withEmail,
        'meta': {
          'fromEmail': userEmail,
          'stackId': event.stack.id,
          'stackLabel': event.stack.label,
        }
      });

      provider.add(feed);
    }

    if (event is BroFeedsAcceptShareStackEvent) {
      BroFeedMetaModelShareStack meta = event.feed.meta;

      BroStackModel stack = await repo
          .provider<BroStacksProvider>('stacks')
          .findById(meta.stackId);

      if (stack != null) {
        stack.data['emails'] = stack.emails + [userEmail];
        stacksBloc.dispatch(BroStacksAddToDataEvent(stack: stack));
        stacksBloc.dispatch(BroStacksUpdateInRepoEvent(stack: stack));
      }
    }

    if (event is BroFeedsMarkAsReadEvent) {
      Map<String, BroFeedModel> value =
          getDataValue<Map<String, BroFeedModel>>();

      if (value[event.feed.id] != null) {
        value[event.feed.id].markAsRead();

        provider.update(value[event.feed.id]);
        yield currentState.copyWith(data: BroDataState(value));
      }
    }
  }
}

// EVENTS

class BroFeedsMarkAsReadEvent extends BroDataBlocEvent {
  final BroFeedModel feed;

  BroFeedsMarkAsReadEvent({this.feed});
}

class BroFeedsAcceptShareStackEvent extends BroFeedsMarkAsReadEvent {
  BroFeedsAcceptShareStackEvent({BroFeedModel feed}) : super(feed: feed);
}

class BroFeedsPushShareStackEvent extends BroDataBlocEvent {
  final BroStackModel stack;
  final String withEmail;

  BroFeedsPushShareStackEvent({this.stack, this.withEmail});
}

// STATE

class BroFeedsState extends BroDataBlocState {
  BroFeedsState({BroDataState data}) : super(data);

  factory BroFeedsState.initial() {
    return BroFeedsState(data: BroDataState({}));
  }

  @override
  BroFeedsState copyWith({BroDataState data}) {
    return BroFeedsState(data: data);
  }
}

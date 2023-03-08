import 'package:counter_app_with_selective_rebuild/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduced_riverpod/reduced_riverpod.dart';
import 'transformer.dart';

final stateProvider = StateNotifierProvider(
  (ref) => ReducedStateNotifier(
    MyAppState(
      title: 'reduced_riverpod example',
    ),
  ),
);

final myHomePagePropsProvider = StateProvider(
  (ref) {
    final stateNotifier = ref.watch(stateProvider.notifier);
    return ref.watch(
      stateProvider.select(
        (state) => transformMyHomePageProps(stateNotifier),
      ),
    );
  },
);

final myCounterWidgetPropsProvider = StateProvider(
  (ref) {
    final stateNotifier = ref.watch(stateProvider.notifier);
    return ref.watch(
      stateProvider.select(
        (state) => transformMyCounterWidgetProps(stateNotifier),
      ),
    );
  },
);

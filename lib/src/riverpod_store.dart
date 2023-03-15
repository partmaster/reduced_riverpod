// riverpod_store.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduced/reduced.dart';

/// Derivation of the class [StateNotifier] with support of the [ReducedStore] interface.
class ReducedStateNotifier<S> extends StateNotifier<S>
    implements Store<S> {
  ReducedStateNotifier(super.state);

  @override
  get state => super.state;

  @override
  process(event) => state = event(state);
}

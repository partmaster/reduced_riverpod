// riverpod_reducible.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduced/reduced.dart';

/// Derivation of the class [StateNotifier] with support of the [Reducible] interface.
class ReducibleStateNotifier<S> extends StateNotifier<S>
    implements Reducible<S> {
  ReducibleStateNotifier(super.state);

  @override
  get state => super.state;

  @override
  reduce(reducer) => state = reducer(state);
}

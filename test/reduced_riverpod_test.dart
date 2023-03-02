import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/reduced.dart';

import 'package:reduced_riverpod/reduced_riverpod.dart';

class Incrementer extends Reducer<int> {
  @override
  call(state) => state + 1;
}

void main() {
  test('ReducibleStateNotifier state 0', () {
    final objectUnderTest = ReducibleStateNotifier(0);
    expect(objectUnderTest.state, 0);
  });

  test('ReducibleStateNotifier state 1', () {
    final objectUnderTest = ReducibleStateNotifier(1);
    expect(objectUnderTest.state, 1);
  });

  test('ReducibleStateNotifier reduce', () async {
    final objectUnderTest = ReducibleStateNotifier(0);
    objectUnderTest.reduce(Incrementer());
    expect(objectUnderTest.state, 1);
  });

  test('wrapWithConsumer', () {
    final stateProvider = StateNotifierProvider(
      (ref) => ReducibleStateNotifier(0),
    );
    final propsProvider = StateProvider(
      (ref) {
        final stateNotifier = ref.watch(stateProvider.notifier);
        return ref.watch(
          stateProvider.select((state) => stateNotifier.state),
        );
      },
    );
    const child = SizedBox();
    final objectUnderTest = wrapWithConsumer(
      builder: ({Key? key, required int props}) => child,
      provider: propsProvider,
    );
    expect(objectUnderTest, isA<Consumer>());
  });
}

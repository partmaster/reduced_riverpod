import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/reduced.dart';

import 'package:reduced_riverpod/reduced_riverpod.dart';

class CounterIncremented extends Event<int> {
  @override
  call(state) => state + 1;
}

void main() {
  test('ReducedStateNotifier state 0', () {
    final objectUnderTest = ReducedStateNotifier(0);
    expect(objectUnderTest.state, 0);
  });

  test('ReducedStateNotifier state 1', () {
    final objectUnderTest = ReducedStateNotifier(1);
    expect(objectUnderTest.state, 1);
  });

  test('ReducedStateNotifier reduce', () async {
    final objectUnderTest = ReducedStateNotifier(0);
    objectUnderTest.dispatch(CounterIncremented());
    expect(objectUnderTest.state, 1);
  });
}

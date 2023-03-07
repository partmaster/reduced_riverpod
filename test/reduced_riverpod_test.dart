import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/reduced.dart';

import 'package:reduced_riverpod/reduced_riverpod.dart';

class Incrementer extends Reducer<int> {
  @override
  call(state) => state + 1;
}

void main() {
  test('ReducibleStateNotifier state 0', () {
    final objectUnderTest = ReducedStateNotifier(0);
    expect(objectUnderTest.state, 0);
  });

  test('ReducibleStateNotifier state 1', () {
    final objectUnderTest = ReducedStateNotifier(1);
    expect(objectUnderTest.state, 1);
  });

  test('ReducibleStateNotifier reduce', () async {
    final objectUnderTest = ReducedStateNotifier(0);
    objectUnderTest.reduce(Incrementer());
    expect(objectUnderTest.state, 1);
  });
}

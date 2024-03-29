// main.dart

import 'package:flutter/material.dart';
import 'package:reduced_riverpod/reduced_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ReducedScope(
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: ReducedConsumer(
            provider: propsProvider,
            builder: MyHomePage.new,
          ),
        ),
      );
}

final stateProvider = StateNotifierProvider(
  (ref) => ReducedStateNotifier(0),
);

final propsProvider = StateProvider(
  (ref) {
    final stateNotifier = ref.watch(stateProvider.notifier);
    return ref.watch(
      stateProvider.select(
        (state) => PropsMapper(
          stateNotifier.state,
          stateNotifier,
        ),
      ),
    );
  },
);

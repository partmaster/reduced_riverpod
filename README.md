![GitHub release (latest by date)](https://img.shields.io/github/v/release/partmaster/reduced_riverpod)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/partmaster/reduced_riverpod/dart.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/partmaster/reduced_riverpod)
![GitHub last commit](https://img.shields.io/github/last-commit/partmaster/reduced_riverpod)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/partmaster/reduced_riverpod)
# reduced_riverpod

Implementation of the 'reduced' API for the 'Riverpod' state management framework with following features:

1. Implementation of the ```Store``` interface 
2. Add a state management scope.
3. Trigger a rebuild on widgets selectively after a state change.

## Features

#### 1. Implementation of the ```Store``` interface 

```dart
class ReducedStateNotifier<S> extends StateNotifier<S>
    implements Store<S> {
  ReducedStateNotifier(super.state);

  @override
  get state => super.state;

  @override
  process(event) => state = event(state);
}
```

#### 2. Add a state management scope.

```dart
typedef ReducedScope = ProviderScope;
```

#### 3. Trigger a rebuild on widgets selectively after a state change.

```dart
class ReducedConsumer<P> extends StatelessWidget {
  const ReducedConsumer({
    super.key,
    required this.provider,
    required this.builder,
  });

  final StateProvider<P> provider;
  final WidgetFromPropsBuilder<P> builder;

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (_, ref, __) => builder(props: ref.watch(provider)),
      );
}
```

## Getting started

In the pubspec.yaml add dependencies on the package 'reduced' and on the package  'reduced_riverpod'.

```
dependencies:
  reduced: 0.4.0
  reduced_riverpod: 
    git:
      url: https://github.com/partmaster/reduced_riverpod.git
      ref: v0.4.0
  reduced_riverpod: ^0.1.0
  flutter_riverpod: ^2.2.0
```

Import package 'reduced' to implement the logic.

```dart
import 'package:reduced/reduced.dart';
```

Import package 'reduced' to use the logic.

```dart
import 'package:reduced_riverpod/reduced_riverpod.dart';
```

## Usage

Implementation of the counter demo app logic with the 'reduced' API without further dependencies on state management packages.

```dart
// logic.dart

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/callbacks.dart';

class CounterIncremented extends Event<int> {
  @override
  int call(int state) => state + 1;
}

class Props {
  const Props({required this.counterText, required this.onPressed});

  final String counterText;
  final VoidCallable onPressed;
}

class PropsMapper extends Props {
  PropsMapper(int state, EventProcessor<int> processor)
      : super(
          counterText: '$state',
          onPressed: EventCarrier(processor, CounterIncremented()),
        );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.props});

  final Props props;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('reduced_setstate example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(props.counterText),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: props.onPressed,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
```

Finished counter demo app using logic.dart and 'reduced_riverpod' package:

```dart
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
      stateProvider.select((state) => PropsMapper(stateNotifier.state, stateNotifier,),),
    );
  },
);
```

# Additional information

Implementations of the 'reduced' API are available for the following state management frameworks:

|framework|implementation package for 'reduced' API|
|---|---|
|[Binder](https://pub.dev/packages/binder)|[reduced_binder](https://github.com/partmaster/reduced_binder)|
|[Bloc](https://bloclibrary.dev/#/)|[reduced_bloc](https://github.com/partmaster/reduced_bloc)|
|[FlutterCommand](https://pub.dev/packages/flutter_command)|[reduced_fluttercommand](https://github.com/partmaster/reduced_fluttercommand)|
|[FlutterTriple](https://pub.dev/packages/flutter_triple)|[reduced_fluttertriple](https://github.com/partmaster/reduced_fluttertriple)|
|[GetIt](https://pub.dev/packages/get_it)|[reduced_getit](https://github.com/partmaster/reduced_getit)|
|[GetX](https://pub.dev/packages/get)|[reduced_getx](https://github.com/partmaster/reduced_getx)|
|[MobX](https://pub.dev/packages/mobx)|[reduced_mobx](https://github.com/partmaster/reduced_mobx)|
|[Provider](https://pub.dev/packages/provider)|[reduced_provider](https://github.com/partmaster/reduced_provider)|
|[Redux](https://pub.dev/packages/redux)|[reduced_redux](https://github.com/partmaster/reduced_redux)|
|[Riverpod](https://riverpod.dev/)|[reduced_riverpod](https://github.com/partmaster/reduced_riverpod)|
|[Solidart](https://pub.dev/packages/solidart)|[reduced_solidart](https://github.com/partmaster/reduced_solidart)|
|[StatesRebuilder](https://pub.dev/packages/states_rebuilder)|[reduced_statesrebuilder](https://github.com/partmaster/reduced_statesrebuilder)|

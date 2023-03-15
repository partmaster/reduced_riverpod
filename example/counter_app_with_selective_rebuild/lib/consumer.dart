// consumer.dart

import 'package:counter_app_with_selective_rebuild/state.dart';
import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_riverpod/reduced_riverpod.dart';

import 'props.dart';
import 'provider.dart';

class MyHomePagePropsConsumer extends StatelessWidget {
  const MyHomePagePropsConsumer({
    super.key,
    required this.builder,
  });

  final WidgetFromPropsBuilder<MyHomePageProps> builder;

  @override
  Widget build(BuildContext context) => ReducedConsumer(
        provider: myHomePagePropsProvider,
        builder: builder,
      );
}

class MyCounterWidgetPropsConsumer extends StatelessWidget {
  const MyCounterWidgetPropsConsumer({
    super.key,
    required this.builder,
  });

  final WidgetFromPropsBuilder<MyCounterWidgetProps> builder;

  @override
  Widget build(context) => ReducedConsumer(
        provider: myCounterWidgetPropsProvider,
        builder: builder,
      );
}

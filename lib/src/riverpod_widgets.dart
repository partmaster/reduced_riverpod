// riverpod_widgets.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduced/reduced.dart';

typedef ReducedScope = ProviderScope;

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

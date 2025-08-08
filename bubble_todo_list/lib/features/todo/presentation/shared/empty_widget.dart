import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyWidget extends ConsumerWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body:  Center(
        child: Text('空空如也~', style:Theme.of(context).textTheme.headlineLarge),
      )
    );
  }
}
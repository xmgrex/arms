import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import 'common_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
    this.loading,
  }) : super(key: key);
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function()? loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) {
        logger.warning(e.toString());
        return Center(child: ErrorMessageWidget(e.toString()));
      },
      loading: loading ?? () => const LoadingWidget(),
    );
  }
}


import 'package:arms/src/common_widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:x_kit/x_kit.dart';

class EditDisplayNameScreen extends ConsumerWidget {
  const EditDisplayNameScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: backPageButton(context: context),
        title: const Text('Edit name'),
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(Sizes.p16),
            child: EditableUserDisplayName(),
          )
        ],
      ),
    );
  }
}

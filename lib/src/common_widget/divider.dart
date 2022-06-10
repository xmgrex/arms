import 'package:flutter/material.dart';

Divider divider(BuildContext context, {double? height}) {
  return Divider(color: Theme.of(context).colorScheme.outline, height: height);
}
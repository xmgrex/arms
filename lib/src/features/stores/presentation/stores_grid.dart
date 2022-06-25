import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'store_avatar.dart';


class StoresGrid extends ConsumerStatefulWidget {
  const StoresGrid({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _StoresGridState();
}

class _StoresGridState extends ConsumerState<StoresGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (_, int index) {
        return const StoreAvatar();
      },
    );
  }
}

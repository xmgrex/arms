import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: Theme.of(context).colorScheme.primary,
        secondRingColor: Theme.of(context).colorScheme.primary.withOpacity(.7),
        thirdRingColor: Theme.of(context).colorScheme.primary.withOpacity(.5),
        size: 40,
      ),
    );
    // return Center(
    //   child: LoadingAnimationWidget.fourRotatingDots(
    //     color: Theme.of(context).colorScheme.onBackground,
    //     size: 40,
    //   ),
    // );
  }
}

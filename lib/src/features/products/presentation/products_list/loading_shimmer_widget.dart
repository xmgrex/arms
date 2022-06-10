import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:x_kit/x_kit.dart';

const size = 100.0;

class LoadingShimmerWidget extends StatelessWidget {
  const LoadingShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 144,
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 800),
        highlightColor: colorScheme.primary,
        baseColor: colorScheme.primaryContainer,
        child: LiveList(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (c, index, _) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: Sizes.p16, bottom: Sizes.p12),
              child: SizedBox(
                width: size,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                          color: colorScheme.outline,
                          borderRadius: BorderRadius.circular(Sizes.p8)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Container(
                        width: size,
                        height: 20.0,
                        decoration: BoxDecoration(
                            color: colorScheme.outline,
                            borderRadius: BorderRadius.circular(Sizes.p8)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

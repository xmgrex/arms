import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/size_config.dart';

const imageSize = 100.0;
const height = 100.0;


class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRatio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => context.pushNamed(
            AppRoute.productScreen.name,
            extra: product,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child:
                // Card(
                //   margin: EdgeInsets.zero,
                //   elevation: 2.0,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: Image.asset(product.imageUrl),
                // ),
                Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(product.imageUrl),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ProductCard extends ConsumerWidget {
//   const ProductCard(
//       {Key? key, required this.product, this.isElevationEnabled = false})
//       : super(key: key);
//
//   final Product product;
//   final bool isElevationEnabled;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
//       child: GestureDetector(
//         onTap: () {
//           context.pushNamed(
//             AppRoute.productScreen.name,
//             extra: product,
//           );
//         },
//         child: isElevationEnabled
//             ? Card(
//                 margin: EdgeInsets.zero,
//                 child: Container(
//                   color: Theme.of(context).colorScheme.surface,
//                   width: imageSize,
//                   child: _ImageAndText(product: product),
//                 ),
//               )
//             : SizedBox(
//                 width: imageSize,
//                 child: _ImageAndText(product: product, radius: 8.0)),
//       ),
//     );
//   }
// }
//
// class _ImageAndText extends StatelessWidget {
//   const _ImageAndText({
//     Key? key,
//     required this.product,
//     this.radius = 0.0,
//   }) : super(key: key);
//
//   final Product product;
//   final double radius;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ImageFromUrl(
//           radius: radius,
//           imageUrl: product.imageUrl,
//           width: imageSize,
//           height: imageSize,
//         ),
//         Padding(
//           padding: const EdgeInsets.all(6.0),
//           child: Text(
//             product.name,
//             style: TextStyles.label.large,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }

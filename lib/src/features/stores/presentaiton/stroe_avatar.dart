import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

const imageSize = 71.0;

class StoreAvatar extends StatelessWidget {
  const StoreAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO StoreProductsList
      },
      child: SizedBox(
        height: 87,
        width: 71,
        child: Column(
          children: [
            const ImageFromUrl(
              imageUrl: '',
              height: imageSize,
              width: imageSize,
              radius: Sizes.p48,
            ),
            SizedBox(
              width: 71,
              child: Text(
                'セブンイレブン',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.body.small,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

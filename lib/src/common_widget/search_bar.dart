import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

import '../constants/constants.dart';
import '../utils/size_config.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {this.onSearch,
      this.hint,
      this.hintStyle,
      this.controller,
      this.clear,
      this.fillColor,
      this.radius,
      this.padding,
      Key? key})
      : super(key: key);

  final ValueChanged<String>? onSearch;
  final VoidCallback? clear;
  final TextEditingController? controller;
  final String? hint;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final double? radius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Container(
        height: 44.0,
        width: SizeConfig.screenWidth * 0.8,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: TextField(
            cursorColor: Colors.blueAccent,
            onChanged: onSearch,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(8),
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: 'Search product',
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _clear() {
    controller!.clear();
  }
}

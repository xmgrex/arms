import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

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
      child: SizedBox(
        height: 40,
        child: TextField(
          onChanged: onSearch,
          maxLines: 1,
          controller: controller,
          style: TextStyles.body,
          autofocus: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
            isDense: true,
            contentPadding: const EdgeInsets.all(4),
            hintText: hint,
            hintStyle: hintStyle ?? TextStyles.body.grey,
            border: OutlineInputBorder(
              // gapPadding: 0,
              borderRadius: BorderRadius.circular(radius ?? Sizes.p4),
              borderSide: BorderSide.none,
            ),
            //非選択中のBorder//
            enabledBorder: OutlineInputBorder(
              // gapPadding: 0,
              borderRadius: BorderRadius.circular(radius ?? Sizes.p4),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(XIcons.search),
            suffixIcon: IconButton(
              iconSize: Sizes.p16,
              icon: const Icon(Icons.clear),
              onPressed: clear ?? _clear,
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

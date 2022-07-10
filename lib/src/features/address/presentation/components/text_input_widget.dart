import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.label,
    required this.textEditingController,
    this.hint,
    this.keyboardType,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  final String label;
  final String? hint;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.p8,
        horizontal: Sizes.p16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyles.title),
          TextFormField(
            initialValue: initialValue,
            validator: validator,
            maxLines: 1,
            keyboardType: keyboardType,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
              border: InputBorder.none,
              filled: true,
              fillColor: Theme.of(context).colorScheme.outline.withOpacity(.18)
            ),
          ),
        ],
      ),
    );
  }
}

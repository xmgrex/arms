
import 'package:country_state_city_picker/japan_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

class SelectStateWidget extends StatelessWidget {
  const SelectStateWidget({
    Key? key,
    required this.onStateChanged,
    required this.onCityChanged,
    this.initialState,
    this.initialCity,
  }) : super(key: key);

  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;
  final String? initialState;
  final String? initialCity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Country/State/City', style: TextStyles.title),
          SelectJapanState(
            initialState: initialState,
            initialCity: initialCity,
            spacing: Sizes.p24,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            onStateChanged: (value) => onStateChanged(value.name!),
            onCityChanged: (value) => onCityChanged(value.city),
          ),
        ],
      ),
    );
  }
}


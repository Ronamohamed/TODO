import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class DropdownFormField extends StatelessWidget {
  final String? hintText;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  const DropdownFormField(
      {this.hintText,
      this.value,
      required this.items,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfiguresProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          isDense: true,
          iconEnabledColor: MyTheme.primaryColor,
          borderRadius: BorderRadius.circular(20),
          dropdownColor: (appConfigProvider.currentMode == ThemeMode.light)
              ? MyTheme.whiteColor
              : MyTheme.petrolColor,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyTheme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyTheme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            hintText: hintText,
            hintStyle: (appConfigProvider.currentMode == ThemeMode.light)
                ? Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 16)
                : Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: MyTheme.primaryColor, fontSize: 16),
            filled: true,
            fillColor: (appConfigProvider.currentMode == ThemeMode.light)
                ? MyTheme.whiteColor
                : MyTheme.petrolColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
          ),
          items: items,
          value: value,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class TaskTextFormField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final int? maxLines;

  const TaskTextFormField(
      {this.initialValue,
      this.controller,
      this.onChanged,
      this.validator,
      this.hintText,
      this.maxLines = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfiguresProvider>(context);

    return TextFormField(
      style: Theme.of(context).textTheme.titleMedium,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: (appConfigProvider.currentMode == ThemeMode.light)
                  ? MyTheme.greyLightColor
                  : MyTheme.greyDarkColor),
          contentPadding: const EdgeInsets.only(top: 10),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          )),
    );
  }
}

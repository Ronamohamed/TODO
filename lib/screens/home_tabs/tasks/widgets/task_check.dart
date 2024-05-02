import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class TaskCheck extends StatelessWidget {
  const TaskCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: MyTheme.primaryColor, borderRadius: BorderRadius.circular(12)),
      child: ImageIcon(
        const AssetImage("assets/images/icon_check.png"),
        color: MyTheme.whiteColor,
      ),
    );
  }
}

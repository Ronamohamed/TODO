import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class CircleElevatedButton extends StatelessWidget {
  final void Function() onPressed;

  const CircleElevatedButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfiguresProvider>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyTheme.primaryColor,
        elevation: 50,
        shadowColor: MyTheme.petrolColor,
        shape: CircleBorder(
          side: BorderSide(
            width: 5,
            color: (appConfigProvider.currentMode == ThemeMode.light)
                ? MyTheme.whiteColor
                : MyTheme.petrolColor,
          ),
        ),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: onPressed,
      child: ImageIcon(
        const AssetImage(
          "assets/images/icon_check.png",
        ),
        color: MyTheme.whiteColor,
      ),
    );
  }
}

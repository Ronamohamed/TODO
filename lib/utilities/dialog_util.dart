import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class DialogUtils {
  static void showLoading(BuildContext context, {required String message}) {
    var appConfigProvider =
        Provider.of<AppConfiguresProvider>(context, listen: false);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: (appConfigProvider.currentMode == ThemeMode.light)
            ? MyTheme.whiteColor
            : MyTheme.petrolColor,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 20,
            ),
            Text(message)
          ],
        ),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context,
      {required String? title,
      required String content,
      String? posActionName,
      TextStyle? posActionNameStyle,
      Function? posAction,
      String? negActionName,
      Function? negAction,
      TextStyle? negActionNameStyle}) {
    List<Widget> actions = [];
    var appConfigProvider =
        Provider.of<AppConfiguresProvider>(context, listen: false);

    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call(); // excute the [posAction] if it != null
          },
          child: Text(
            posActionName,
            style: posActionNameStyle,
          )));
      if (negActionName != null) {
        actions.add(TextButton(
            onPressed: () {
              Navigator.pop(context);
              negAction?.call(); // excute the [negAction] if it != null
            },
            child: Text(
              negActionName,
              style: negActionNameStyle,
            )));
      }
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: (appConfigProvider.currentMode == ThemeMode.light)
            ? MyTheme.whiteColor
            : MyTheme.petrolColor,
        title: Text(
          title ?? "",
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: actions,
      ),
    );
  }
}

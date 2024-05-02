import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const AuthButton({required this.title, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
            foregroundColor: MyTheme.whiteColor,
            backgroundColor: MyTheme.primaryColor,
            textStyle:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
        onPressed: onPressed,
        child: Text(title));
  }
}

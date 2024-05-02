import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/screens/home_tabs/settings/widgets/dropdown_formfield.dart';

///localization_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfiguresProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          DropdownFormField(
              hintText: (appConfigProvider.currentLanguage == 'en')
                  ? AppLocalizations.of(context)!.english
                  : AppLocalizations.of(context)!.arabic,
              value: (appConfigProvider.currentLanguage == 'en')
                  ? "English"
                  : "Arabic",
              items: [
                DropdownMenuItem(
                    value: "English",
                    child: Text(
                      AppLocalizations.of(context)!.english,
                      style: (appConfigProvider.currentMode == ThemeMode.light)
                          ? Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 16)
                          : Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: MyTheme.primaryColor, fontSize: 16),
                    )),
                DropdownMenuItem(
                    value: "Arabic",
                    child: Text(
                      AppLocalizations.of(context)!.arabic,
                      style: (appConfigProvider.currentMode == ThemeMode.light)
                          ? Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 16)
                          : Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: MyTheme.primaryColor, fontSize: 16),
                    ))
              ],
              onChanged: (newValue) {
                if (newValue == "English") {
                  appConfigProvider.changeAppLanguage("en");
                } else {
                  appConfigProvider.changeAppLanguage("ar");
                }
              }),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          DropdownFormField(
              hintText: (appConfigProvider.currentMode == ThemeMode.light)
                  ? AppLocalizations.of(context)!.light
                  : AppLocalizations.of(context)!.dark,
              value: (appConfigProvider.currentMode == ThemeMode.light)
                  ? "Light"
                  : "Dark",
              items: [
                DropdownMenuItem(
                    value: "Light",
                    child: Text(
                      AppLocalizations.of(context)!.light,
                      style: (appConfigProvider.currentMode == ThemeMode.light)
                          ? Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 16)
                          : Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: MyTheme.primaryColor, fontSize: 16),
                    )),
                DropdownMenuItem(
                    value: "Dark",
                    child: Text(
                      AppLocalizations.of(context)!.dark,
                      style: (appConfigProvider.currentMode == ThemeMode.light)
                          ? Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 16)
                          : Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: MyTheme.primaryColor, fontSize: 16),
                    ))
              ],
              onChanged: (newValue) {
                if (newValue == "Light") {
                  appConfigProvider.changeAppMode(ThemeMode.light);
                } else {
                  appConfigProvider.changeAppMode(ThemeMode.dark);
                }
              })
        ],
      ),
    );
  }
}

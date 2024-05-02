import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/providers/auth_user_provider.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/screens/auth/login_screen.dart';
import 'package:to_do_app/screens/auth/register_screen.dart';
import 'package:to_do_app/screens/edit_task/edit_task_screen.dart';
import 'package:to_do_app/screens/home_tabs/home_tabs_screen.dart';
import 'package:to_do_app/utilities/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';

///localization_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfiguresProvider appConfiguresProvider = AppConfiguresProvider();
  appConfiguresProvider.readAppConfigsData();
  await Firebase.initializeApp();
   FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => appConfiguresProvider),
      ChangeNotifierProvider(create: (context) => AuthUserProvider()),
      ChangeNotifierProvider(create: (context) => TasksProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfiguresProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(appConfigProvider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkMode,
      themeMode: appConfigProvider.currentMode,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeTabsScreen.routeName: (context) => const HomeTabsScreen(),
        EditTaskScreen.routeName: (context) => const EditTaskScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        LoginScreen.routeName: (context) => const LoginScreen()
      },
    );
  }
}

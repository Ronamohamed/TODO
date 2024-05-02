// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/auth_user_provider.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/screens/auth/login_screen.dart';
import 'package:to_do_app/screens/home_tabs/settings/settings_tab.dart';
import 'package:to_do_app/screens/home_tabs/tasks/tasks_tab.dart';
import 'package:to_do_app/screens/home_tabs/widgets/bottom_sheet/newtask_bottomsheet.dart';
import 'package:to_do_app/screens/home_tabs/widgets/notched_navbar.dart';
import 'package:to_do_app/utilities/dialog_util.dart';
import 'package:to_do_app/utilities/my_theme.dart';

///localization_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTabsScreen extends StatefulWidget {
  static const String routeName = "home_tabs_screen";

  const HomeTabsScreen({super.key});

  @override
  State<HomeTabsScreen> createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  /// [ MARK ] Variables: -
  int _selectedTabIndex = 0;

  /// [ MARK ] Utilities: -
  void popUpTaskBottomSheet() {
    showModalBottomSheet(
        // isScrollControlled: true,
        context: context,
        builder: (context) =>

            /// TODOO: padding the bottomSheet
            const NewTaskBottomSheet());
    //  Padding(
    //       padding: EdgeInsets.only(
    //           bottom: MediaQuery.of(context).viewInsets.bottom),
    //       child: const NewTaskBottomSheet(),
    //     )
  }

  /// [ MARK ] Stf LifeCycle: -
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_selectedTabIndex == 0)
            ? Text(AppLocalizations.of(context)!.title)
            : Text(AppLocalizations.of(context)!.settings),
        titleSpacing: MediaQuery.of(context).size.width * 0.15,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: MyTheme.whiteColor.withOpacity(0.8),
                shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                DialogUtils.showMessage(context,
                    title: AppLocalizations.of(context)!.sign_out,
                    content: AppLocalizations.of(context)!.sign_out_msg,
                    posActionName: AppLocalizations.of(context)!.cancel,
                    negAction: () async {
                  DialogUtils.showLoading(context,
                      message: AppLocalizations.of(context)!.loading);

                  /// We need to change [AuthUser] and [Tasks] ever `SignIn` or `SignUp`
                  var taskProvider =
                      Provider.of<TasksProvider>(context, listen: false);
                  var authUserProvider =
                      Provider.of<AuthUserProvider>(context, listen: false);
                  // we gonna empty the [tasks] and remove the [currentAuthUser]
                  taskProvider.tasks = [];
                  authUserProvider.currentAuthUser = null;
                  // then we gonna navigte to [LoginScreen] `SignOut`
                  await Future.delayed(Durations.extralong4);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.routeName, (Route<dynamic> route) => false);
                }, negActionName: AppLocalizations.of(context)!.yes);
              },
              icon: Icon(
                Icons.logout_outlined,
                color: MyTheme.primaryColor,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: NotchedBottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (newIndex) {
          _selectedTabIndex = newIndex;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/icon_list.png")),
              label: ""),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/icon_settings.png")),
              label: "")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpTaskBottomSheet();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _selectedTabIndex == 0 ? const TasksTab() : const SettingsTab(),
    );
  }
}

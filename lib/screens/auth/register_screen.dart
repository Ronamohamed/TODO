// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebase_manager.dart';
import 'package:to_do_app/models/auth_user.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/providers/auth_user_provider.dart';
import 'package:to_do_app/screens/auth/widgets/auth_button.dart';
import 'package:to_do_app/screens/auth/widgets/auth_textform_field.dart';
import 'package:to_do_app/screens/home_tabs/home_tabs_screen.dart';
import 'package:to_do_app/utilities/dialog_util.dart';
import 'package:to_do_app/utilities/my_theme.dart';
import 'package:to_do_app/utilities/myvalidation.dart';

///localization_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ///* [ MARK ] Variables: -
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController =
      TextEditingController(text: 'haytham@yahoo.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');
  final TextEditingController _confirPasswordController =
      TextEditingController(text: '12345678');
  bool _isPasswordSecure = true;
  bool _isConfirmSecure = true;

  ///* [ MARK ] Utilities:-
  void _signUp() async {
    if (_formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context,
          message: AppLocalizations.of(context)!.loading);
      try {
        /// Create new [AuthUser] in `FiresbaseAuth`
        var userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        /// Create [AuthUser] who `signedUp` above to `FiresbaseFirestore` to store his data
        AuthUser authUser = AuthUser(
            id: userCredential.user?.uid, email: _emailController.text);
        await FirebaseManager.addAuthUserToFirestore(authUser);

        /// Save the current [AuthUser] to [AuthUserProvider] to use it among the app
        var authUserProvider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authUserProvider.changeAuthUserWhenSignUpAndSignIn(authUser);

        /// Success
        DialogUtils.hideLoading(context);
        // DialogUtils.showMessage(context,
        // title: AppLocalizations.of(context)!.create_acc, content: AppLocalizations.of(context)!.success);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeTabsScreen.routeName, (Route<dynamic> route) => false);

        /// Failure
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context,
              title: AppLocalizations.of(context)!.error,
              content: AppLocalizations.of(context)!.valid_pass);
        } else if (error.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context,
              title: AppLocalizations.of(context)!.error,
              content: AppLocalizations.of(context)!.email_exists,
              posActionName: AppLocalizations.of(context)!.ok);
        }
      } catch (error) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context,
            title: AppLocalizations.of(context)!.error,
            content: "Error Occured: $error",
            posActionName: AppLocalizations.of(context)!.ok);
      }
    }
  }

  ///* [ MARK ] STF LifeCycle :-
  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfiguresProvider>(context);

    return Stack(alignment: Alignment.center, children: [
      Image.asset(
        (appConfigProvider.currentMode == ThemeMode.light)
            ? 'assets/images/splash_icon.png'
            : 'assets/images/splash_icon_dark.png',
        opacity: (appConfigProvider.currentMode == ThemeMode.light)
            ? const AlwaysStoppedAnimation(0.8)
            : const AlwaysStoppedAnimation(0.7),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: (appConfigProvider.currentMode == ThemeMode.light)
            ? Colors.white.withOpacity(0.85)
            : MyTheme.darkBackgroundColor.withOpacity(0.8),
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.create_acc,
          ),
          toolbarHeight: 100,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: (appConfigProvider.currentMode == ThemeMode.light)
              ? MyTheme.primaryColor
              : MyTheme.whiteColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                  ),
                  AuthTextFormField(
                    labelText: AppLocalizations.of(context)!.email,
                    controller: _emailController,
                    validator: MyValidation.validateEmail,
                  ),
                  AuthTextFormField(
                    labelText: AppLocalizations.of(context)!.pass,
                    controller: _passwordController,
                    validator: MyValidation.validatePassword,
                    obscureText: _isPasswordSecure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordSecure = !_isPasswordSecure;
                        });
                      },
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color:
                            (appConfigProvider.currentMode == ThemeMode.light)
                                ? MyTheme.primaryColor
                                : MyTheme.whiteColor,
                      ),
                    ),
                  ),
                  AuthTextFormField(
                    labelText: AppLocalizations.of(context)!.confirm_Pass,
                    controller: _confirPasswordController,
                    validator: (text) {
                      if (text != _passwordController.text) {
                        return AppLocalizations.of(context)!.valid_confirm_pass;
                      } else {
                        return null;
                      }
                    },
                    obscureText: _isConfirmSecure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isConfirmSecure = !_isConfirmSecure;
                        });
                      },
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color:
                            (appConfigProvider.currentMode == ThemeMode.light)
                                ? MyTheme.primaryColor
                                : MyTheme.whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.16,
                  ),
                  AuthButton(
                    title: AppLocalizations.of(context)!.sign_up,
                    onPressed: () {
                      _signUp();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

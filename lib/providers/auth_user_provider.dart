import 'package:flutter/foundation.dart';
import 'package:to_do_app/models/auth_user.dart';

class AuthUserProvider extends ChangeNotifier {
  AuthUser? currentAuthUser;

  void changeAuthUserWhenSignUpAndSignIn(AuthUser? newAuthUser) {
    currentAuthUser = newAuthUser;
    notifyListeners();
  }
}

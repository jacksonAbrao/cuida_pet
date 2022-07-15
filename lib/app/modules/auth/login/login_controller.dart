// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuida_pet/app/core/ui/widgets/loader.dart';
import 'package:mobx/mobx.dart';

import 'package:cuida_pet/app/core/loggger/app_logger.dart';
import 'package:cuida_pet/app/services/user/user_service.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;
  _LoginControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;

  Future<void> login(String login, String password) async {
    print(login);
    print(password);
    Loader.show();
    await Future.delayed(const Duration(seconds: 2));
    Loader.hide();
  }
}

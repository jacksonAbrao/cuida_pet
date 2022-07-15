// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cuida_pet/app/core/exeptions/failure.dart';
import 'package:cuida_pet/app/core/exeptions/user_not_exists_exception.dart';
import 'package:cuida_pet/app/core/ui/widgets/loader.dart';
import 'package:cuida_pet/app/core/ui/widgets/messages.dart';
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
    try {
      Loader.show();
      await _userService.login(login, password);
      Loader.hide();
    } on Failure catch (e, s) {
      final errorMessage = e.message ?? 'Erro ao realizar login';
      _log.error(errorMessage, e, s);
      Loader.hide();
      Messages.alert(errorMessage);
    } on UserNotExistsException catch (e, s) {
      const errorMessage = 'Usuário não encontrado';
      _log.error(errorMessage);
      Loader.hide();
      Messages.alert(errorMessage);
    }
  }
}

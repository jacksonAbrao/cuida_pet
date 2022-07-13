// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuida_pet/app/core/ui/widgets/loader.dart';
import 'package:mobx/mobx.dart';

import 'package:cuida_pet/app/core/loggger/app_logger.dart';
import 'package:cuida_pet/app/services/user/user_service.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;
  RegisterControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;

  void register({required String email, required String password}) async {
    Loader.show();
    await Future.delayed(const Duration(seconds: 2));
    Loader.hide();
  }
}

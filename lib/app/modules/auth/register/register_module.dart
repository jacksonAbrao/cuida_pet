import 'package:cuida_pet/app/modules/auth/register/register_controller.dart';
import 'package:cuida_pet/app/modules/auth/register/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterController(
          log: i(), //AuthModule
          userService: i(), //CoreModule
        ))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const RegisterPage())
  ];
}

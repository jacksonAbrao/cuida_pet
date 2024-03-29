import 'package:cuida_pet/app/modules/auth/home/auth_home_page.dart';
import 'package:cuida_pet/app/modules/auth/login/login_module.dart';
import 'package:cuida_pet/app/modules/auth/register/register_module.dart';
import 'package:cuida_pet/app/repositories/user/user_repository.dart';
import 'package:cuida_pet/app/repositories/user/user_repository_impl.dart';
import 'package:cuida_pet/app/repositories/social/social_repository.dart';
import 'package:cuida_pet/app/repositories/social/social_repository_impl.dart';
import 'package:cuida_pet/app/services/user/user_service.dart';
import 'package:cuida_pet/app/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<SocialRepository>((i) => SocialRepositoryImpl()),
    Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(
          log: i(), //CoreModule
          restClient: i(), //CoreModule
        )),
    Bind.lazySingleton<UserService>((i) => UserServiceImpl(
          log: i(), // CoreModule
          userRepository: i(), // AuthModule
          localStorage: i(), // CoreModule
          localSecureStorage: i(), // CoreModule
          socialRepository: i(), // CoreModule
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, __) => AuthHomePage(authStore: Modular.get())),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule()),
  ];
}

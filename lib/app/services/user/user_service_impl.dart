import 'package:cuida_pet/app/core/exeptions/failure.dart';
import 'package:cuida_pet/app/core/exeptions/user_exists_exception.dart';
import 'package:cuida_pet/app/core/exeptions/user_not_exists_exception.dart';
import 'package:cuida_pet/app/core/loggger/app_logger.dart';
import 'package:cuida_pet/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _log;

  UserServiceImpl({
    required UserRepository userRepository,
    required AppLogger log,
  })  : _userRepository = userRepository,
        _log = log;

  @override
  Future<void> register(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final userMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (userMethods.isNotEmpty) {
        throw UserExistsException();
      }

      await _userRepository.register(email, password);
      final userRegisterCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error('Erro ao criar usuário no firebase', e, s);
      throw Failure(message: 'Erro ao criar usuário');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      }

      if (loginMethods.contains('password')) {
        final UserCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        final userVerified = UserCredential.user?.emailVerified ?? false;
        if (!userVerified) {
          UserCredential.user?.sendEmailVerification();
          throw Failure(
              message:
                  'E-mail não veríficado, por favor verifique sua caixa de spam');
        }
        // se a senha incorreta

      } else {
        throw Failure(message: 'Login não encontrado');
      }
    } on FirebaseAuthException catch (e, s) {
      const errorMessage = 'Usuário ou senha inválidos';
      _log.error('$errorMessage FirebaseAuthError[${e.code}]', e, s);
      throw Failure(message: errorMessage);
    }
  }
}

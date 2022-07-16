import 'package:cuida_pet/app/core/exeptions/failure.dart';
import 'package:cuida_pet/app/core/exeptions/user_exists_exception.dart';
import 'package:cuida_pet/app/core/exeptions/user_not_exists_exception.dart';
import 'package:cuida_pet/app/core/helpers/constants.dart';
import 'package:cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:cuida_pet/app/core/loggger/app_logger.dart';
import 'package:cuida_pet/app/models/confirm_login_model.dart';
import 'package:cuida_pet/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _log;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;

  UserServiceImpl({
    required UserRepository userRepository,
    required AppLogger log,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
  })  : _userRepository = userRepository,
        _log = log,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage;

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
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        final userVerified = userCredential.user?.emailVerified ?? false;
        if (!userVerified) {
          userCredential.user?.sendEmailVerification();
          throw Failure(
              message:
                  'E-mail não veríficado, por favor verifique sua caixa de spam');
        }

        final accessToken = await _userRepository.login(email, password);
        await _saveAccessToken(accessToken);
        await _confirmLogin();
      } else {
        throw Failure(message: 'Login não encontrado');
      }
    } on FirebaseAuthException catch (e, s) {
      const errorMessage = 'Usuário ou senha inválidos';
      _log.error('$errorMessage FirebaseAuthError[${e.code}]', e, s);
      throw Failure(message: errorMessage);
    }
  }

  Future<void> _saveAccessToken(String accessToken) => _localStorage.write(
      Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);

  Future<void> _confirmLogin() async {
    final confirmLoginModel = await _userRepository.confirmLogin();
    await _saveAccessToken(confirmLoginModel.accessToken);
    await _localSecureStorage.write(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY,
        confirmLoginModel.refreshToken);
  }
}

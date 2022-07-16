import 'package:cuida_pet/app/models/confirm_login_model.dart';
import 'package:cuida_pet/app/models/user_model.dart';

abstract class UserRepository {
  Future<void> register(String email, String password);
  Future<String> login(String email, String password);
  Future<ConfirmLoginModel> confirmLogin();
  Future<UserModel> getUserLogged();
}

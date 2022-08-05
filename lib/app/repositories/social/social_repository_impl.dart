import 'package:cuida_pet/app/core/exeptions/failure.dart';
import 'package:cuida_pet/app/models/social_network_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './social_repository.dart';

class SocialRepositoryImpl implements SocialRepository {
  @override
  Future<SocialNetworkModel> FacebookLogin() async {
    final facebookAuth = FacebookAuth.instance;
    final result = await facebookAuth.login();

    switch (result.status) {
      case LoginStatus.success:
        final userData = await facebookAuth.getUserData();
        return SocialNetworkModel(
          id: userData['id'],
          name: userData['name'],
          email: userData['email'],
          type: 'Facebook',
          avatar: userData['picture']['data']['url'],
          accessToken: result.accessToken?.token ?? '',
        );
      case LoginStatus.cancelled:
        throw Failure(message: 'Login cancelado');
      case LoginStatus.failed:
      case LoginStatus.operationInProgress:
        throw Failure(message: result.message);
    }
  }

  @override
  Future<SocialNetworkModel> googleLogin() async {
    final googleSignin = GoogleSignIn();

    if (await googleSignin.isSignedIn()) {
      await googleSignin.disconnect();
    }

    final googleUser = await googleSignin.signIn();

    final googleAuth = await googleUser?.authentication;

    if (googleAuth != null && googleUser != null) {
      return SocialNetworkModel(
        id: googleAuth.idToken ?? '',
        name: googleUser.displayName ?? '',
        email: googleUser.email,
        type: 'Google',
        avatar: googleUser.photoUrl,
        accessToken: googleAuth.accessToken ?? '',
      );
    } else {
      throw Failure(message: 'Erro ao realizar login com o Google.');
    }
  }
}

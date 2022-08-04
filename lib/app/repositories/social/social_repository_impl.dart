import 'package:cuida_pet/app/core/exeptions/failure.dart';
import 'package:cuida_pet/app/models/social_network_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './social_repository.dart';

class SocialRepositoryImpl implements SocialRepository {
  @override
  Future<SocialNetworkModel> FacebookLogin() {
    // TODO: implement FacebookLogin
    throw UnimplementedError();
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

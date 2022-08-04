import 'package:cuida_pet/app/models/social_network_model.dart';

abstract class SocialRepository {
  Future<SocialNetworkModel> googleLogin();
  Future<SocialNetworkModel> FacebookLogin();
}

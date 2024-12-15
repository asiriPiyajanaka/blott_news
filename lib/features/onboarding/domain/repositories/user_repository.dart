import 'package:blott_news/features/onboarding/domain/models/user_model.dart';

abstract class UserRepository {
  Future<void> submitUserData(UserModel user);
}

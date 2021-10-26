import 'package:project_flutter/model/user_model.dart';
import 'package:project_flutter/repository/user_repository.dart';

class UserViewModel {
  final UserModel? userModel;

  UserViewModel(this.userModel);
}

class ListUserViewModel {
  List<UserViewModel>? users;
  UserRepository userRepository = UserRepository();

  Future<void> getUser() async {
    final rs = await userRepository.getUser();
    users = rs.map((e) => UserViewModel(e)).toList();
  }
}

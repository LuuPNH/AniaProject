import 'package:project_flutter/model/user_detail_model.dart';
import 'package:project_flutter/repository/user_repository.dart';

class UserDetailViewModel{
  final int id;

  UserDetailModel? userDetailModel;
  UserRepository userRepository = UserRepository();

  UserDetailViewModel(this.id);

  Future<void> getUserDetail(int id) async {
    userDetailModel = await userRepository.getUserDetail(id);
  }
}
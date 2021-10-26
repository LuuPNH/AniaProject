import 'dart:convert';
import 'package:project_flutter/model/user_detail_model.dart';
import 'package:project_flutter/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String url = "https://api.github.com/users";

  Future<List<UserModel>> getUser() async {


    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final li = json.map((e) => UserModel.fromJson(e)).toList();
      return li;
    }
     else {
      throw Exception('Error get User');
    }

  }

  Future<UserDetailModel> getUserDetail(int id) async {
    final response = await http.get(Uri.parse(url + "/$id"));
    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final res = UserDetailModel.fromJson(json);
      return res;
    }
    else {
      throw Exception('Error get detail user');
    }

  }
}

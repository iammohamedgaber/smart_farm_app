import 'package:smart_farm_app/core/api/api_service.dart';
import 'package:smart_farm_app/data/models/register_model.dart';

import '../models/login_model.dart';
import '../models/user_model.dart';

class AuthRemoteSource {
  final ApiService api = ApiService();

  Future<UserModel> login(LoginModel model) async {
    final data = await api.post(
      endpoint: "/api/User/login",
      body: model.toJson(),
    );
    print(data);

    return UserModel.fromJson(data);
  }

  Future<dynamic> register(RegisterModel model) async {
    final data = await api.post(
      endpoint: "/api/User/register",
      body: model.toJson(),
    );

    return data;
  }
}

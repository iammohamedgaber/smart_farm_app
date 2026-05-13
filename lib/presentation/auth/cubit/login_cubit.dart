import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/core/utils/user_storage.dart';
import 'package:smart_farm_app/data/models/login_model.dart';
import 'package:smart_farm_app/data/sources/auth_remote_source.dart';

class LoginCubit extends Cubit<bool> {
  LoginCubit() : super(false);

  final AuthRemoteSource auth = AuthRemoteSource();

  Future<void> login(String email, String password) async {
    try {
      final model = LoginModel(email: email, passwordHash: password);
      final user = await auth.login(model);

      if (user == Null) {
        throw Exception("User data is null");
      }

      await UserStorage.saveUserId(user.id);
      await UserStorage.saveUsername(user.username);
      await UserStorage.saveEmail(user.email);

      emit(true);
    } catch (e) {
      emit(false);
      rethrow;
    }
  }
}

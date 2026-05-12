import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/login_model.dart';
import '../../../data/sources/auth_remote_source.dart';
import '../../../core/utils/user_storage.dart';

class LoginCubit extends Cubit<bool> {
  LoginCubit() : super(false);

  final AuthRemoteSource auth = AuthRemoteSource();

  Future<void> login(String email, String password) async {
    final model = LoginModel(email: email, passwordHash: password);

    final user = await auth.login(model);

    await UserStorage.saveUserId(user.id);
    await UserStorage.saveUsername(user.username);
    await UserStorage.saveEmail(user.email);

    emit(true);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/user_storage.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false);

  Future<void> checkUser() async {
    final id = await UserStorage.getUserId();

    if (id != null) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
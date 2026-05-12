import 'package:bloc/bloc.dart';
import 'package:smart_farm_app/core/utils/user_storage.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String username;
  final String email;
  ProfileLoaded(this.username, this.email);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading()) {
    loadUser();
  }

  Future<void> loadUser() async {
    try {
      emit(ProfileLoading());
      final name = await UserStorage.getUsername();
      final mail = await UserStorage.getEmail();
      emit(ProfileLoaded(name ?? '', mail ?? ''));
    } catch (e) {
      emit(ProfileError('فشل تحميل بيانات المستخدم'));
    }
  }

  Future<void> logout() async {
    await UserStorage.logout();
  }
}

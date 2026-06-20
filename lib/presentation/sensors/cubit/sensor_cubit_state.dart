part of 'sensor_cubit.dart';

@immutable
sealed class SensorCubitState {}

/// الحالة الأولية
final class SensorCubitInitial extends SensorCubitState {}

/// حالة التحميل (Loading)
final class SensorCubitLoading extends SensorCubitState {}

/// حالة النجاح (Loaded)
final class SensorCubitLoaded extends SensorCubitState {
  final List<SensorModel> sensors;

  SensorCubitLoaded(this.sensors);
}

/// حالة الخطأ (Error)
final class SensorCubitError extends SensorCubitState {
  final String message;

  SensorCubitError(this.message);
}

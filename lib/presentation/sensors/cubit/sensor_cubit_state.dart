part of 'sensor_cubit.dart';

@immutable
sealed class SensorCubitState {}

final class SensorCubitInitial extends SensorCubitState {}

final class SensorCubitLoading extends SensorCubitState {}

final class SensorCubitLoaded extends SensorCubitState {
  final List<SensorModel> sensors;

  SensorCubitLoaded(this.sensors);
}

final class SensorCubitError extends SensorCubitState {
  final String message;

  SensorCubitError(this.message);
}

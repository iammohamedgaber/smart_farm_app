import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_farm_app/data/models/SensorModel.dart';
import 'package:smart_farm_app/data/sources/sensor_api.dart';
part 'sensor_cubit_state.dart';

class SensorCubit extends Cubit<SensorCubitState> {
  final SensorApi sensorApi;

  SensorCubit(this.sensorApi) : super(SensorCubitInitial());

  Future<void> loadSensors() async {
    if (isClosed) return;
    emit(SensorCubitLoading());
    try {
      final sensors = await sensorApi.getAllSensors();
      if (!isClosed) emit(SensorCubitLoaded(sensors));
    } catch (e) {
      if (!isClosed) emit(SensorCubitError(e.toString()));
    }
  }

  Future<void> loadSensorDetails(int sensorId) async {
    if (isClosed) return;
    emit(SensorCubitLoading());
    try {
      final sensor = await sensorApi.getSensorDetails(sensorId);
      if (!isClosed) {
        if (sensor != null) {
          emit(SensorCubitLoaded([sensor]));
        } else {
          emit(SensorCubitError("Sensor not found"));
        }
      }
    } catch (e) {
      if (!isClosed) emit(SensorCubitError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

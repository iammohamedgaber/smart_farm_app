import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/data/models/RobotSt_model.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';
import 'package:smart_farm_app/data/sources/robot_api.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit_state.dart';

class ZoneDetailsCubit extends Cubit<ZoneDetailsState> {
  final RobotApi robotApi;

  ZoneDetailsCubit(this.robotApi) : super(ZoneInitial());

  Future<void> irrigateZone(int zoneId, int duration) async {
    emit(ZoneLoading());
    try {
      final ok = await robotApi.irrigate(
        IrrigateRequest(userId: 1, zoneId: zoneId, duration: duration),
      );
      if (ok) {
        emit(ZoneSuccess('Irrigation has started.'));
      } else {
        emit(ZoneFailure("Irrigation start failure"));
      }
    } catch (_) {
      emit(ZoneFailure("Error during irrigation"));
    }
  }

  Future<void> removeWeed(int zoneId) async {
    emit(ZoneLoading());
    try {
      final ok = await robotApi.removeWeed(
        RemoveHarmfulPlantRequest(
          plantId: 1,
          x: 0,
          y: 0,
          userId: 1,
          zoneId: zoneId,
        ),
      );
      if (ok) {
        emit(ZoneSuccess('The weeds have been removed.'));
      } else {
        emit(ZoneFailure('"Failed to remove the weeds"'));
      }
    } catch (_) {
      emit(ZoneFailure("Error while removing weeds"));
    }
  }

  Future<void> plantCrop(int zoneId, int cropId, {String? cropName}) async {
    emit(ZoneLoading());
    try {
      final ok = await robotApi.plantCrop(
        PlantCropRequest(cropId: cropId, userId: 1, zoneId: zoneId),
      );
      if (ok) {
        emit(ZoneSuccess("Crop planted successfully", cropName: cropName));
      } else {
        emit(ZoneFailure("Crop planting failed"));
      }
    } catch (_) {
      emit(ZoneFailure("Error while planting crop"));
    }
  }

  Future<void> harvest(int zoneId) async {
    emit(ZoneLoading());
    try {
      final ok = await robotApi.harvest(
        HarvestRequest(userId: 1, zoneId: zoneId),
      );
      if (ok) {
        emit(ZoneSuccess("Harvest completed successfully"));
      } else {
        emit(ZoneFailure("Harvest failed"));
      }
    } catch (_) {
      emit(ZoneFailure("Error while harvesting"));
    }
  }

  Future<void> scan(int zoneId) async {
    emit(ZoneLoading());
    try {
      final ok = await robotApi.scan(ScanRequest(userId: 1, zoneId: zoneId));
      if (ok) {
        emit(ZoneSuccess("Scan completed successfully"));
      } else {
        emit(ZoneFailure("Scan failed"));
      }
    } catch (_) {
      emit(ZoneFailure("Error while scanning"));
    }
  }

  Future<void> plantFound(int zoneId, int plantId, double x, double y) async {
    emit(ZoneLoading());
    try {
      final ok = await robotApi.plantFound(
        PlantFoundRequest(plantId: plantId, x: x, y: y, zoneId: zoneId),
      );
      if (ok) {
        emit(ZoneSuccess("Plant discovery recorded"));
      } else {
        emit(ZoneFailure("Failed to record plant discovery"));
      }
    } catch (_) {
      emit(ZoneFailure("Error while recording plant discovery"));
    }
  }
}

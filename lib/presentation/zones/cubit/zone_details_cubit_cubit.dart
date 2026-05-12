import 'package:flutter_bloc/flutter_bloc.dart';
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
        emit(ZoneSuccess("تم بدء الري"));
      } else {
        emit(ZoneFailure("فشل بدء الري"));
      }
    } catch (_) {
      emit(ZoneFailure("خطأ أثناء الري"));
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
        emit(ZoneSuccess("تمت إزالة الأعشاب"));
      } else {
        emit(ZoneFailure("فشل في إزالة الأعشاب"));
      }
    } catch (_) {
      emit(ZoneFailure("خطأ أثناء إزالة الأعشاب"));
    }
  }

  Future<void> plantCrop(int zoneId, int cropId) async {
    emit(ZoneLoading());
    try {
      // هنا هتستدعي الـ API بتاع زرع المحصول
      emit(ZoneSuccess("تم زرع المحصول بنجاح"));
    } catch (_) {
      emit(ZoneFailure("فشل زرع المحصول"));
    }
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_farm_app/data/models/zone_model.dart';
// import 'package:smart_farm_app/data/sources/zone_api.dart';

// class ZonesCubit extends Cubit<List<ZoneModel>> {
//   ZonesCubit() : super([]);

//   final ZoneApi api = ZoneApi();

//   Future<void> loadZones() async {
//     final zones = await api.getZones();

//     emit(zones);
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';
import 'package:smart_farm_app/data/sources/zone_api.dart';

class ZonesCubit extends Cubit<List<ZoneModel>> {
  ZonesCubit() : super([]);

  final ZoneApi api = ZoneApi();

  // ✅ كل الـ Zones
  Future<void> loadZones() async {
    final zones = await api.getZones();
    emit(zones);
  }

  // ✅ تفاصيل Zone واحدة
  Future<ZoneModel?> loadZoneDetails(int zoneId) async {
    return await api.getZoneDetails(zoneId);
  }

  // ✅ كل الـ Zones الخاصة بمحصول معين
  Future<List<ZoneModel>> loadZonesByCrop(int cropId) async {
    return await api.getZonesByCrop(cropId);
  }
}


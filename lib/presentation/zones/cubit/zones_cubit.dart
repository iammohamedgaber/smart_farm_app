import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';
import 'package:smart_farm_app/data/sources/zone_api.dart';

class ZonesCubit extends Cubit<List<ZoneModel>> {
  ZonesCubit() : super([]);

  final ZoneApi api = ZoneApi();

  Future<void> loadZones() async {
    final zones = await api.getZones();

    emit(zones);
  }
}

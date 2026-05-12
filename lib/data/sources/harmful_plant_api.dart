import 'package:smart_farm_app/data/models/zone_model.dart';

import '../../core/api/api_service.dart';


class HarmfulPlantApi {

  final ApiService api = ApiService();

  Future addHarmful(AddHarmfulPlantRequest model) async {

    await api.post(

      endpoint: "/api/HarmfulPlant",

      body: model.toJson(),

    );

  }

  Future removeHarmful(RemoveHarmfulPlantRequest model) async {

    await api.post(

      endpoint: "/api/HarmfulPlant/remove",

      body: model.toJson(),

    );

  }

}
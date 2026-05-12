import 'package:flutter/material.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';
import 'package:smart_farm_app/data/sources/crop_api.dart';
import 'package:smart_farm_app/data/sources/robot_api.dart';


class SelectCropPage extends StatefulWidget {
  final ZoneModel zone;

  const SelectCropPage({super.key, required this.zone});

  @override
  State<SelectCropPage> createState() => _SelectCropPageState();
}

class _SelectCropPageState extends State<SelectCropPage> {
  final CropApi cropApi = CropApi();
  final RobotApi robotApi = RobotApi();

  List<CropModel> crops = [];
  int? selectedCrop;

  bool loading = true;
  bool _isPlanting = false;

  @override
  void initState() {
    super.initState();
    loadCrops();
  }

  Future<void> loadCrops() async {
    setState(() => loading = true);
    try {
      final data = await cropApi.getCrops();
      if (!mounted) return;
      setState(() {
        crops = data.where((e) => e.id != 0).toList();
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل تحميل المحاصيل. حاول مرة أخرى.')),
      );
    }
  }

  Future<void> plantCrop() async {
    if (selectedCrop == null || _isPlanting) return;

    final model = PlantCropRequest(
      cropId: selectedCrop!,
      userId: 1,
      zoneId: widget.zone.zoneId,
    );

    setState(() => _isPlanting = true);

    try {
      final success = await robotApi.plantCrop(model);

      if (!mounted) return;

      if (success) {
        Navigator.pop(context, true);
      } else {
        setState(() => _isPlanting = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('فشل زراعة المحصول')));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isPlanting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء زراعة المحصول')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const scaffoldBg = Color(0xffF4F7FA);
    const cardColor = Colors.white;
    const mutedText = Colors.grey;
    const primary = Color(0xff27AE60);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: const Text("Select Crop"),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : crops.isEmpty
          ? const Center(
              child: Text(
                "No crops available",
                style: TextStyle(fontSize: 18, color: mutedText),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Choose Crop for this Zone",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "You can select crop only once",
                    style: TextStyle(color: mutedText),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    child: DropdownButtonFormField<int>(
                      value: selectedCrop,
                      hint: const Text("Choose Crop"),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffF1F4F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: crops.map((crop) {
                        return DropdownMenuItem<int>(
                          value: crop.id,
                          child: Text(crop.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCrop = value;
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: (selectedCrop == null || _isPlanting)
                          ? null
                          : plantCrop,
                      child: _isPlanting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Confirm Crop",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

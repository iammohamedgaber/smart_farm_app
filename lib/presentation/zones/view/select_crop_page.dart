import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/animations/widgets/loading_widgets.dart';
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
        crops = data.where((e) => e.cropId != 0).toList();
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load crops. Try again.')),
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
       
        final cropName = crops
            .firstWhere((c) => c.cropId == selectedCrop)
            .cropName;
        Navigator.pop(context, cropName); 
      } else {
        setState(() => _isPlanting = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Crop failure')));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isPlanting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while planting the crop.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.selectCropBackground,
      appBar: _buildAppBar(),
      body: loading
          ? const AppLoading(
              text: 'Loading crops...',
              color: AppColors.green500,
            )
          : crops.isEmpty
          ? const EmptyState(
              message: 'No crops available',
              icon: Icons.agriculture,
            )
          : _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        "Select Crop",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      backgroundColor: AppColors.green500,
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose Crop for this Zone",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "You can select crop only once",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 25),
          _buildDropdown(),
          const Spacer(),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: DropdownButtonFormField<int>(
        value: selectedCrop,
        hint: const Text("Choose Crop"),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.dropdownFill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        items: crops.map((crop) {
          return DropdownMenuItem<int>(
            value: crop.cropId,
            child: Text(crop.cropName),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCrop = value;
          });
        },
      ),
    );
  }

  Widget _buildConfirmButton() {
    return LoadingButton(
      isLoading: _isPlanting,
      onPressed: (selectedCrop == null || _isPlanting) ? null : plantCrop,
      text: 'Confirm Crop',
      color: AppColors.green500,
    );
  }
}

import 'package:flutter/material.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  State<SensorsScreen> createState() => SensorsScreenState();
}

class SensorsScreenState extends State<SensorsScreen> {

  double temperature = 0;
  double humidity = 0;
  int soil = 0;
  int light = 0;

  bool fanOn = false;
  bool pumpOn = false;
  String mode = 'auto';

  @override
  void initState() {
    super.initState();
    fetchSensors(); // هنا هييجي API
  }

  // هنا هنحط API لما يتبعتلك
  Future<void> fetchSensors() async {

    /*
    مثال مستقبلاً

    final response = await http.get(
      Uri.parse("API_LINK_HERE"),
    );

    final data = jsonDecode(response.body);

    setState(() {

      temperature = data["temperature"];
      humidity = data["humidity"];
      soil = data["soil"];
      light = data["light"];

    });
    */

  }

  void toggleMode() {
    setState(() {
      mode = mode == 'auto' ? 'manual' : 'auto';
    });
  }

  void toggleFan() {
    if (mode == 'manual') {
      setState(() {
        fanOn = !fanOn;
      });
    }
  }

  void togglePump() {
    if (mode == 'manual') {
      setState(() {
        pumpOn = !pumpOn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

     return AppBar();
    // Scaffold(

    //   appBar: AppBar(
    //     title: const Text('Sensors'),
    //     centerTitle: true,
    //     backgroundColor: Colors.green,
    //   ),

    //   body: Padding(

    //     padding: const EdgeInsets.all(10),

    //     child: Column(

    //       children: [

    //         Expanded(

    //           child: GridView.count(

    //             crossAxisCount: 2,
    //             crossAxisSpacing: 16,
    //             mainAxisSpacing: 16,

    //             children: [

    //               SensorCard(
    //                 title: 'Temperature',
    //                 value: temperature.toStringAsFixed(1),
    //                 unit: '°C',
    //                 icon: Icons.thermostat,
    //                 color: Colors.red,
    //               ),

    //               SensorCard(
    //                 title: 'Humidity',
    //                 value: humidity.toStringAsFixed(1),
    //                 unit: '%',
    //                 icon: Icons.water_drop,
    //                 color: Colors.blue,
    //               ),

    //               SensorCard(
    //                 title: 'Soil Moisture',
    //                 value: soil.toString(),
    //                 unit: '%',
    //                 icon: Icons.grass,
    //                 color: Colors.brown,
    //               ),

    //               SensorCard(
    //                 title: 'Light',
    //                 value: light.toString(),
    //                 unit: 'Lux',
    //                 icon: Icons.wb_sunny,
    //                 color: Colors.orange,
    //               ),

    //             ],
    //           ),

    //         ),

    //         CustomModeSwitch(
    //           mode: mode,
    //           onToggle: toggleMode,
    //         ),

    //         const SizedBox(height: 10),

    //         Row(

    //           children: [

    //             Expanded(

    //               child: ControlCard(
    //                 title: 'Fan',
    //                 icon: Icons.wind_power,
    //                 isOn: fanOn,
    //                 isEnabled: mode == 'manual',
    //                 onPressed: toggleFan,
    //               ),

    //             ),

    //             const SizedBox(width: 16),

    //             Expanded(

    //               child: ControlCard(
    //                 title: 'Pump',
    //                 icon: Icons.water,
    //                 isOn: pumpOn,
    //                 isEnabled: mode == 'manual',
    //                 onPressed: togglePump,
    //               ),

    //             ),

    //           ],

    //         )

    //       ],

    //     ),

    //   ),

    // );

  }

}
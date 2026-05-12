import 'package:flutter/material.dart';
import 'package:smart_farm_app/presentation/operations/view/operations_page.dart';
import 'package:smart_farm_app/presentation/profile/view/profile_page.dart';
import 'package:smart_farm_app/presentation/sensors/view/SensorsScreen.dart';

import 'package:smart_farm_app/presentation/zones/view/zones_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    ZonesPage(),

    SensorsScreen(),

    OperationsPage(),

    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grass), label: "Zones"),

          BottomNavigationBarItem(icon: Icon(Icons.sensors), label: "Sensors"),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Operations",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

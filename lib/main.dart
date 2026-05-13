import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/data/sources/robot_api.dart';
import 'package:smart_farm_app/presentation/splash/view/splash_page.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit.dart';

import 'presentation/auth/cubit/login_cubit.dart';
import 'presentation/zones/cubit/zones_cubit.dart';
import 'presentation/profile/cubit/profile_cubit.dart';

void main() {
  runApp(const SmartFarmApp());
}

class SmartFarmApp extends StatelessWidget {
  const SmartFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => ZonesCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
         BlocProvider(create: (_) => ZoneDetailsCubit(RobotApi()))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}

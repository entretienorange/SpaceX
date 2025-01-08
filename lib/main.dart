import 'package:flutter/material.dart';
import 'package:spacex/Views/LaunchView.dart';
import 'package:spacex/Views/MissionView.dart';
import 'package:spacex/ViewModels/launchViewmodels.dart';
import 'package:spacex/ViewModels/missionViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LaunchViewModel()..fetchLaunches()), 
        ChangeNotifierProvider(create: (_) => MissionViewModel()..fetchMissions()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SpaceX Missions',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/', 
        routes: {
          '/': (context) => const LaunchView(),
          '/launch': (context) => const LaunchView(),
          '/mission': (context) => const MissionView(),
        },
      ),
    );
  }
}

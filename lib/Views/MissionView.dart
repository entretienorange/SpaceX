import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex/Views/MissionDetailView.dart';
import '../ViewModels/MissionViewModel.dart';
import 'package:spacex/Widget/SideMenu.dart';  

class MissionView extends StatelessWidget {
  const MissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MissionViewModel()..fetchMissions(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List of Missions'),
          centerTitle: true, 
        ),
        drawer: SideMenu(),  
        body: Consumer<MissionViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.missions.isEmpty) {
              return const Center(child: Text('No missions available.'));
            } else {
              return LayoutBuilder(
                builder: (context, constraints) {
                  double cardWidth = constraints.maxWidth > 600 ? 400 : constraints.maxWidth * 0.9;
                  double fontSize = constraints.maxWidth > 600 ? 22 : 16;

                  return ListView.builder(
                    itemCount: viewModel.missions.length,
                    itemBuilder: (context, index) {
                      final mission = viewModel.missions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MissionDetailsView(
                                  missionId: mission.missionId,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: cardWidth, 
                                    child: Text(
                                      mission.missionName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize, 
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: cardWidth,
                                    child: Text(
                                      'ID: ${mission.missionId}', 
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: fontSize - 2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

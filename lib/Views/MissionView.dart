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
          title: const Text('list of Mission'),
        ),
        drawer: SideMenu(),  
        body: Consumer<MissionViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.missions.isEmpty) {
              return const Center(child: Text('Aucun lancement disponible.'));
            } else {
              return ListView.builder(
                itemCount: viewModel.missions.length,
                itemBuilder: (context, index) {
                  final mission = viewModel.missions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(mission.missionName),
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
                    ),
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

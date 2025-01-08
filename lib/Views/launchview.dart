import 'package:flutter/material.dart';
import 'package:spacex/ViewModels/launchViewmodels.dart';
import 'package:spacex/views/launchDetailsView.dart';
import 'package:provider/provider.dart';
import 'package:spacex/Widget/SideMenu.dart';

class LaunchView extends StatelessWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LaunchViewModel>(
      create: (_) => LaunchViewModel()..fetchLaunches(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List of Launch'),
        ),
        drawer: SideMenu(), 
        body: Consumer<LaunchViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.launches.isEmpty) {
              return const Center(child: Text('No launches available'));
            } else {
              return ListView.builder(
                itemCount: viewModel.launches.length,
                itemBuilder: (context, index) {
                  final launch = viewModel.launches[index];
                  return ListTile(
                    title: Text(launch.name),
                    subtitle: Text(launch.date),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaunchDetailsView(
                            launchId: launch.id, 
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

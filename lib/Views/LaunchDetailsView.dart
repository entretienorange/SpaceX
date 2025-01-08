import 'package:flutter/material.dart';
import 'package:spacex/models/launches.dart';
import 'package:spacex/ViewModels/launchViewmodels.dart';
import 'package:provider/provider.dart';

class LaunchDetailsView extends StatelessWidget {
  final String launchId;

  const LaunchDetailsView({Key? key, required this.launchId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launch details'),
      ),
      body: FutureBuilder<Launch>(
        future: Provider.of<LaunchViewModel>(context, listen: false)
            .fetchLaunchById(launchId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Aucun détail disponible.'));
          }

          final launch = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  launch.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Date de lancement: ${launch.date}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  'Détails: ${launch.details}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

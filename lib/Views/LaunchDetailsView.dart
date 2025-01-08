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
        centerTitle: true, 
        title: const Text('Launch Details'),
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

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0), 
                    child: Text(
                      launch.name,
                      textAlign: TextAlign.center, 
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0), 
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Date de lancement: ',
                            style: TextStyle(
                              color: Colors.red, 
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: launch.date,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0), 
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Détails: ',
                            style: TextStyle(
                              color: Colors.red, 
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: launch.details,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

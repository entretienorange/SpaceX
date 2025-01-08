import 'package:flutter/material.dart';
import '../services/missionService.dart';
import '../models/missions.dart';

class MissionDetailsView extends StatefulWidget {
  final String missionId;

  const MissionDetailsView({Key? key, required this.missionId}) : super(key: key);

  @override
  _MissionDetailsViewState createState() => _MissionDetailsViewState();
}

class _MissionDetailsViewState extends State<MissionDetailsView> {
  late Future<Mission> _missionDetails;

  @override
  void initState() {
    super.initState();
    _missionDetails = MissionService().fetchMissionById(widget.missionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission details',textAlign: TextAlign.center),
      ),
      body: FutureBuilder<Mission>(
        future: _missionDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final mission = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mission.missionName,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ID Mission: ${mission.missionId}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    mission.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Aucune mission trouvée.'));
          }
        },
      ),
    );
  }
}

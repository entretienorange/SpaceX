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
        centerTitle: true,
        title: const Text('Mission Details'),
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
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0), 
                      child: Text(
                        mission.missionName,
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
                              text: 'ID Mission: ',
                              style: TextStyle(
                                color: Colors.red, 
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: mission.missionId,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0), 
                      child: Text(
                        mission.description,
                        textAlign: TextAlign.center, 
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
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

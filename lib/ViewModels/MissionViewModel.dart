import 'package:flutter/material.dart';
import 'package:spacex/services/missionService.dart';
import '../models/missions.dart';

class MissionViewModel extends ChangeNotifier {
  final MissionService _missionService = MissionService();

  List<Mission> _missions = [];
  Mission? _selectedMission;
  bool _isLoading = false;
  List<Mission> get missions => _missions;
  Mission? get selectedMission => _selectedMission;
  bool get isLoading => _isLoading;

  Future<void> fetchMissions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _missions = await _missionService.fetchMissions();
    } catch (e) {
      _missions = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMissionById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedMission = await _missionService.fetchMissionById(id);
    } catch (e) {
      _selectedMission = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSelectedMission() {
    _selectedMission = null;
    notifyListeners();
  }
}

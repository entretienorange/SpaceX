import 'package:flutter/foundation.dart';
import 'package:spacex/models/launches.dart';
import 'package:spacex/services/launchService.dart';

class LaunchViewModel extends ChangeNotifier {
  final LaunchService _launchService = LaunchService();

  List<Launch> _launches = [];
  bool _isLoading = false;

  List<Launch> get launches => _launches;
  bool get isLoading => _isLoading;

  Future<void> fetchLaunches() async {
    _isLoading = true;
    notifyListeners();

    try {
      _launches = await _launchService.fetchLaunches();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching launches: $e');
      }
      _launches = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Launch> fetchLaunchById(String id) async {
    try {
      return await _launchService.fetchLaunchById(id);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching launch details: $e');
      }
      rethrow; 
    }
  }
}

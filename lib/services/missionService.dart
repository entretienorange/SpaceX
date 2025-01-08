import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex/models/missions.dart';
import 'package:spacex/services/apiConstants.dart';

class MissionService {
  Future<List<Mission>> fetchMissions() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/missions');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Log the raw response data
        print("Raw response data: $data");
        return data.map((json) => Mission.fromJson(json)).toList();
      } else {
        throw Exception('err fetch missions: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('err fetching: $e');
    }
  }

  Future<Mission> fetchMissionById(String id) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/missions/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Log the raw response data
        print("Raw response data by ID: $data");
        return Mission.fromJson(data);
      } else {
        throw Exception('err fetch details: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('err fetch details: $e');
    }
  }
}
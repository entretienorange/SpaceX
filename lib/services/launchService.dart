import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex/models/launches.dart';
import 'package:spacex/services/apiConstants.dart';


class LaunchService {
  Future<List<Launch>> fetchLaunches() async {
  final url = Uri.parse('${ApiConstants.baseUrl}/launches');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) {
        try {
          return Launch.fromJson(json);
        } catch (e) {
          print('Erreur de parsing pour l\'élément $json : $e');
          throw Exception('Erreur dans le parsing des données');
        }
      }).toList();
    } else {
      throw Exception('Erreur de récupération: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erreur de récupération : $e');
  }
}

  Future<Launch> fetchLaunchById(String id) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/launches/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Launch.fromJson(data);
      } else {
        throw Exception('Erreur de récupération: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de récupération : $e');
    }
  }
}

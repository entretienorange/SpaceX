import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex/models/missions.dart';
import 'package:spacex/services/apiConstants.dart';
import 'dart:io';

class MissionService {
  Future<List<Mission>> fetchMissions() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/missions');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("Donnees de la réponse: $data");
        return data.map((json) {
          try {
            return Mission.fromJson(json);
          } catch (e) {
            print('Erreur de elément $json : $e');
            throw Exception('Erreur d données');
          }
        }).toList();
      } else {
        throw Exception('Erreur de récupération des missions : ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Erreur de connexion');
      } else if (e is FormatException) {
        throw Exception('Erreur de format des données');
      } else {
        throw Exception('Une erreur inconn : $e');
      }
    }
  }
  Future<Mission> fetchMissionById(String id) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/missions/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print("Donnée de  réponse  $data");
        return Mission.fromJson(data);
      } else {
        throw Exception('Erreur de récupération des détails  $id : ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Erreur de connexion');
      } else if (e is FormatException) {
        throw Exception('Erreur de format des données');
      } else {
        throw Exception('Une erreur inconn: $e');
      }
    }
  }
}

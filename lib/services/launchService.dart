import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex/models/launches.dart';
import 'package:spacex/services/apiConstants.dart';
import 'dart:io';

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
            print('Erreur de elément $json : $e');
            throw Exception('Erreur d données');
          }
        }).toList();
      } else {
        throw Exception('Erreur de récupération des données : ${response.statusCode}');
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

  Future<Launch> fetchLaunchById(String id) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/launches/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Launch.fromJson(data);
      } else {
        throw Exception('Erreur de récupération des détails $id : ${response.statusCode}');
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

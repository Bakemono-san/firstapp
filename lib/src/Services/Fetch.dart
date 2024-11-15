import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firstapp/src/Views/Pages/login.dart';
import 'package:firstapp/src/ResponseDtos/ReponseDto.dart';
import 'package:firstapp/src/Services/TokenManager.dart';

class Fetch {

  static Future<dynamic> fetchUsers(String uri) async {
    final response =
        await http.get(Uri.parse('https://waveclone-app-latest.onrender.com/$uri'), headers: {
      'Authorization':
          'Bearer ${await TokenManager.getToken()}'
    });

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response and convert to List<User>
      var jsonData =
          json.decode(response.body);
      print("datas $jsonData");
      return jsonData;
    } else {
      print("failed to load datas " + response.body);
      // Throw an exception if the request failed
      throw Exception('Failed to load users');
    }
  }

  static Future<dynamic> postDatas(
      String uri, Map<String, dynamic> datas) async {
    final response = await http.post(
      Uri.parse('https://waveclone-app-latest.onrender.com/$uri'),
      headers: {
        'Authorization': 'Bearer ${await TokenManager.getToken()}',
        'Content-Type': 'application/json'
      },
      body: json.encode(datas),
    );

    // Check if the response body is not empty
    if (response.body.isNotEmpty) {
      try {
        var res = json.decode(response.body); // Attempt to parse JSON response
        return ReponseDto.fromJson(res);
      } catch (e) {
        print("JSON Decode Error: $e");
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Empty response body');
    }
  }

  static Future<LoginResponse> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://waveclone-app-latest.onrender.com/auth/login'),
    headers: {
      'Content-Type': 'application/json'
    },
    body: json.encode({
      "email": email,
      "password": password
    }),
  );

  if (response.body.isNotEmpty) {
    try {
      var res = json.decode(response.body);

      // Safely check for null and convert to String
      var solde = res['data']['solde'] != null ? res['data']['solde'] : 0.0;
      print("Response body: ${res}");

      TokenManager.saveToken(res['data']['token']);
      TokenManager.saveSolde(solde); // Save the string representation of solde

      // Await the actual values of the token and solde
      String? token = await TokenManager.getToken();
      double? soldeAmount = await TokenManager.getSolde();

      print("Token: $token");
      print("Solde: $soldeAmount");

      // Create a User object from the response data
      res['data'].remove('solde');
      print("User data: ${res}");

      return LoginResponse.fromJson(res);
    } catch (e) {
      print("JSON Decode Error: $e");
      throw Exception('Invalid JSON format');
    }
  } else {
    throw Exception('Empty response body');
  }
}

}

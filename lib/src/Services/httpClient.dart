import 'dart:convert';
import 'package:firstapp/src/Services/ClientInterface.dart';
import 'package:http/http.dart' as http;
import 'package:firstapp/src/Services/TokenManager.dart';

class Httpclient implements ClientInterface<dynamic> {

  Future<dynamic> getData(String uri) async {
    final response =
        await http.get(Uri.parse('http://192.168.66.254:8080/$uri'), headers: {
      'Authorization':
          'Bearer ${await TokenManager.getToken()}'
    });

    if (response.statusCode == 200) {
      var jsonData =
          json.decode(response.body);
      print("datas $jsonData");
      return jsonData;
    } else {
      print("failed to load datas " + response.body);
      throw Exception('Failed to load users');
    }
  }

  Future<dynamic> postData(String uri, Map<String, dynamic> datas) async {
    final response = await http.post(
      Uri.parse('http://192.168.66.254:8080/$uri'),
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
        return res;
      } catch (e) {
        print("JSON Decode Error: $e");
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Empty response body');
    }
  }

  @override
  Future<dynamic> putData(String uri, dynamic data) async {
    final response = await http.put(
      Uri.parse('http://192.168.66.254:8080/$uri'),
      headers: {
        'Authorization': 'Bearer ${await TokenManager.getToken()}',
        'Content-Type': 'application/json'
      },
      body: json.encode(data),
    );

    // Check if the response body is not empty
    if (response.body.isNotEmpty) {
      try {
        var res = json.decode(response.body); // Attempt to parse JSON response
        return res;
      } catch (e) {
        print("JSON Decode Error: $e");
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Empty response body');
    }
  }
  
  Future<dynamic> deleteData(String uri) async {
    final response = await http.delete(
      Uri.parse('http://192.168.66.254:8080/$uri'),
      headers: {
        'Authorization': 'Bearer ${await TokenManager.getToken()}',
        'Content-Type': 'application/json'
      },
    );

    // Check if the response body is not empty
    if (response.body.isNotEmpty) {
      try {
        var res = json.decode(response.body); // Attempt to parse JSON response
        return res;
      } catch (e) {
        print("JSON Decode Error: $e");
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Empty response body');
    }
  }

  Future<dynamic> patchData(String uri, dynamic data) async {
    final response = await http.patch(
      Uri.parse('http://192.168.66.254:8080/$uri'),
      headers: {
        'Authorization': 'Bearer ${await TokenManager.getToken()}',
        'Content-Type': 'application/json'
      },
      body: json.encode(data),
    );

    // Check if the response body is not empty
    if (response.body.isNotEmpty) {
      try {
        var res = json.decode(response.body); // Attempt to parse JSON response
        return res;
      } catch (e) {
        print("JSON Decode Error: $e");
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Empty response body');
    }
  }

}

import 'dart:convert';

import 'package:foodmobileapp/models/api_response.dart';
import 'package:foodmobileapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';

Future<ApiResponse> login(String? email, String? password) async {
  ApiResponse apiresponse = ApiResponse();
  try {
    var url = Uri.parse(loginUrl);
    var response = await http.post(url,
        headers: {'Accept': 'Application/json'},
        body: {'email': email, 'password': password});

    switch (response.statusCode) {
      case 200:
        apiresponse.data = User.fromJson(jsonDecode(response.body));
        break;

      case 403:
        apiresponse.message = jsonDecode(response.body)['message'];
        break;

      case 422:
        final messages = jsonDecode(response.body)['errors'];
        apiresponse.message = messages[messages.keys.elementAt(0)](0);
        break;
      default:
        apiresponse.message = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiresponse.message = serverError;
  }

  return apiresponse;
}

Future<ApiResponse> register(String? name, String? email, String? password,
    String? password_confirmation) async {
  ApiResponse apiresponse = ApiResponse();
  try {
    var url = Uri.parse(registerUrl);
    var response = await http.post(url, headers: {
      'Accept': 'Application/json'
    }, body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation
    });

    switch (response.statusCode) {
      case 200:
        apiresponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 403:
        apiresponse.message = jsonDecode(response.body)['message'];
        break;

      case 422:
        final messages = jsonDecode(response.body)['errors'];
        apiresponse.message = messages[messages.keys.elementAt(0)](0);
        break;
      default:
        apiresponse.message = somethingWentWrong;
    }
  } catch (e) {
    apiresponse.message = serverError;
  }

  return apiresponse;
}

Future<ApiResponse> getUserDetails() async {
  ApiResponse apiresponse = ApiResponse();
  try {
    var url = Uri.parse(userUrl);
    String token = await getToken();
    var response = await http.get(url, headers: {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiresponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 403:
        apiresponse.message = jsonDecode(response.body)['message'];
        break;

      case 422:
        final messages = jsonDecode(response.body)['errors'];
        apiresponse.message = messages[messages.keys.elementAt(0)](0);
        break;
      default:
        apiresponse.message = somethingWentWrong;
    }
  } catch (e) {
    apiresponse.message = serverError;
  }
  return apiresponse;
}



Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

Future<int> getUserid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId') ?? 2;
}

Future<int> getUserRoot() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('root') ?? 2;
}

Future<bool> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.remove('token');
}

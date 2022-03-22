import 'package:foodmobileapp/constant.dart';
import 'package:foodmobileapp/models/api_response.dart';
import 'package:foodmobileapp/models/post.dart';
import 'package:foodmobileapp/models/user.dart';
import 'package:foodmobileapp/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<ApiResponse> getPosts() async {
  ApiResponse apiresponse = ApiResponse();
  var url = Uri.parse(postUrl);
  String token = await getToken();
  try {
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
    });
    switch (response.statusCode) {
      case 200:
        apiresponse.data = jsonDecode(response.body)['posts']
            .map((p) => Post.fromJson(p))
            .toList();
        apiresponse.data as List<dynamic>;
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

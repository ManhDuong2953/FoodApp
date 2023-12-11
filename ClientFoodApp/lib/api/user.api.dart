import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUser {
  static String? baseUrl = "${dotenv.env['BASE_URL']}/users";

  static String postLoginEndpoint = '$baseUrl/login';
  static String postSignupEndpoint = '$baseUrl/signup';
  static String getUserEndpoint(int id) => '$baseUrl/info/$id';
  static String postAvatarUserEndpoint(int id) => '$baseUrl/upload/avartar/$id';
  static String postUpdateUserEndpoint = '$baseUrl/update/info';
}

import '../models/models.dart';

abstract class Scrapeme {
  static User? user;
  static const String baseURL = 'http://127.0.0.1:8000';
  static const String apiURL = '$baseURL/api';
  static const String googleClientID =
      "845761215634-qq4k35b5835jmpc427gni0n6ocd79m2i.apps.googleusercontent.com";
}

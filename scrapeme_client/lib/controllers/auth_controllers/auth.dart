import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapeme/services/api/api_service.dart';
import 'package:scrapeme/utils/scrapeme.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this.apiService);
  final ApiService apiService;
  
  Future<bool> login(String email, String password) async {
    return await apiService.login(email, password);
  }

  Future<bool> signup(String name, String email, String password1, String passowrd2) async{
     Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password1,
      'password_confirmation': passowrd2
    };
    return await apiService.postRequest('${Scrapeme.appURL}/signup', data);
  }
}

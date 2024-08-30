import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scrapeme/utils/scrapeme.dart';

import '../services.dart';

Duration _timeout = const Duration(seconds: 15);

class ApiService {
  final CacheService _cacheService;

  ApiService(this._cacheService);

  Map<String, String> _headers() {
    String? token = _cacheService.accessToken;
    if (token == null) {
      throw UnAuthorizedException('No access token available');
    }
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<dynamic> _handleResponse(http.Response response, String url) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException('Invalid request', url);
      case 401:
        bool refreshed = await _refreshToken();
        if (refreshed) {
          return 'retry';
        } else {
          throw UnAuthorizedException('Unauthorized', url);
        }
      case 403:
        throw UnAuthorizedException('Access denied', url);
      case 429:
        throw TooManyRequestsException('Too many requests', url);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code: ${response.statusCode}', url);
    }
  }

  Future<bool> _refreshToken() async {
    String? refreshToken = _cacheService.refreshToken;
    bool isTokenExpired =
        refreshToken != null ? JwtDecoder.isExpired(refreshToken) : true;

    if (refreshToken == null) {
      throw UnAuthorizedException('No refresh token available');
    }
    if (isTokenExpired) {
      throw RefreshTokenExpiredException('Refresh token expired');
    }
    Uri uri = Uri.parse("${Scrapeme.appURL}/token/refresh");
    final response = await http.post(
      uri,
      body: jsonEncode({'refreshToken': refreshToken}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _cacheService.saveTokensToCache(accessToken: data['accessToken']);
      return true;
    } else {
      return false;
    }
  }
  
 
  Future<dynamic> login(String email, String password) async {
  try {
    final response = await postRequest('${Scrapeme.appURL}/login', {
      "email": email,
      "password": password,
    });
    return response;
  } catch (e) {
    throw FetchDataException('Failed to login: ${e.toString()}');
  }
}


  Future<dynamic> getRequest(String url) async {
    Uri uri = Uri.parse(url);
    final headers = _headers();

    http.Response response;
    try {
      response = await http.get(uri, headers: headers).timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);

    if (result == 'retry') {
      return await getRequest(url);
    } else {
      return result;
    }
  }

  Future<dynamic> postRequest(String url, dynamic body) async {
    Uri uri = Uri.parse(url);
    final headers = _headers();

    http.Response response;
    try {
      response = await http
          .post(uri, headers: headers, body: jsonEncode(body))
          .timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);

    if (result == 'retry') {
      return await postRequest(url, body);
    } else {
      return result;
    }
  }

  Future<dynamic> putRequest(String url, dynamic body) async {
    Uri uri = Uri.parse(url);
    final headers = _headers();

    http.Response response;
    try {
      response = await http
          .put(uri, headers: headers, body: jsonEncode(body))
          .timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);

    if (result == 'retry') {
      return await putRequest(url, body);
    } else {
      return result;
    }
  }

  Future<dynamic> patchRequest(String url, dynamic body) async {
    Uri uri = Uri.parse(url);
    final headers = _headers();

    http.Response response;
    try {
      response = await http
          .patch(uri, headers: headers, body: jsonEncode(body))
          .timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);

    if (result == 'retry') {
      return await patchRequest(url, body);
    } else {
      return result;
    }
  }

  Future<dynamic> deleteRequest(String url) async {
    Uri uri = Uri.parse(url);
    final headers = _headers();
    http.Response response;
    try {
      response = await http.delete(uri, headers: headers).timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);

    if (result == 'retry') {
      return await deleteRequest(url);
    } else {
      return result;
    }
  }
}

final apiServiceProvider = Provider<ApiService>(
  (ref) {
    final cacheService = ref.watch(cacheServiceProvider);
    return ApiService(cacheService);
  },
);

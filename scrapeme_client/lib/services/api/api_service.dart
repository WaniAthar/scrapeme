import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:scrapeme/utils/scrapeme.dart';
import 'package:scrapeme/widgets/toast_notification.dart';

import '../services.dart';

Duration _timeout = const Duration(seconds: 15);

class ApiService {
  final CacheService _cacheService;
  Logger log = Logger();

  ApiService(this._cacheService);

  Map<String, String> _headers() {
    String? token = _cacheService.accessToken;

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<dynamic> _handleResponse(http.Response response, String url) async {
    log.i("Response status code: ${jsonDecode(response.body)}");
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        if (response.body.contains('email')) {
          CustomToast.error(
              "Error!", jsonDecode(response.body)['errors']['email'][0]);
        }
        if (response.body.contains('password')) {
          CustomToast.error(
              "Error!", jsonDecode(response.body)['errors']['password'][0]);
        }
        if (response.body.contains('name')) {
          CustomToast.error(
              "Error!", jsonDecode(response.body)['errors']['name'][0]);
        }
        if (response.body.contains('password2')) {
          CustomToast.error(
              "Error!", jsonDecode(response.body)['errors']['password2'][0]);
        }
        return jsonDecode(response.body);
      case 401:
        if (response.body.contains('credentials')) {
          CustomToast.error("Error!", jsonDecode(response.body)['detail']);
          return jsonDecode(response.body);
        }
        bool refreshed = await refreshToken();
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

  Future<bool> refreshToken() async {
    String? refreshToken = _cacheService.refreshToken;
    bool isTokenExpired =
        refreshToken != null ? JwtDecoder.isExpired(refreshToken) : true;

    if (refreshToken == null) {
      throw UnAuthorizedException('No refresh token available');
    }
    if (isTokenExpired) {
      throw RefreshTokenExpiredException('Refresh token expired');
    }
    Uri uri = Uri.parse("${Scrapeme.apiURL}/token/refresh/");
    final response = await http.post(
      uri,
      body: jsonEncode({'refresh': refreshToken}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _cacheService.saveTokensToCache(accessToken: data['access']);
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getRequest(String url) async {
    Uri uri = Uri.parse("${Scrapeme.apiURL}$url/");
    final headers = _headers();

    http.Response response;
    try {
      log.d("GET REQUEST: $url");
      response = await http.get(uri, headers: headers).timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);
    log.d("GET RESPONSE $url: $result");

    if (result == 'retry') {
      return await getRequest(url);
    } else {
      return result;
    }
  }

  Future<dynamic> postRequest(String url, dynamic body) async {
    Uri uri = Uri.parse("${Scrapeme.apiURL}$url/");
    log.d(uri);
    final headers = _headers();

    http.Response response;
    try {
      log.d("POST REQUEST: $url, body: ${jsonEncode(body)}");
      response = await http
          .post(uri, headers: headers, body: jsonEncode(body))
          .timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);
    log.d("POST RESPONSE $url: $result");

    if (result == 'retry') {
      return await postRequest(url, body);
    } else {
      return result;
    }
  }

  Future<dynamic> putRequest(String url, dynamic body) async {
    Uri uri = Uri.parse("${Scrapeme.apiURL}$url/");
    final headers = _headers();

    http.Response response;
    try {
      log.d("PUT REQUEST: $url, body: $body");
      response = await http
          .put(uri, headers: headers, body: jsonEncode(body))
          .timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);
    log.d("PUT RESPONSE $url: $result");

    if (result == 'retry') {
      return await putRequest(url, body);
    } else {
      return result;
    }
  }

  Future<dynamic> patchRequest(String url, dynamic body) async {
    Uri uri = Uri.parse("${Scrapeme.apiURL}$url/");
    final headers = _headers();

    http.Response response;
    try {
      log.d("PATCH REQUEST: $url, body: $body");
      response = await http
          .patch(uri, headers: headers, body: jsonEncode(body))
          .timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);
    log.d("PATCH RESPONSE $url: $result");

    if (result == 'retry') {
      return await patchRequest(url, body);
    } else {
      return result;
    }
  }

  Future<dynamic> deleteRequest(String url) async {
    Uri uri = Uri.parse(Scrapeme.apiURL + url);
    final headers = _headers();
    http.Response response;
    try {
      log.d("DELETE REQUEST: $url");
      response = await http.delete(uri, headers: headers).timeout(_timeout);
    } catch (e) {
      throw FetchDataException('Failed to reach the server', url);
    }

    final result = await _handleResponse(response, url);
    log.d("DELETE RESPONSE $url: $result");

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

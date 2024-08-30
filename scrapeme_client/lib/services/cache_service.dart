import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CacheService {
  late SharedPreferences _prefs;
  CacheService(){
    _init();
  }
  Future<void>_init()async{
    _prefs = await SharedPreferences.getInstance();
    fetchTokensFromCache();
  }
  String? _accessToken;
  String? _refreshToken;
  String? _shortLivedToken;

  Future<void> fetchTokensFromCache() async {
    _accessToken = _prefs.getString("accessToken");
    _refreshToken = _prefs.getString("refreshToken");
    _shortLivedToken = _prefs.getString("shortLivedToken");
    debugPrint(
        'Access: $_accessToken, Refresh: $_refreshToken, ShortLived: $_shortLivedToken');
  }

  Future<void> saveTokensToCache(
      {String? accessToken,
      String? refreshToken,
      String? shortLivedToken}) async {
    if (accessToken != null && accessToken.isNotEmpty) {
      await _prefs.setString("accessToken", accessToken);
      _accessToken = accessToken;
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _prefs.setString("refreshToken", refreshToken);
      _refreshToken = refreshToken;
    }
    if (shortLivedToken != null && shortLivedToken.isNotEmpty) {
      await _prefs.setString("shortLivedToken", shortLivedToken);
      _shortLivedToken = shortLivedToken;
    }
  }

  Future<bool> clearTokens() async => await _prefs.clear();

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  String? get shortLivedToken => _shortLivedToken;

  bool get ifNoTokenExists => (_accessToken == null &&
      _refreshToken == null &&
      _shortLivedToken == null);

  bool? fetchBoolFromCache(String key) {
    final res = _prefs.getBool(key);
    debugPrint('get $key = $res ');
    return res;
  }

  String? fetchStringFromCache(String key) {
    final res = _prefs.getString(key);
    debugPrint('get $key = $res ');
    return res;
  }

  List<String>? fetchStringListFromCache(String key) {
    final res = _prefs.getStringList(key);
    debugPrint('get $key = $res ');
    return res;
  }

  int? fetchIntFromCache(String key) {
    final res = _prefs.getInt(key);
    debugPrint('get $key = $res ');
    return res;
  }

  double? fetchDoubleFromCache(String key) {
    final res = _prefs.getDouble(key);
    debugPrint('get $key = $res ');
    return res;
  }

  Future<bool> saveBoolToCache(String key, bool value) async {
    debugPrint("before save: key: $key, value: $value");
    final res = await _prefs.setBool(key, value);
    debugPrint('saved $key = $res ');
    return res;
  }

  Future<bool?> saveStringToCache({
    required String key,
    required String value,
  }) async {
    return await _prefs.setString(key, value);
  }

  Future<bool?> saveStringListToCache({
    required String key,
    required List<String> value,
  }) async {
    return await _prefs.setStringList(key, value);
  }

  Future<bool?> saveIntToCache({
    required String key,
    required int value,
  }) async {
    return await _prefs.setInt(key, value);
  }

  Future<bool?> saveDoubleToCache({
    required String key,
    required double value,
  }) async {
    return await _prefs.setDouble(key, value);
  }

  Future<bool> clearValue(String key) async => await _prefs.remove(key);
}

final cacheServiceProvider = Provider<CacheService>((ref) => CacheService());

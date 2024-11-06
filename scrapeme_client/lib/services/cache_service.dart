import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import '../models/models.dart';

class CacheService {
  late Box _cacheBox;
  // late Box<User> userBox;
  Logger log = Logger();

  CacheService() {
    _init();
  }

  Future<void> _init() async {
    _cacheBox = Hive.box('cacheBox');
    // Hive.registerAdapter(UserAdapter());
    // userBox = Hive.box<User>("userBox");

    await fetchTokensFromCache();
  }

  String? _accessToken;
  String? _refreshToken;
  String? _shortLivedToken;

  Future<void> fetchTokensFromCache() async {
    _accessToken = _cacheBox.get("accessToken");
    _refreshToken = _cacheBox.get("refreshToken");
    _shortLivedToken = _cacheBox.get("shortLivedToken");
    log.d(
        'Access: $_accessToken, Refresh: $_refreshToken, ShortLived: $_shortLivedToken');
  }

  Future<void> saveTokensToCache(
      {String? accessToken,
      String? refreshToken,
      String? shortLivedToken}) async {
    if (accessToken != null && accessToken.isNotEmpty) {
      await _cacheBox.put("accessToken", accessToken);
      _accessToken = accessToken;
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _cacheBox.put("refreshToken", refreshToken);
      _refreshToken = refreshToken;
    }
    if (shortLivedToken != null && shortLivedToken.isNotEmpty) {
      await _cacheBox.put("shortLivedToken", shortLivedToken);
      _shortLivedToken = shortLivedToken;
    }
    log.d(
        "Tokens saved access: $_accessToken, refresh: $_refreshToken, shortLived: $_shortLivedToken");
  }

  Future<void> clearTokens() async {
    await _cacheBox.delete("accessToken");
    await _cacheBox.delete("refreshToken");
    await _cacheBox.delete("shortLivedToken");
  }

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get shortLivedToken => _shortLivedToken;

  bool get ifNoTokenExists => (_accessToken == null &&
      _refreshToken == null &&
      _shortLivedToken == null);

  bool? fetchBoolFromCache(String key) {
    final res = _cacheBox.get(key);
    log.d('get $key = $res ');
    return res;
  }

  String? fetchStringFromCache(String key) {
    final res = _cacheBox.get(key);
    log.d('get $key = $res ');
    return res;
  }

  List<String>? fetchStringListFromCache(String key) {
    final res = _cacheBox.get(key)?.cast<String>();
    log.d('get $key = $res ');
    return res;
  }

  int? fetchIntFromCache(String key) {
    final res = _cacheBox.get(key);
    log.d('get $key = $res ');
    return res;
  }

  double? fetchDoubleFromCache(String key) {
    final res = _cacheBox.get(key);
    log.d('get $key = $res ');
    return res;
  }

  Future<void> saveBoolToCache(String key, bool value) async {
    log.d("before save: key: $key, value: $value");
    await _cacheBox.put(key, value);
    log.d('saved $key = $value ');
  }

  Future<void> saveStringToCache(
      {required String key, required String value}) async {
    await _cacheBox.put(key, value);
  }

  Future<void> saveStringListToCache(
      {required String key, required List<String> value}) async {
    await _cacheBox.put(key, value);
  }

  Future<void> saveIntToCache({required String key, required int value}) async {
    await _cacheBox.put(key, value);
  }

  Future<void> saveDoubleToCache(
      {required String key, required double value}) async {
    await _cacheBox.put(key, value);
  }

  Future<void> clearValue(String key) async {
    await _cacheBox.delete(key);
  }
}

final cacheServiceProvider = Provider<CacheService>((ref) => CacheService());

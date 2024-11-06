import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:scrapeme/models/models.dart';
import 'package:scrapeme/services/api/api_service.dart';
import 'package:scrapeme/services/cache_service.dart';
import 'package:scrapeme/widgets/toast_notification.dart';

import '../../utils/utils.dart';

class UserController extends StateNotifier<AsyncValue<User>> {
  UserController(this.apiService, this.cacheService)
      : super(const AsyncValue.loading());

  final ApiService apiService;
  final CacheService cacheService;
  Logger logger = Logger();
  Future<void> getUserProfile() async {
    const extUrl = '/profile';
    state = const AsyncValue.loading();
    try {
      Map<String, dynamic> res = await apiService.getRequest(extUrl);
      User user = User.fromMap(res['data']);
      Scrapeme.user = user;
      state = AsyncValue.data(user);

      logger.d("User fetched: $user");
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      CustomToast.error("Error!", "Error fetching user");
      logger.e("Error fetching user: $e");
    }
  }
}

final promptTextControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final userProvider = StateNotifierProvider<UserController, AsyncValue<User>>(
  (ref) {
    final cacheService = ref.watch(cacheServiceProvider);
    final apiService = ref.watch(apiServiceProvider);
    return UserController(apiService, cacheService);
  },
);

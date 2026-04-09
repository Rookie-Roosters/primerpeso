import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSession extends ChangeNotifier {
  AppSession._({required this.deviceId, required bool onboardingCompleted})
    : _onboardingCompleted = onboardingCompleted;

  static const _deviceIdKey = 'primerpeso.device_id';
  static const _onboardingCompletedKey = 'primerpeso.onboarding_completed';

  final String deviceId;
  bool _onboardingCompleted;

  bool get onboardingCompleted => _onboardingCompleted;

  static Future<AppSession> bootstrap() async {
    final prefs = await SharedPreferences.getInstance();
    final existingDeviceId = prefs.getString(_deviceIdKey);
    final deviceId = existingDeviceId ?? _generateDeviceId();
    if (existingDeviceId == null) {
      await prefs.setString(_deviceIdKey, deviceId);
    }

    return AppSession._(
      deviceId: deviceId,
      onboardingCompleted: prefs.getBool(_onboardingCompletedKey) ?? false,
    );
  }

  Future<void> completeOnboarding() async {
    if (_onboardingCompleted) return;
    _onboardingCompleted = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);
    notifyListeners();
  }
}

String _generateDeviceId() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return 'dev-${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}

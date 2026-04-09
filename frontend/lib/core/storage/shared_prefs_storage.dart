import 'package:shard/shard.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A [StateStorage] implementation backed by `SharedPreferences`.
///
/// Staged for use with `PersistentShard` once we want to remember things
/// like onboarding completion, theme overrides, or the user-facing
/// criterio score across launches. Not wired into any shard yet — kept
/// here so the contract is visible from day one and the day we need it
/// it's just an import away.
class SharedPrefsStorage implements StateStorage {
  SharedPrefsStorage._(this._prefs);

  final SharedPreferences _prefs;

  /// Resolves the singleton, awaiting the underlying preferences once.
  static Future<SharedPrefsStorage> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsStorage._(prefs);
  }

  @override
  Future<void> save(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> load(String key) async {
    return _prefs.getString(key);
  }
}

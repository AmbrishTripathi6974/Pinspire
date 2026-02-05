// Local storage service abstraction
// Wrapper around SharedPreferences for type-safe storage operations

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Abstract interface for local storage operations
///
/// This abstraction allows for:
/// - Easy testing with mock implementations
/// - Swapping storage backends without changing consuming code
abstract class LocalStorageService {
  /// Gets a string value by key
  String? getString(String key);

  /// Sets a string value
  Future<bool> setString(String key, String value);

  /// Gets a list of strings by key
  List<String>? getStringList(String key);

  /// Sets a list of strings
  Future<bool> setStringList(String key, List<String> value);

  /// Gets a boolean value by key
  bool? getBool(String key);

  /// Sets a boolean value
  Future<bool> setBool(String key, bool value);

  /// Gets an integer value by key
  int? getInt(String key);

  /// Sets an integer value
  Future<bool> setInt(String key, int value);

  /// Gets a JSON object by key (decoded from string)
  Map<String, dynamic>? getJson(String key);

  /// Sets a JSON object (encoded as string)
  Future<bool> setJson(String key, Map<String, dynamic> value);

  /// Gets a list of JSON objects by key
  List<Map<String, dynamic>>? getJsonList(String key);

  /// Sets a list of JSON objects
  Future<bool> setJsonList(String key, List<Map<String, dynamic>> value);

  /// Checks if a key exists
  bool containsKey(String key);

  /// Removes a value by key
  Future<bool> remove(String key);

  /// Clears all stored values
  Future<bool> clear();
}

/// SharedPreferences implementation of LocalStorageService
class SharedPreferencesStorageService implements LocalStorageService {
  const SharedPreferencesStorageService({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  final SharedPreferences _preferences;

  @override
  String? getString(String key) => _preferences.getString(key);

  @override
  Future<bool> setString(String key, String value) =>
      _preferences.setString(key, value);

  @override
  List<String>? getStringList(String key) => _preferences.getStringList(key);

  @override
  Future<bool> setStringList(String key, List<String> value) =>
      _preferences.setStringList(key, value);

  @override
  bool? getBool(String key) => _preferences.getBool(key);

  @override
  Future<bool> setBool(String key, bool value) =>
      _preferences.setBool(key, value);

  @override
  int? getInt(String key) => _preferences.getInt(key);

  @override
  Future<bool> setInt(String key, int value) => _preferences.setInt(key, value);

  @override
  Map<String, dynamic>? getJson(String key) {
    final jsonString = _preferences.getString(key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> setJson(String key, Map<String, dynamic> value) =>
      _preferences.setString(key, jsonEncode(value));

  @override
  List<Map<String, dynamic>>? getJsonList(String key) {
    final jsonString = _preferences.getString(key);
    if (jsonString == null) return null;

    try {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded.cast<Map<String, dynamic>>();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> setJsonList(String key, List<Map<String, dynamic>> value) =>
      _preferences.setString(key, jsonEncode(value));

  @override
  bool containsKey(String key) => _preferences.containsKey(key);

  @override
  Future<bool> remove(String key) => _preferences.remove(key);

  @override
  Future<bool> clear() => _preferences.clear();
}

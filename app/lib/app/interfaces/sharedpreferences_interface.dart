abstract class ISharedPreferences {
  Future<String> get(String key);
  Future delete(String key);
  Future put(String key, dynamic value);
}

import 'package:listadecompras/app/interfaces/sharedpreferences_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStoregeServices implements ISharedPreferences {
  Future<SharedPreferences> _futureSharedPreferences;
  SharedPreferences _sharedPreferences;

  SharedLocalStoregeServices() {
    _futureSharedPreferences = SharedPreferences.getInstance();
  }

  @override
  Future delete(String key) async {
    _sharedPreferences = await _futureSharedPreferences;
    _sharedPreferences.remove(key);
  }

  @override
  Future put(String key, value) async {
    _sharedPreferences = await _futureSharedPreferences;

    return _sharedPreferences.setString(key, value);
  }

  @override
  Future<String> get(String key) async {
    _sharedPreferences = await _futureSharedPreferences;

    return _sharedPreferences.getString(key);
  }
}

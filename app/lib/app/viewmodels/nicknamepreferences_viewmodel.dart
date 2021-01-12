import 'package:listadecompras/app/services/sharedprefences/shared_local_storege_services.dart';

class NickNamePreferencesViewModel {
  String _key = "nickname";
  SharedLocalStoregeServices _preferences = SharedLocalStoregeServices();

  static final NickNamePreferencesViewModel instance =
      NickNamePreferencesViewModel();

  Future getNickName() {
    return _preferences.get(_key);
  }

  setNickName(String name) async {
    await _preferences.put(_key, name);
  }
}

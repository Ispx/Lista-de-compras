import 'package:listadecompras/app/services/sharedprefences/shared_local_storege_services.dart';

class NickNamePreferencesViewModel {
  String _key = "nickname";
  String _nickName;
  SharedLocalStoregeServices _preferences = SharedLocalStoregeServices();

  static NickNamePreferencesViewModel instance = NickNamePreferencesViewModel();

  getNickName() {
    return _preferences.get(_key);
  }

  setNickName(String name) async {
    await _preferences.put(_key, name);
  }
}

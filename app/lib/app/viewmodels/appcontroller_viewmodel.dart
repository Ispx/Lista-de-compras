import 'package:listadecompras/app/viewmodels/nicknamepreferences_viewmodel.dart';

class AppControllerViewModel {
  NickNamePreferencesViewModel nickname = NickNamePreferencesViewModel.instance;

  static final AppControllerViewModel instance = AppControllerViewModel();
}

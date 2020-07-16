import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/ui/shared/themes.dart' as themes;


class SettingsPageViewModel extends ReactiveViewModel {
  bool _lightTheme = false;
  bool _notification= true;
  bool _newsletter = false;
  bool _special = false;
  bool _update = true;
  int index;

  ThemeData _light = themes.primaryMaterialTheme;
  ThemeData get light => _light;

  final NavigationService _navigationService = locator<NavigationService>();
  final _bussinessSettingService = locator<BussinessSettingService>();

  bool get lightTheme => _lightTheme;
  bool  get notification =>_notification ;
  bool get newsletter => _newsletter;
  bool get special => _special;
  bool get update => _update;
  int get langIndex => _bussinessSettingService.language;
  int get currIndex => _bussinessSettingService.currency;
  List get langs => _bussinessSettingService.langs;
  List get currs => _bussinessSettingService.currencies;


  setTheme() {
    if (_lightTheme == true) {
      _light = themes.primaryMaterialTheme;
      _lightTheme = !_lightTheme;
      _bussinessSettingService.setTheme(_lightTheme);
      notifyListeners();
    } else {
      _light = themes.darkMaterialTheme;
      _lightTheme = !_lightTheme;
      _bussinessSettingService.setTheme(_lightTheme);
      notifyListeners();
    }
  }

  void setNotification() {
    _notification = !_notification;
    _bussinessSettingService.setNotification(_notification);
    notifyListeners();
  }

  void setNewsletter() {
    _newsletter = !_newsletter;
    _bussinessSettingService.setNewsletter(_newsletter);
    notifyListeners();
  }

  void setSpecial() {
    _special = !_special;
    _bussinessSettingService.setSpecial(_special);
    notifyListeners();
  }

  void setUpdate() {
    _update = !_update;
    _bussinessSettingService.setUpdate(_update);
    notifyListeners();
  }

  void setIndex(int ind) {
    index = ind;
    print(index);
    notifyListeners();
  }

  Future navigateToCurrency() async {
     print(await getSetNotofication());
    await _navigationService.navigateTo(Routes.currencySettingsViewRoute);
  }

  Future navigateToAppLock() async {
    await _navigationService.navigateTo(Routes.appLockSettingsViewRoute);
  }

  Future navigateToLanguageSettings() async {
    await _navigationService.navigateTo(Routes.languageSettingsViewRoute);
  }

 Future< bool> getSetNotofication() async{
    bool value2=  await _bussinessSettingService.getSetNotification();
    print(value2);
    return value2;

  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_bussinessSettingService];
}

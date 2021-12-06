import 'package:bloc/bloc.dart';
import 'package:eshtri/shared/network/local/cache_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  bool _isDark = true;

  bool get isDark {
    return _isDark;
  }

  void toggleThemeMode([bool? fromPrefIsDark = null]) {
    if (fromPrefIsDark != null) {
      _isDark = fromPrefIsDark;
    } else {
      _isDark = !_isDark;
      emit(AppChangeThemeModeState());
      CacheHelper.setData(key: 'themeMode', value: _isDark);
    }
  }
}

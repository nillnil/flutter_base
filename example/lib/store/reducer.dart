import 'package:example/store/action.dart';
import 'package:example/store/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is PlatformAction) {
    return state.copyWith(targetPlatform: action.targetPlatform);
  } else if (action is ThemeAction) {
    return state.copyWith(primaryColor: action.primaryColor);
  }
  return const AppState();
}

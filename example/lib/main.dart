import 'dart:io' show Platform;

import 'package:example/app.dart';
import 'package:example/store/app_state.dart';
import 'package:example/store/reducer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  _setTargetPlatformForDesktop();
  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ]).then((_) {
    runApp(
      StoreProvider<AppState>(
        store: Store<AppState>(appReducer, initialState: AppState(
          targetPlatform: defaultTargetPlatform,
          primaryColor: Colors.indigo
        )),
        child: App(), 
      )
    );
  });
}

/// 适配桌面客户端，mac用ios，windows，linux用android
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}
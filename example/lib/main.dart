import 'dart:io' show Platform;

import 'package:example/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _setTargetPlatformForDesktop();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) {
    runApp(
      ChangeNotifierProvider<AppProvider>.value(
        value: AppProvider(
          brightness: WidgetsBinding.instance?.window.platformBrightness,
        ),
        child: const App(),
      ),
    );
  });
}

/// 适配桌面客户端，mac用ios，windows，linux用android
void _setTargetPlatformForDesktop() {
  TargetPlatform? targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

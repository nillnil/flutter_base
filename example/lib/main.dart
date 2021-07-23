import 'package:example/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
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

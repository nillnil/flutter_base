import 'package:base/app/base_app.dart';
import 'package:base/base.dart';
import 'package:base/theme/base_theme_data.dart';
import 'package:example/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, _) {
        CupertinoThemeData _cupertinoTheme = CupertinoTheme.of(context);
        _cupertinoTheme = _cupertinoTheme.copyWith(
          brightness: appProvider.brightness,
        );
        ThemeData _theme = ThemeData.light();
        ThemeData _darkTheme = ThemeData.dark();
        _theme = _theme.copyWith(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          // cupertinoOverrideTheme: _cupertinoTheme,
          textTheme: _theme.textTheme.copyWith(
            bodyText2: _theme.textTheme.bodyText2.copyWith(
              fontSize: 17.0,
              letterSpacing: -0.41,
            ),
          ),
          buttonTheme: _theme.buttonTheme.copyWith(
            // 使FlatButton, OutlineButton，RaisedButton等按钮跟CupertinoButton一样高
            height: 48.0,
          ),
          backgroundColor: const Color(0xFFEBEBEB),
          scaffoldBackgroundColor: const Color(0xFFF5F5FF),
        );
        _darkTheme = _darkTheme.copyWith(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          // cupertinoOverrideTheme: _cupertinoTheme,
          textTheme: _darkTheme.textTheme.copyWith(
            bodyText2: _darkTheme.textTheme.bodyText2.copyWith(
              fontSize: 17.0,
              letterSpacing: -0.41,
            ),
          ),
          buttonTheme: _darkTheme.buttonTheme.copyWith(
            // 使FlatButton, OutlineButton，RaisedButton等按钮跟CupertinoButton一样高
            height: 48.0,
          ),
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: const Color(0xFF191919),
          cardColor: const Color.fromARGB(255, 28, 28, 30),
          appBarTheme: _darkTheme.appBarTheme.copyWith(
            brightness: Brightness.dark,
          ),
        );
        return BaseApp(
          title: 'Base Example',
          cupertinoTheme: _cupertinoTheme,
          materialTheme: _theme,
          darkTheme: _darkTheme,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: const Locale('en', 'US'),
          supportedLocales: const <Locale>[
            Locale('zh', 'CN'),
            Locale('en', 'US')
          ],
          home: Home(),
          targetPlatform: appProvider.targetPlatform,
          baseTheme: BaseThemeData(
            // appBarHeight: 44.0,
            material: const <String, dynamic>{
              'appBarHeight': 56.0,
            },
            materialTheme: _theme,
            appBarTransitionBetweenRoutes: false,
            routeFullscreenGackGesture: true,
            // 默认值已修改成falase, 后续可能会删除这变量
            // appBarAutoSetLeadingColor: true,
            // // 默认值已修改成falase, 后续可能会删除这变量
            // appBarAutoSetTrailingColor: true,
            // // 默认值已修改成falase, 后续可能会删除这变量
            // appBarAutoSetBottomColor: true,
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    if (appProvider != null && brightness != appProvider.brightness) {
      appProvider.changeBrightness(brightness);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

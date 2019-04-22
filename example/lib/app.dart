
import 'package:base/app/base_app.dart';
import 'package:example/home.dart';
import 'package:example/store/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Color _backgroundColor = Color.fromRGBO(231, 231, 231, 1.0);
    return StoreConnector<AppState, Map<String, Object>>(
      converter: (Store<AppState> store) {
        return <String, Object>{
          'targetPlatform': store.state.targetPlatform,
          'primaryColor': store.state.primaryColor,
        };
      }, 
      builder: (BuildContext context, Map<String, Object> vm) {
        CupertinoThemeData _cupertinoTheme = CupertinoTheme.of(context);
        _cupertinoTheme = _cupertinoTheme.copyWith(
          primaryColor: vm['primaryColor'],
          barBackgroundColor: vm['primaryColor'],
          scaffoldBackgroundColor: _backgroundColor,
        );
        ThemeData _theme = Theme.of(context);
        _theme = _theme.copyWith(
          primaryColor: vm['primaryColor'],
          scaffoldBackgroundColor: _backgroundColor,
          cupertinoOverrideTheme: _cupertinoTheme,
          textTheme: _theme.textTheme.copyWith(
            body1: _theme.textTheme.body1.copyWith(
              fontSize: 17.0,
              letterSpacing: -0.41,
            ),
          ),
        );
        return BaseApp(
          title: 'Base Example',
          cupertinoTheme: _cupertinoTheme,
          materialTheme: _theme,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: const Locale('en', 'US'),
          supportedLocales: const <Locale>[ Locale('zh', 'CN'), Locale('en', 'US')],
          home: Home(),
          targetPlatform: vm['targetPlatform'],
          debugShowCheckedModeBanner: false
        );
      },
    );
  }
}

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
    Color _backgroundColor = Color.fromRGBO(231, 231, 231, 1.0);
    return StoreConnector<AppState, Map<String, Object>>(
      converter: (Store store) {
        return {
          'targetPlatform': store.state.targetPlatform,
          'primaryColor': store.state.primaryColor
        };
      }, 
      builder: (BuildContext context, Map<String, Object> vm) {
        return BaseApp(
          title: 'Base Example',
          cupertinoTheme: CupertinoThemeData(
            primaryColor: vm['primaryColor'],
            barBackgroundColor: vm['primaryColor'],
            scaffoldBackgroundColor: _backgroundColor,
          ),
          materialTheme: Theme.of(context).copyWith(
            primaryColor: vm['primaryColor'],
            scaffoldBackgroundColor: _backgroundColor
            // cupertinoOverrideTheme: _cupertinoThemeData,
            // textTheme: Theme.of(context).textTheme.copyWith(
            //   body1: TextStyle(
            //     fontSize: 16
            //   )
            // )
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: Locale('en', 'US'),
          supportedLocales: [ Locale('zh', 'CN'), Locale('en', 'US')],
          home: Home(),
          targetPlatform: vm['targetPlatform'],
          debugShowCheckedModeBanner: false
        );
      },
    );
  }
}
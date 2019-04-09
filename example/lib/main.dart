import 'dart:io' show Platform;

import 'package:example/demos/app_bar_demo.dart';
import 'package:example/demos/button_demo.dart';
import 'package:example/demos/demo.dart';
import 'package:example/demos/dialog_demo.dart';
import 'package:example/demos/page_demo.dart';
import 'package:example/demos/route_demo.dart';
import 'package:example/demos/section/section_demo.dart';
import 'package:example/demos/tab_demo.dart';
import 'package:example/iconfont/iconfont.dart';
import 'package:example/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:base/base.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  _setTargetPlatformForDesktop();
  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ]).then((_) {
    runApp(App());
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

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = Color.fromRGBO(231, 231, 231, 1.0);
    return BaseApp(
      title: 'Base Example',
      cupertinoTheme: CupertinoThemeData(
        primaryColor: Colors.black87,
        barBackgroundColor: Colors.black87,
        scaffoldBackgroundColor: _backgroundColor
      ),
      materialTheme: ThemeData(
        primaryColor: Colors.indigoAccent,
        scaffoldBackgroundColor: _backgroundColor
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: Locale('en', 'US'),
      supportedLocales: [ Locale('zh', 'CN'), Locale('en', 'US')],
      home: Home(title: 'Base Example')
    );
  }

}

class Home extends StatelessWidget {

  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      Demo(
        icon: BaseIcon(icon: IconFont.rows, size: 40, color: Colors.redAccent),
        title: Text('Section', style: TextStyle(color: Colors.redAccent)),
        page: SectionDemo()
      ),
      Demo(
        icon: BaseIcon(icon: IconFont.nav, size: 40, color: Colors.orangeAccent),
        title: Text('AppBar', style: TextStyle(color: Colors.orangeAccent)),
        page: AppBarDemo()
      ),
      Demo(
        icon: BaseIcon(icon: IconFont.page, size: 40, color: Colors.blueAccent),
        title: Text('Page', style: TextStyle(color: Colors.blueAccent)),
        page: PageDemo()
      ),
      Demo(
        icon: BaseIcon(icon: IconFont.tab, size: 40, color: Colors.pinkAccent),
        title: Text('Tab', style: TextStyle(color: Colors.pinkAccent)),
        page: TabDemo()
      ),
      Demo(
        icon: BaseIcon(icon: IconFont.dialog, size: 40, color: Colors.purpleAccent),
        title: Text('Dialog', style: TextStyle(color: Colors.purpleAccent)),
        page: DialogDemo()
      ),
      Demo(
        icon: BaseIcon(icon: IconFont.buttons, size: 40, color: Colors.greenAccent),
        title: Text('Button', style: TextStyle(color: Colors.greenAccent)),
        page: ButtonDemo()
      ),
      Demo(
        icon: BaseIcon(icon: IconFont.routes, size: 40, color: Colors.deepOrangeAccent),
        title: Text('Routes', style: TextStyle(color: Colors.deepOrangeAccent)),
        page: RouteDemo()
      )
    ];
    return BasePage(
      appBar: BaseNavBar(
        title: Text(title),
        border: null,
        padding: EdgeInsetsDirectional.only(start: 5.0, end: 5.0),
        actions: [
          BaseButton(
            padding: EdgeInsets.zero,
            child: Icon(IconFont.settings, size: 20),
            onPressed: () {
              BaseRoute(Settings()).push(context);
            }
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 3,
          children: _children,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0
        )
      )
    );
  }
}

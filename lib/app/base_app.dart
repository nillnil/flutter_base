import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';
import '../platform/platform.dart';
import '../theme/base_theme.dart';
import '../theme/base_theme_data.dart';

/// BaseAppBar
/// theme, use cupertinoTheme by cupertino，use materialTheme by material.
/// use CupertinoApp by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use MaterialApp on cuperitno.
/// use MaterialApp by material
/// *** use material = { forceUseCupertino: true } force use CupertinoApp on material.
class BaseApp extends BaseStatelessWidget {
  BaseApp({
    Key baseKey,
    this.key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.targetPlatform,
    this.baseTheme,
    this.cupertinoTheme,
    this.withoutSplashOnCupertino = true,
    this.materialTheme,
    this.dartTheme,
    this.debugShowMaterialGrid = false,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** general properties start ***

  @override
  final Key key;

  /// [CupertinoApp.navigatorKey]
  /// or
  /// [MaterialApp.navigatorKey]
  final Key navigatorKey;

  /// [CupertinoApp.home]
  /// or
  /// [Material.home]
  final Widget home;

  /// [CupertinoApp.routes]
  /// or
  /// [MaterialApp.routes]
  final Map<String, WidgetBuilder> routes;

  /// [CupertinoApp.initialRoute]
  /// or
  /// [MaterialApp.initialRoute]
  final String initialRoute;

  /// [CupertinoApp.onGenerateRoute]
  /// or
  /// [MaterialApp.onGenerateRoute]
  final RouteFactory onGenerateRoute;

  /// [CupertinoApp.onUnknownRoute]
  /// or
  /// [MaterialApp.onUnknownRoute]
  final RouteFactory onUnknownRoute;

  /// [CupertinoApp.navigatorObservers]
  /// or
  /// [MaterialApp.navigatorObservers]
  final List<NavigatorObserver> navigatorObservers;

  /// [CupertinoApp.builder]
  /// or
  /// [MaterialApp.builder]
  final TransitionBuilder builder;

  /// [CupertinoApp.title]
  /// or
  /// [MaterialApp.title]
  final String title;

  /// [CupertinoApp.onGenerateTitle]
  /// or
  /// [MaterialApp.onGenerateTitle]
  final GenerateAppTitle onGenerateTitle;

  /// [CupertinoApp.color]
  /// or
  /// [MaterialApp.color]
  final Color color;

  /// [CupertinoApp.locale]
  /// or
  /// [MaterialApp.locale]
  final Locale locale;

  /// [CupertinoApp.localizationsDelegates]
  /// or
  /// [MaterialApp.localizationsDelegates]
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  /// [CupertinoApp.localeListResolutionCallback]
  /// or
  /// [MaterialApp.localeListResolutionCallback]
  final LocaleListResolutionCallback localeListResolutionCallback;

  /// [CupertinoApp.localeResolutionCallback]
  /// or
  /// [MaterialApp.localeResolutionCallback]
  final LocaleResolutionCallback localeResolutionCallback;

  /// [CupertinoApp.supportedLocales]
  /// or
  /// [MaterialApp.supportedLocales]
  final Iterable<Locale> supportedLocales;

  /// [CupertinoApp.showPerformanceOverlay]
  /// or
  /// [MaterialApp.showPerformanceOverlay]
  final bool showPerformanceOverlay;

  /// [CupertinoApp.checkerboardRasterCacheImages]
  /// or
  /// [MaterialApp.checkerboardRasterCacheImages]
  final bool checkerboardRasterCacheImages;

  /// [CupertinoApp.checkerboardOffscreenLayers]
  /// or
  /// [MaterialApp.checkerboardOffscreenLayers]
  final bool checkerboardOffscreenLayers;

  /// [CupertinoApp.showSemanticsDebugger]
  /// or
  /// [MaterialApp.showSemanticsDebugger]
  final bool showSemanticsDebugger;

  /// [CupertinoApp.debugShowCheckedModeBanner]
  /// or
  /// [MaterialApp.debugShowCheckedModeBanner]
  final bool debugShowCheckedModeBanner;

  /// [basePlatform]
  final TargetPlatform targetPlatform;

  /// [BaseThemeData]
  final BaseThemeData baseTheme;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoApp.theme]
  final CupertinoThemeData cupertinoTheme;

  /// [withoutSplashOnCupertino], default is true
  /// 
  /// forbidden ripple effect on cupertino mode
  /// 
  /// 在cupertino模式下是否禁用水波纹效果
  final bool withoutSplashOnCupertino;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [MaterialApp.theme]
  final ThemeData materialTheme;

  /// [MaterialApp.dartTheme]
  final ThemeData dartTheme;

  /// [MaterialApp.debugShowMaterialGrid]
  final bool debugShowMaterialGrid;

  /// *** material properties end ***

  @override
  void buildBefore(BuildContext context) {
    super.buildBefore(context);
    // 设置目标平台
    setPlatform(
      targetPlatform: targetPlatform,
      withoutSplashOnCupertino: withoutSplashOnCupertino,
    );
  }

  @override
  Widget buildByCupertino(BuildContext context) {
    final BaseThemeData baseThemeData = valueFromCupertino(
          'baseTheme',
          baseTheme,
        ) ??
        BaseThemeData();
    return BaseTheme(
      data: baseThemeData,
      child: CupertinoApp(
        key: valueFromCupertino('key', key),
        navigatorKey: valueFromCupertino('navigatorKey', navigatorKey),
        home: valueFromCupertino('home', home),
        theme: cupertinoTheme,
        routes: valueFromCupertino('routes', routes),
        initialRoute: valueFromCupertino('initialRoute', initialRoute),
        onGenerateRoute: valueFromCupertino('onGenerateRoute', onGenerateRoute),
        onUnknownRoute: valueFromCupertino('onUnknownRoute', onUnknownRoute),
        navigatorObservers: valueFromCupertino(
          'navigatorObservers',
          navigatorObservers,
        ),
        builder: valueFromCupertino('builder', builder),
        title: valueFromCupertino('title', title),
        onGenerateTitle: valueFromCupertino('onGenerateTitle', onGenerateTitle),
        color: valueFromCupertino('color', color),
        locale: valueFromCupertino('locale', locale),
        localizationsDelegates: valueFromCupertino(
          'localizationsDelegates',
          localizationsDelegates,
        ),
        localeListResolutionCallback: valueFromCupertino(
          'localeListResolutionCallback',
          localeListResolutionCallback,
        ),
        localeResolutionCallback: valueFromCupertino(
          'localeResolutionCallback',
          localeResolutionCallback,
        ),
        supportedLocales: valueFromCupertino(
          'supportedLocales',
          supportedLocales,
        ),
        showPerformanceOverlay: valueFromCupertino(
          'showPerformanceOverlay',
          showPerformanceOverlay,
        ),
        checkerboardRasterCacheImages: valueFromCupertino(
          'checkerboardRasterCacheImages',
          checkerboardRasterCacheImages,
        ),
        checkerboardOffscreenLayers: valueFromCupertino(
          'checkerboardOffscreenLayers',
          checkerboardOffscreenLayers,
        ),
        showSemanticsDebugger: valueFromCupertino(
          'showSemanticsDebugger',
          showSemanticsDebugger,
        ),
        debugShowCheckedModeBanner: valueFromCupertino(
          'debugShowCheckedModeBanner',
          debugShowCheckedModeBanner,
        ),
      ),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final BaseThemeData baseThemeData = valueFromCupertino(
          'baseTheme',
          baseTheme,
        ) ??
        BaseThemeData();
    return BaseTheme(
      data: baseThemeData,
      child: MaterialApp(
        key: valueFromMaterial('key', key),
        navigatorKey: valueFromMaterial('navigatorKey', navigatorKey),
        home: valueFromMaterial('home', home),
        routes: valueFromMaterial('routes', routes),
        initialRoute: valueFromMaterial('initialRoute', initialRoute),
        onGenerateRoute: valueFromMaterial('onGenerateRoute', onGenerateRoute),
        onUnknownRoute: valueFromMaterial('onUnknownRoute', onUnknownRoute),
        navigatorObservers: valueFromMaterial(
          'navigatorObservers',
          navigatorObservers,
        ),
        builder: valueFromMaterial('builder', builder),
        title: valueFromMaterial('title', title),
        onGenerateTitle: valueFromMaterial('onGenerateTitle', onGenerateTitle),
        color: valueFromMaterial('color', color),
        theme: valueFromMaterial('theme', materialTheme),
        darkTheme: dartTheme,
        locale: valueFromMaterial('locale', locale),
        localizationsDelegates: valueFromMaterial(
          'localizationsDelegates',
          localizationsDelegates,
        ),
        localeListResolutionCallback: valueFromMaterial(
          'localeListResolutionCallback',
          localeListResolutionCallback,
        ),
        localeResolutionCallback: valueFromMaterial(
          'localeResolutionCallback',
          localeResolutionCallback,
        ),
        supportedLocales:
            valueFromMaterial('supportedLocales', supportedLocales),
        showPerformanceOverlay: valueFromMaterial(
          'showPerformanceOverlay',
          showPerformanceOverlay,
        ),
        checkerboardRasterCacheImages: valueFromMaterial(
          'checkerboardRasterCacheImages',
          checkerboardRasterCacheImages,
        ),
        checkerboardOffscreenLayers: valueFromMaterial(
          'checkerboardOffscreenLayers',
          checkerboardOffscreenLayers,
        ),
        showSemanticsDebugger: valueFromMaterial(
          'showSemanticsDebugger',
          showSemanticsDebugger,
        ),
        debugShowCheckedModeBanner: valueFromMaterial(
          'debugShowCheckedModeBanner',
          debugShowCheckedModeBanner,
        ),
        debugShowMaterialGrid: valueFromMaterial(
          'debugShowMaterialGrid',
          debugShowMaterialGrid,
        ),
      ),
    );
  }
}

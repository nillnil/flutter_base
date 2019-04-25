import 'package:base/base_stateless_widget.dart' show BaseStatelessWidget;
import 'package:base/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/material.dart';

/// 基础App
/// theme, cupertino使用cupertinoTheme参数，material使用materialTheme参数，当useMaterialTheme=true时，cupertino也使用materialTheme参数
/// cupertino，使用CupertinoApp
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用MaterialApp
/// material，使用MaterialApp
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoApp
class BaseApp extends BaseStatelessWidget {
  BaseApp({
    Key key,
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
    this.cupertinoTheme,
    this.withoutSplashOnCupertino = true,
    this.materialTheme,
    this.dartTheme,
    this.debugShowMaterialGrid = false,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  // general
  final Key navigatorKey;
  final Widget home;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder builder;
  final String title;
  final GenerateAppTitle onGenerateTitle;
  final Color color;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleListResolutionCallback localeListResolutionCallback;
  final LocaleResolutionCallback localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final TargetPlatform targetPlatform;

  // cupertino
  final CupertinoThemeData cupertinoTheme;
  // 在cupertino模式下是否禁用水波纹效果，默认true
  final bool withoutSplashOnCupertino;

  // materialApp
  final ThemeData materialTheme;
  final ThemeData dartTheme;
  final bool debugShowMaterialGrid;

  @override
  void buildBefore(BuildContext context) {
    super.buildBefore(context);
    // 设置目标平台
    if (targetPlatform != null) {
      setPlatform(
        targetPlatform: targetPlatform,
      );
    }
  }

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoApp(
      navigatorKey: valueFromCupertino('navigatorKey', navigatorKey),
      home: valueFromCupertino('home', home),
      theme: cupertinoTheme,
      routes: valueFromCupertino('routes', routes),
      initialRoute: valueFromCupertino('initialRoute', initialRoute),
      onGenerateRoute: valueFromCupertino('onGenerateRoute', onGenerateRoute),
      onUnknownRoute: valueFromCupertino('onUnknownRoute', onUnknownRoute),
      navigatorObservers:
          valueFromCupertino('navigatorObservers', navigatorObservers),
      builder: valueFromCupertino('builder', builder),
      title: valueFromCupertino('title', title),
      onGenerateTitle: valueFromCupertino('onGenerateTitle', onGenerateTitle),
      color: valueFromCupertino('color', color),
      locale: valueFromCupertino('locale', locale),
      localizationsDelegates:
          valueFromCupertino('localizationsDelegates', localizationsDelegates),
      localeListResolutionCallback: valueFromCupertino(
          'localeListResolutionCallback', localeListResolutionCallback),
      localeResolutionCallback: valueFromCupertino(
          'localeResolutionCallback', localeResolutionCallback),
      supportedLocales:
          valueFromCupertino('supportedLocales', supportedLocales),
      showPerformanceOverlay:
          valueFromCupertino('showPerformanceOverlay', showPerformanceOverlay),
      checkerboardRasterCacheImages: valueFromCupertino(
          'checkerboardRasterCacheImages', checkerboardRasterCacheImages),
      checkerboardOffscreenLayers: valueFromCupertino(
          'checkerboardOffscreenLayers', checkerboardOffscreenLayers),
      showSemanticsDebugger:
          valueFromCupertino('showSemanticsDebugger', showSemanticsDebugger),
      debugShowCheckedModeBanner: valueFromCupertino(
          'debugShowCheckedModeBanner', debugShowCheckedModeBanner),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return MaterialApp(
      navigatorKey: valueFromMaterial('navigatorKey', navigatorKey),
      home: valueFromMaterial('home', home),
      routes: valueFromMaterial('routes', routes),
      initialRoute: valueFromMaterial('initialRoute', initialRoute),
      onGenerateRoute: valueFromMaterial('onGenerateRoute', onGenerateRoute),
      onUnknownRoute: valueFromMaterial('onUnknownRoute', onUnknownRoute),
      navigatorObservers:
          valueFromMaterial('navigatorObservers', navigatorObservers),
      builder: valueFromMaterial('builder', builder),
      title: valueFromMaterial('title', title),
      onGenerateTitle: valueFromMaterial('onGenerateTitle', onGenerateTitle),
      color: valueFromMaterial('color', color),
      theme: valueFromMaterial('theme', materialTheme),
      darkTheme: dartTheme,
      locale: valueFromMaterial('locale', locale),
      localizationsDelegates:
          valueFromMaterial('localizationsDelegates', localizationsDelegates),
      localeListResolutionCallback: valueFromMaterial(
          'localeListResolutionCallback', localeListResolutionCallback),
      localeResolutionCallback: valueFromMaterial(
          'localeResolutionCallback', localeResolutionCallback),
      supportedLocales: valueFromMaterial('supportedLocales', supportedLocales),
      showPerformanceOverlay:
          valueFromMaterial('showPerformanceOverlay', showPerformanceOverlay),
      checkerboardRasterCacheImages: valueFromMaterial(
          'checkerboardRasterCacheImages', checkerboardRasterCacheImages),
      checkerboardOffscreenLayers: valueFromMaterial(
          'checkerboardOffscreenLayers', checkerboardOffscreenLayers),
      showSemanticsDebugger:
          valueFromMaterial('showSemanticsDebugger', showSemanticsDebugger),
      debugShowCheckedModeBanner: valueFromMaterial(
          'debugShowCheckedModeBanner', debugShowCheckedModeBanner),
      debugShowMaterialGrid:
          valueFromMaterial('debugShowMaterialGrid', debugShowMaterialGrid),
    );
  }
}

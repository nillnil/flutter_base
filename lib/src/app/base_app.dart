import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_param.dart';
import '../base_stateless_widget.dart';
import '../config/base_config.dart' as config;
import '../mode/base_mode.dart';
import '../theme/base_theme.dart';
import '../theme/base_theme_data.dart';

/// BaseApp
/// theme, use cupertinoTheme by cupertino，use materialTheme by material.
/// use CupertinoApp by cupertino
/// not support CupertinoApp.router yet.
/// *** use cupertino = { forceUseMaterial: true } force use MaterialApp on cuperitno.
/// use MaterialApp by material
/// not support MaterialApp.router yet.
/// *** use material = { forceUseCupertino: true } force use CupertinoApp on material.
///
/// CupertinoApp: 2021.04.03
/// MaterialApp: 2021.04.02
/// modify 2021.06.25 by flutter 2.2.2
class BaseApp extends BaseStatelessWidget {
  const BaseApp({
    Key? key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
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
    this.restorationScopeId,
    this.scrollBehavior,
    this.basePlatformMode,
    this.baseTheme,
    this.shortcuts,
    this.actions,
    this.cupertinoTheme,
    this.withoutSplashOnCupertino = true,
    this.scaffoldMessengerKey,
    this.materialTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.debugShowMaterialGrid = false,
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  /// *** general properties start ***

  /// [CupertinoApp.navigatorKey]
  /// or
  /// [MaterialApp.navigatorKey]
  final GlobalKey<NavigatorState>? navigatorKey;

  /// [CupertinoApp.home]
  /// or
  /// [Material.home]
  final Widget? home;

  /// [CupertinoApp.routes]
  /// or
  /// [MaterialApp.routes]
  final Map<String, WidgetBuilder>? routes;

  /// [CupertinoApp.initialRoute]
  /// or
  /// [MaterialApp.initialRoute]
  final String? initialRoute;

  /// [CupertinoApp.onGenerateRoute]
  /// or
  /// [MaterialApp.onGenerateRoute]
  final RouteFactory? onGenerateRoute;

  /// [CupertinoApp.onGenerateInitialRoutes]
  /// or
  /// [MaterialApp.onGenerateInitialRoutes]
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// [CupertinoApp.onUnknownRoute]
  /// or
  /// [MaterialApp.onUnknownRoute]
  final RouteFactory? onUnknownRoute;

  /// [CupertinoApp.navigatorObservers]
  /// or
  /// [MaterialApp.navigatorObservers]
  final List<NavigatorObserver>? navigatorObservers;

  /// [CupertinoApp.builder]
  /// or
  /// [MaterialApp.builder]
  final TransitionBuilder? builder;

  /// [CupertinoApp.title]
  /// or
  /// [MaterialApp.title]
  final String title;

  /// [CupertinoApp.onGenerateTitle]
  /// or
  /// [MaterialApp.onGenerateTitle]
  final GenerateAppTitle? onGenerateTitle;

  /// [CupertinoApp.color]
  /// or
  /// [MaterialApp.color]
  final Color? color;

  /// [CupertinoApp.locale]
  /// or
  /// [MaterialApp.locale]
  final Locale? locale;

  /// [CupertinoApp.localizationsDelegates]
  /// or
  /// [MaterialApp.localizationsDelegates]
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// [CupertinoApp.localeListResolutionCallback]
  /// or
  /// [MaterialApp.localeListResolutionCallback]
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// [CupertinoApp.localeResolutionCallback]
  /// or
  /// [MaterialApp.localeResolutionCallback]
  final LocaleResolutionCallback? localeResolutionCallback;

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

  /// [BasePlatformMode]
  @Deprecated('instead of baseTheme.platformMode')
  final BasePlatformMode? basePlatformMode;

  /// [BaseThemeData]
  final BaseThemeData? baseTheme;

  /// [CupertinoApp.shortcuts]
  /// or
  /// [MaterialApp.shortcuts]
  final Map<LogicalKeySet, Intent>? shortcuts;

  /// [CupertinoApp.actions]
  /// or
  /// [MaterialApp.actions]
  final Map<LocalKey, Action<Intent>>? actions;

  /// [CupertinoApp.restorationScopeId]
  /// or
  /// [MaterialApp.restorationScopeId]
  final String? restorationScopeId;

  /// [CupertinoApp.scrollBehavior]
  /// or
  /// [MaterialApp.scrollBehavior]
  final ScrollBehavior? scrollBehavior;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoApp.theme]
  final CupertinoThemeData? cupertinoTheme;

  /// [withoutSplashOnCupertino], default is true
  ///
  /// forbidden ripple effect on cupertino mode
  ///
  /// 在cupertino模式下是否禁用水波纹效果
  final bool withoutSplashOnCupertino;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [MaterialApp.scaffoldMessengerKey]
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// [MaterialApp.theme]
  final ThemeData? materialTheme;

  /// [MaterialApp.darkTheme]
  final ThemeData? darkTheme;

  /// [MaterialApp.highContrastTheme]
  final ThemeData? highContrastTheme;

  /// [MaterialApp.highContrastDarkTheme]
  final ThemeData? highContrastDarkTheme;

  /// [MaterialApp.themeMode]
  final ThemeMode? themeMode;

  /// [MaterialApp.debugShowMaterialGrid]
  final bool debugShowMaterialGrid;

  /// *** material properties end ***

  @override
  void beforeBuild(BuildContext context) {
    /// 设置是否禁用水波纹
    if (baseTheme != null) {
      config.withoutSplashOnCupertino = baseTheme!.withoutSplashOnCupertino;
    }

    /// 设置平台模式
    setBasePlatformMode(
      basePlatformMode: baseTheme?.platformMode ?? basePlatformMode,
    );
  }

  @override
  Widget buildByCupertino(BuildContext context) {
    final BaseThemeData _baseTheme = (valueOf('baseTheme', baseTheme) ?? BaseThemeData()).copyWith(
      materialTheme: materialTheme,
      cupertinoTheme: cupertinoTheme,
    );
    return BaseTheme(
      data: _baseTheme,
      child: CupertinoApp(
        navigatorKey: valueOf('navigatorKey', navigatorKey),
        home: valueOf('home', home),
        theme: cupertinoTheme,
        routes: valueOf('routes', routes),
        initialRoute: valueOf('initialRoute', initialRoute),
        onGenerateRoute: valueOf('onGenerateRoute', onGenerateRoute),
        onGenerateInitialRoutes: valueOf('onGenerateInitialRoutes', onGenerateInitialRoutes),
        onUnknownRoute: valueOf('onUnknownRoute', onUnknownRoute),
        navigatorObservers: valueOf(
          'navigatorObservers',
          navigatorObservers,
        ),
        builder: valueOf('builder', builder),
        title: valueOf('title', title),
        onGenerateTitle: valueOf('onGenerateTitle', onGenerateTitle),
        color: valueOf('color', color),
        locale: valueOf('locale', locale),
        localizationsDelegates: valueOf(
          'localizationsDelegates',
          localizationsDelegates,
        ),
        localeListResolutionCallback: valueOf(
          'localeListResolutionCallback',
          localeListResolutionCallback,
        ),
        localeResolutionCallback: valueOf(
          'localeResolutionCallback',
          localeResolutionCallback,
        ),
        supportedLocales: valueOf(
          'supportedLocales',
          supportedLocales,
        ),
        showPerformanceOverlay: valueOf(
          'showPerformanceOverlay',
          showPerformanceOverlay,
        ),
        checkerboardRasterCacheImages: valueOf(
          'checkerboardRasterCacheImages',
          checkerboardRasterCacheImages,
        ),
        checkerboardOffscreenLayers: valueOf(
          'checkerboardOffscreenLayers',
          checkerboardOffscreenLayers,
        ),
        showSemanticsDebugger: valueOf(
          'showSemanticsDebugger',
          showSemanticsDebugger,
        ),
        debugShowCheckedModeBanner: valueOf(
          'debugShowCheckedModeBanner',
          debugShowCheckedModeBanner,
        ),
        shortcuts: valueOf('shortcuts', shortcuts),
        actions: valueOf('actions', actions),
        restorationScopeId: valueOf('restorationScopeId', restorationScopeId),
        scrollBehavior: valueOf('scrollBehavior', scrollBehavior),
      ),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final BaseThemeData _baseTheme = (valueOf('baseTheme', baseTheme) ?? BaseThemeData()).copyWith(
      materialTheme: materialTheme,
      cupertinoTheme: cupertinoTheme,
    );
    return BaseTheme(
      data: _baseTheme,
      child: MaterialApp(
        navigatorKey: valueOf('navigatorKey', navigatorKey),
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: valueOf('home', home),
        routes: valueOf('routes', routes),
        initialRoute: valueOf('initialRoute', initialRoute),
        onGenerateRoute: valueOf('onGenerateRoute', onGenerateRoute),
        onGenerateInitialRoutes: valueOf('onGenerateInitialRoutes', onGenerateInitialRoutes),
        onUnknownRoute: valueOf('onUnknownRoute', onUnknownRoute),
        navigatorObservers: valueOf(
          'navigatorObservers',
          navigatorObservers,
        ),
        builder: valueOf('builder', builder),
        title: valueOf('title', title),
        onGenerateTitle: valueOf('onGenerateTitle', onGenerateTitle),
        color: valueOf('color', color),
        theme: valueOf('materialTheme', materialTheme),
        darkTheme: valueOf('darkTheme', darkTheme),
        highContrastTheme: valueOf('highContrastTheme', highContrastTheme),
        highContrastDarkTheme: valueOf('highContrastDarkTheme', highContrastDarkTheme),
        themeMode: valueOf('themeMode', themeMode),
        locale: valueOf('locale', locale),
        localizationsDelegates: valueOf(
          'localizationsDelegates',
          localizationsDelegates,
        ),
        localeListResolutionCallback: valueOf(
          'localeListResolutionCallback',
          localeListResolutionCallback,
        ),
        localeResolutionCallback: valueOf(
          'localeResolutionCallback',
          localeResolutionCallback,
        ),
        supportedLocales: valueOf(
          'supportedLocales',
          supportedLocales,
        ),
        debugShowMaterialGrid: valueOf(
          'debugShowMaterialGrid',
          debugShowMaterialGrid,
        ),
        showPerformanceOverlay: valueOf(
          'showPerformanceOverlay',
          showPerformanceOverlay,
        ),
        checkerboardRasterCacheImages: valueOf(
          'checkerboardRasterCacheImages',
          checkerboardRasterCacheImages,
        ),
        checkerboardOffscreenLayers: valueOf(
          'checkerboardOffscreenLayers',
          checkerboardOffscreenLayers,
        ),
        showSemanticsDebugger: valueOf(
          'showSemanticsDebugger',
          showSemanticsDebugger,
        ),
        debugShowCheckedModeBanner: valueOf(
          'debugShowCheckedModeBanner',
          debugShowCheckedModeBanner,
        ),
        shortcuts: valueOf('shortcuts', shortcuts),
        actions: valueOf('actions', actions),
        restorationScopeId: valueOf('actions', restorationScopeId),
        scrollBehavior: valueOf('scrollBehavior', scrollBehavior),
      ),
    );
  }
}

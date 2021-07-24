<p align="center">
  <img src="https://github.com/nillnil/flutter_base/blob/master/screenshot/logo.png?raw=true" alt="logo">
</p>

<p align="center">
  <a href="https://flutter.io/" target="_blank">
    <img src="https://img.shields.io/badge/flutter-^2.2.2-3A91E3?logo=Flutter&style=flat" alt="Flutter">
  </a>
  <a href="https://www.dart.dev/" style="margin-left: 20px;" target="_blank">
    <img src="https://img.shields.io/badge/dart-^2.13.3-3A91E3?logo=Dart&style=flat" alt="Dart">
  </a>
</p>

# Introduction

* One code, two mode, use `Cupertino` style widgets on iOS or macOs, use `Material` style widgets on andriod、fuchsia、windows、linux、others platform. Web follows the Default style of the system, you can also personalize the modes used by each platform.
* At present, only the Cupertino mode is tested on IOS, and the material widget  is relatively perfect. Later, the material mode and other platform tests will be supplemented.

>  The stable branch is used, and the version is consistent with the version of flutter

## Installing

For some reasons,  on https://pub.dev/  is the older version，please use by github 

* This will add a line like this to your package's pubspec.yaml (and run an implicit `dart pub get`):

  ```yaml
  dependencies: 
    base:
      git:
        url: git://github.com/nillnil/flutter_base
        // branch name or tag name
        ref: x.x.x
  ```

* use `BaseXxx ` widgets instead of native widget s，The parameters are basically the same as the original ones, such as: BaseApp, BaseAppBar, BaseButton, and other widget s，If a parameter only exists in the `Cupertinoxx` widget  or the `Materialxxx` widget , it will only take effect in this mode

# Project structure

```javascript
lib/
  src/
    // BaseActionSheet, BaseActionSheetAction
    action_sheet/
    // BaseApp
    app/
    // BaseAppBar
    appbar/
    // BaseButton. BaseIconButton
    button/
    // Generic classes, BaseColor, BaseRandomColor
    common/
    // Generic components, BaseDrawer, BaseMaterialWidget
    components/
    // BaseAlertDialog, BaseAlertDialogAction, 
    dialog/
    // Modified the source code, CupertinoNavigationBar, AppBar
    // The directory will not be exported
    // it will only be used in the Base's widgets, and will not conflict with the original
    flutter/
    // BaseIcon
    icon/
    // BaseIndicator
    indicator/
    // BaseMode, BasePlatformMode
    mode/
    // BaseRefresh
    refresh/
    // BaseRoute
    route/
    // BaseScaffold, BaseTabScaffold
    scaffold/
    // BaseScrollBar
    scroll_bar/
    // BaseSection, BaseTile
    section/
    // BaseSlider
    slider/
    // BaseSwitch
    switch/
    // BaseTabBar, BaseBarItem
    tabbar/
    // BaseTextField
    text_field/
    // BaseTheme, BaseThemeData
    theme/
    // Tools
    tools/
  // Base's classes
  base_xxx.dart
```

# Feature

## Differentiated construction

> * The Baes widget  will determine whether to build with Cupertino's widget s or Material's widget s according to the configuration mode
> * Most of the widget s are native widget s prefixed with the Base name, such as BaseApp, which is built with CupertinoApp in `Cupertino` mode, and MaterialApp is built in `Material` mode. At the same time, you can use `isCupertinoMode, isMaterialMode`
>   These two methods determine the currently used mode and conduct differentiated construction.
> * Each Base widget  will have [BaseParam baseParam](#BaseParam),  which are used for differentiated construction in different modes, because the same parameter is under the Cupertino widget  and under the Material widget  There will be some inconsistencies in the performance, so you can also set personalized parameter values according to the platform. The order of parameter values is: platform parameters - > mode parameters - > common parameters

```dart
// Example
BaseIcon(
  // In materil mode, first take the icon parameter in the material parameter, and then take the value if it is not available
  icon: Icons.info,
  baseParam: BaseParam(
    // Cupertino's will take this value first
    cupertino: <String, dynamic>{
      'icon': CupertinoIcons.info,
    },
    // android although it is in material mode, this value will take first
    android: <String, dynamic>{
      'icon': CupertinoIcons.info,
    }
  )
);
```

  In Cupertino mode and android, CupertinoIcons.info is used, and in material mode and others platform, Icons.info is used

<img src="https://github.com/nillnil/flutter_base/blob/master/screenshot/features_demo.png?raw=true" alt="features_demo" width="256" height="78">

### forceUseCupertino、forceUseMaterial

> The `baseParam` parameters of each Base widget  will have two parameters `forceUseCupertino, forceUseMaterial`, which are used to force a certain mode to build the widget , the type is `Map<String, dynamic>`
>
> Since many Material widget s need to have the ancestor node of the Material widget , when using the `forceUseMaterial` parameter in the `Cupertino` mode, a layer of `Material` will be applied by Default, and the Material widget  will be removed when `BaseApp.withoutSplashOnCupertino = true` At this time, `BaseApp.theme` will not take effect, so `Theme.of(context)` cannot get the correct effect.
>
> `Please use it with caution! Use with caution! Use with caution! Avoid unpredictable bugs such as chaotic styles`

### disabled

> The `baseParam` parameters of each Base widget  will have the `disabledOnXxx` parameter, and if disabledOnXxx = true, Container() will be used instead

# Base component's base classes

## BaseMixin

Basic general class, there are four methods `beforeBuild`, `beforeBuildByMaterial`, `beforeBuildByCupertino`,  `valueOf`, `getBuildMode`. Among them, `beforeBuild`, `beforeBuildByMaterial`, and `beforeBuildByCupertino` are used for building.

BaseClass, BaseStatelessWidget, and BaseState will all be mixed into this class, and the execution order during construction is as follows

> Cupertino's mode：beforeBuild -> beforeBuildByCupertino -> buildByCupertino

> Material's mode：beforeBuild -> beforeBuildByMaterial -> buildByMaterial

`valueOf(String key, dynamic value)` It is used to get the personalized parameter value. `getbuildmode ` is used to get the actual build mode of the component. The return type is ` WidgetBuildMode`

```dart
/// Actual build mode of widgets
enum WidgetBuildMode {
  /// Cupertino's mode
  cupertino,
  /// Material's mode
  material,
  /// force use Cupertino's mode
  forceUseCupertino,
  /// force use Material's mode
  forceUseMaterial,
  /// Do not build, use Container() instead
  disabled,
}
```

## BaseParam

Widgets personalization parameters

* cupertino - Cupertino's mode personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* material - Material's mode personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* andriod - android's personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* fuchsia - fuchsia's personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* iOS - iOS's personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* linux - linux's personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* macOS - macOS's personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* windows - windows's personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* web - web's personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* others - 其他平台's personalization parameters

  Type：Map<String, dynamic>?

  Default：--

* forceUseMaterial - force use Material's mode

  Type：bool

  Default：false

* forceUseCupertino - force use Cupertino's mode

  Type：bool

  Default：false

* disabledOnMaterial - on Material's do not build, use Container() instead

  Type：bool

  Default：false

* disabledOnCupertino - on Cupertino's do not build, use Container() instead

  Type：bool

  Default：false

* disabledOnAndroid - on android do not build, use Container() instead

  Type：bool

  Default：false

* disabledOnFuchsia - on fuchsia do not build, use Container() instead

  Type：bool

  Default：false

* disabledOnIOS - on iOS do not build, use Container() instead

  Type：bool

  Default：false

* disabledOnLinux - on linux do not build, use Container() instead

  Type：bool

  Default：false

* disabledOnMacOS - on macOS do not build, use Container() instead

  Type：bool

  Default：false

* disabledOnWindows - on Windows do not build, use Container() instead

  Type：bool

  Default：false

* disabledOnWeb - on web do not build, use Container() instead

  Type：bool

  Default：false

* disabledOnOthers - on others's platform do not build, use Container() instead

  Type：bool

  Default：false

* withoutSplashOnCupertino - Whether to remove the water ripple effect when using forceUseMaterial on Cupertino's mode

  Type：bool

  Default：false

## BaseClass

Ordinary basic class, used to build ordinary classes, subclasses must implement `buildByCupertino, buildByMaterial` methods, which are used to build Cupertino and Material modes, respectively. You need to manually call the `build` method when using it.

## BaseStatelessWidget

Stateless Base widget , used to build stateless widget s, subclasses must implement `buildByCupertino, buildByMaterial` methods, which are used to build Cupertino and Material modes respectively

* cupertino - When taking the value of a public parameter, in Cupertino mode, the value in the parameter will be taken first, and then the value of the public parameter will be taken if it is not taken. It is used for differentiated construction. Value method: valueFromCupertino(key, value)

  Type: Map<String, dynamic>?

  Default: const <String, dynamic>{}

* material - When taking the value of a public parameter, in Material mode, the value in the parameter will be taken first, and then the value of the public parameter will be taken if it is not available. It is used for differentiated construction. Value method: valueFromMaterial(key, value)

  Type: Map<String, dynamic>?

  Default: const <String, dynamic>{}

## BaseStatefulWidget

State Base widget , used to build stateful widget s, the State class of the subclass must inherit the `BaseState` class and implement the `buildByCupertino, buildByMaterial` methods, which are used to build Cupertino and Material modes respectively

* cupertino - When taking the value of a public parameter, in Cupertino mode, the value in the parameter will be taken first, and then the value of the public parameter will be taken if it is not taken. It is used for differentiated construction. Value method: valueFromCupertino(key, value)

  Type: Map<String, dynamic>?

  Default: const <String, dynamic>{}

* material - When taking the value of a public parameter, in Material mode, the value in the parameter will be taken first, and then the value of the public parameter will be taken if it is not available. It is used for differentiated construction. Value method: valueFromMaterial(key, value)

  Type: Map<String, dynamic>?

  Default: const <String, dynamic>{}

## BasePlatformMode

Platform build mode, used to define the build mode used by each platform, you can use `currentBaseMode` to get the current platform mode

```dart
// Defaults
const BasePlatformMode({
  // andriod use material's mode
  this.android = BaseMode.material,
  // fuchsia use material's mode
  this.fuchsia = BaseMode.material,
  // iOS use cupertino's mode
  this.iOS = BaseMode.cupertino,
  // linux use material's mode
  this.linux = BaseMode.material,
  // macOS use cupertino's mode
  this.macOS = BaseMode.cupertino,
  // windows use material's mode
  this.windows = BaseMode.material,
  // web use material's mode
  this.web = BaseMode.material,
  // other platform use material's mode
  this.others = BaseMode.material,
});
```

## BaseTheme

Base widget 's theme, similar to Theme，CupertinoTheme

## BaseThemeData

* appBarHeight - Global BaseAppBar.height

  Type: double?

  Default: --

* appBarBackdropFilter- Global BaseAppBar.backdropFilter

  Type: bool?

  Default: --

* platformMode - Platform build mode

  Type: BasePlatformMode?

  Default: const BasePlatformMode()

  iOS, macOS use `Cupertino's` mode widget by Default，andriod、fuchsia、windows、linux、other platform use `Material's` mode widget

  ```dart
  // Modify the platform mode directly
  BaseApp(
    baseTheme: BaseTheme(
      platformMode: ...,
    ),
  );
  // Actively call methods to modify platform mode
  setBasePlatformMode(BasePlatformMode? basePlatformMode);
  ```

* routeFullscreenGackGesture - Global BaseRoute.fullscreenGackGesture

  Type: bool?

  Default: --

* sectionDividerColor - Global BaseSection.dividerColor

  Type: Color?

  Default: --

* tileBackgroundColor - Global BaseTile.backgroundColor

  Type: Color?

  Default: --

# Base Widgets

> The parameters without special instructions are the same as the original parameters

## BaseAlertDialog

Cupertino's mode：CupertinoAlertDialog

Material's mode：AlertDialog

## BaseActionSheet

Cupertino's mode：CupertinoActionSheet

Material's mode：custom's BottomSheet

## BaseActionSheetAction

Cupertino's mode: CupertinoActionSheetAction

Material's mode: TextButton

## BaseApp

Cupertino's mode：CupertinoApp

Material's mode：MaterialApp

* cupertinoTheme - CupertinoApp.theme

  Type: CupertinoThemeData?

  Default: --

* materialTheme - MaterialApp.theme

  Type: ThemeData?

  Default: --

* basePlatformMode - Platform build mode

  Type: BasePlatformMode?

  Default: const BasePlatformMode()

* withoutSplashOnCupertino - Global whether to disable water ripple，only on Cupertino's mode and `forceUseMaterial = true` will take effect

  Type: bool

  Default: true

## BaseAppBar

Cupertino's mode：modified's CupertinoNavigationBar

Material's mode：modified's AppBar

* backdropFilter - Whether to use a filter for the background，effective when there is transparency with backgroundColor on Cupertino's mode

  Type: bool

  Default: true

  on CupertinoNavigationBar gaussian blur will be added by Default when the background color is transparent. 

  BackdropFilter = false, gaussian blur will not be added, and a fully transparent navigation bar can be realized

* bottom - AppBar.bottom

  Type: PreferredSizeWidget?

  Default: --

  Will also take effect on Cupertino's mode

  If title has no value and bottom has a value, bottom will replace the position of title

* bottomOpacity - AppBar.bottomOpacity

  Type: double

  Default: --

* height - Navigation bar height

  Type: double

  Default: Cupertino's mode：44.0，Material's mode：56.0

* middle - CupertinoNavigationBar.middle

  Type: Widget?

  Default: --

  If this value is not available, the value of title will be taken on Cupertino's mode.

* title - AppBar.title

  Type: Widget?

  Default: --

  If this value is not available, the value of title will be taken on Material's mode.

* toolbarOpacity - AppBar.toolbarOpacity

  Type: double

  Default: --

## BaseBarItem

Cupertino's mode：BottomNavigationBarItem

Material's mode：BottomNavigationBarItem

Same as native BottomNavigationBarItem

## BaseButton

Cupertino's mode：CupertinoButton / CupertinoButton.filled

Material's mode：MaterialButton / TextButton / OutlineButton / RaisedButton

* elevatedButton - use or not ElevatedButton，effective on Material's mode

  Type: bool

  Default: false

* filledButton - use or not  CupertinoButton.filled，effective on Cupertino's mode

  Type: bool

  Default: false

* outlinedButton - use or not OutlinedButton，effective on Material's mode

  Type: bool

  Default: false

* textButton - use or not TextButton，effective on Material's mode

  Type: bool

  Default: false

## BaseButton.icon

Button with icon and label, if label is not needed, please use BaseIconButton

Cupertino's mode：CupertinoButton / CupertinoButton.filled

Material's mode：MaterialButton / TextButton.icon / OutlineButton.icon / RaisedButton.icon

* icon

  Type: Widget

  Default: --

* label

  Type: Widget

  Default: --

## BaseDialogAction

Cupertino's mode：CupertinoDialogAction

Material's mode：TextButton

## BaseIcon

Cupertino's mode：Icon

Material's mode：Icon

## BaseIconButton

Cupertino's mode：CupertinoButton

Material's mode：IconButton

* iconSize - Icon.size / IconButton.iconSize

  Type: double

  Default: 24.0

## BaseIndicator

Cupertino's mode：CupertinoActivityIndicator

Material's mode：CircularProgressIndicator / LinearProgressIndicator

* linearIndicator - use or not LinearProgressIndicator，effective on Material's mode

  Type: bool

  Default: false

  linearIndicator = true use LinearProgressIndicator，otherwise use CircularProgressIndicator

## BaseRefresh

Cupertino's mode：CustomScrollView + CupertinoSliverRefreshControl

Material's mode：RefreshIndicator

* child

  allow SliverList / ListView / CustomScrollView / BoxScrollView on Cupertino's mode

  allow ListView / CustomScrollView on Material's mode

  Type: Widget?

  Default: --

## BaseScaffold

Cupertino's mode：CupertinoPageScaffold

Material's mode：Scaffold

When `BaseTheme.of(context).appBarHeight` has a value, BaseAppBar will be constructed first, and then BaseScaffold will be constructed

This is to make `BaseAppBar.height` take effect. When there is no value, the construction order is reversed. Later, a better way to implement `BaseAppBar.height` will be considered.

* appBar - Navigation Bar

  Type: BaseAppBar?

  Default: --

  Material's mode takes this value first, and then navBar if it is not available

* navBar - Navigation Bar

  Type: BaseAppBar?

  Default: --

  Cupertino's mode takes this value first, and then takes the appBar if it is not available

* safeAreaTop - same as SafeArea.top

  Type: false

  Default: --

  safeAreaTop = true，There will be an extra layer of SafeArea on the body jacket and top = true

* safeAreaBottom - same as SafeArea.bottom

  Type: false

  Default: --

  safeAreaBottom = true，There will be an extra layer of SafeArea on the body jacket and bottom = true

## BaseScrollBar

Cupertino's mode：CupertinoScrollBar

Material's mode：ScrollBar

* padding - MediaQuery.data，When there is a value, an additional layer of MediaQuery will be applied

  Type:  EdgeInsets?

  Default: --

## BaseSection

Cupertino's mode：custom's Container

Material's mode：custom's Container

Slightly, will be reconstructed later

## BaseSlider

Cupertino's mode：CupertinoSlider

Material's mode：Slider

## BaseSwitch

Cupertino's mode：CupertinoSwitch

Material's mode：Switch

## BaseTabBar

Cupertino's mode：CupertinoTabBar

Material's mode：BottomNavigationBar

## BaseTabScaffold

Cupertino's mode：CupertinoTabScaffold + CupertinoTabView

Material's mode：Scaffold

Cupertino's mode returns `CupertinoTabView(builder => tabViews[index])` in CupertinoTabScaffold.tabBuilder according to the index of the tab. The implementation method is too simple to control the CupertinoTabView of each tab page, and it will be reconstructed later.

* restorationScopeIds - CupertinoTabView.restorationScopeId

  Type: List<String?>?

  Default: --

* tabBar - CupertinoTabScaffold.tabBar / Scaffold.bottomNavigationBar

  Type: CupertinoTabBar

  Default: --

* tabViews - CupertinoTabView.builder / Scaffold.body

  Type: List&lt;Widget&gt;

  Default: --

## BaseTextField

Cupertino's mode：CupertinoTextField

Material's mode：TextField

* cupertinoDecoration - CupertinoTextField.decoration

  Type:  BoxDecoration

  Default: _kDefaultRoundedBorderDecoration

* materialDecoration - TextField.decoration

  Type:  InputDecoration

  Default: InputDecoration()

## BaseTile

Cupertino's mode：custom's 没有水波纹的InkWell

Material's mode：ListTile

Slightly, will be reconstructed later

# Base Common Widgets, Tools

## BaseColor

Used to create different colors according to *Brightness*, generally used for font color, background color, you need to manually call the build() method

* color - Material's mode下，brightness = Brightness.light color

  Type:  Color?

  Default: Colors.black

  If this value is not available, take dynamicColor?.color, and finally take Colors.black

* darkColor - Material's mode下，brightness = Brightness.dark color

  Type:  Color?

  Default: Colors.white

  If this value is not available, take dynamicColor?.dynamicColor, and finally take Colors.white

* dynamicColor - Cupertino's mode color

  Type:  CupertinoDynamicColor?

  Default: CupertinoColors.secondarySystemBackground

  Cannot get the value brightness = Brightness.light takes color, brightness = Brightness.dark takes darkColor

## BaseRandomColor

Used to produce random colors, extends from Color, the usage is the same as Color

* BaseRandomColor()

  same as Color.fromARGB，If the parameter has a value, the value is fixed, and the others are random

* BaseRandomColor.fromRGBO()

  same as Color.fromRGBO，If the parameter has a value, the value is fixed, and the others are random

* BaseRandomColor.withRed()

  fixed the red，green，blue，alpha by random

* BaseRandomColor.withBlue()

  fixed the blue，red，green，alpha by random

* BaseRandomColor.withGreen()

  fixed the green，red，blue，alpha by random

* BaseRandomColor.withAlpha()

  fixed the alpha，red，green，blue by random

* BaseRandomColor.withOpacity()

  fixed the opacity，red，green，blue by random

## BaseDrawer

same as Drawer，support 4 directions to slide out

Slightly, will be reconstructed later

## BaseRoute

Routing, used to jump pages, does not support *Navigator2.0* usage

* Cupertino's mode：CupertinoPageRoute

* Material's mode：MaterialPageRoute

```dart
// use as 
BaseRoute<void>(...).push(context);
// or
pushBaseRoute(
	BaseRoute<void>(...),
	context,
	...
);
```


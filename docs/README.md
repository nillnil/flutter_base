<p align="center">
  <img src="https://github.com/nillnil/flutter_base/blob/master/screenshot/logo.png?raw=true" alt="logo">
</p>
<p align="center">
  <a href="https://flutterchina.club/" target="_blank">
    <img src="https://img.shields.io/badge/flutter-^2.2.2-3A91E3?logo=Flutter&style=flat" alt="Flutter">
  </a>
  <a href="https://www.dartcn.com/" style="margin-left: 20px;" target="_blank">
    <img src="https://img.shields.io/badge/dart-^2.13.3-3A91E3?logo=Dart&style=flat" alt="Dart">
  </a>
</p>

# 简介

* 实现一套代码，2种模式，iOS, macOS 默认使用`Cupertino`风格组件，andriod、fuchsia、windows、linux、其他平台默认使用`Material`风格组件，web默认是跟随系统的默认风格，也可以个性化设置各个平台所使用的模式

* 当前只针对Cupertino模式iOS上进行了测试，Material组件相对比较完善了，后期也会补上Material模式跟其他平台的测试。

> 使用stable分支，版本与flutter版本保持一致

# 使用

因众所周知的原因，现 https://pub.flutter-io.cn/ 上的版本是旧版本，所以请使用github上的版本

* 在pubspec.yaml的dependencies加入

```yaml
dependencies: 
  base:
    git:
      url: git://github.com/nillnil/flutter_base
      // branch name or tag name
      ref: x.x.x
```

* 使用`BaseXxx`组件代替原生组件，参数基本与原生的一致，如：BaseApp, BaseAppBar, BaseButton等组件，如果一个参数只存在于`CupertinoXxx`组件中或`MaterialXxx`组件，则该参数只会对该模式下生效

# 项目结构

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
    // 通用类, BaseColor, BaseRandomColor
    common/
    // 通用组件, BaseDrawer, BaseMaterialWidget
    components/
    // BaseAlertDialog, BaseAlertDialogAction, 
    dialog/
    // 修改过源码, CupertinoNavigationBar, AppBar
    // 该目录不会export出来，只会在Base组件中用到，不会与原生的冲突
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
    // 工具类
    tools/
  // Base基类
  base_xxx.dart
```

# 特性

## 差异化构建

> * Baes组件会根据配置的模式，判断是用Cupertino组件还是Material组件构建
>* 组件大多都是原生组件前缀加上Base命名，如BaseApp，`Cupertino`模式下使用CupertinoApp构建，`Material`模式下使用MaterialApp构建，同时可以使用`isCupertinoMode, isMaterialMode`
>   这2个方法判断当前使用的模式，进行差异化构建。
> * 每个Base组件都会有[BaseParam baseParam](#BaseParam) 参数，用于在不同模式下的差异化构建，因为同一个参数在Cupertino组件下跟Material组件下的表现会出现一些不一致的情况，所以需要根据不同模式配置不同的值，还可以根据平台设置个性化参数值，参数值的取值顺序为：平台参数 -> 模式参数 -> 普通参数。

```dart
// 示例
BaseIcon(
  // Materil模式下先取material参数里的icon参数，取不到再取该值
  icon: Icons.info,
  baseParam: BaseParam(
    // Cupertino 模式会优先取该值
    cupertino: <String, dynamic>{
      'icon': CupertinoIcons.info,
    },
    // android 虽然是Material模式，但会优先取该值
    android: <String, dynamic>{
      'icon': CupertinoIcons.info,
    }
  )
);
```

  Cupertino模式跟android下使用的是CupertinoIcons.info，Material模式跟其他平台下使用的是Icons.info

<img src="https://github.com/nillnil/flutter_base/blob/master/screenshot/features_demo.png?raw=true" alt="features_demo" width="256" height="78">

### forceUseCupertino、forceUseMaterial

> 每个Base组件的`baseParam`参数里都会有`forceUseCupertino、forceUseMaterial`2个参数，用于强制使用某种模式构建该组件，由于很多Material组件都需要有Material组件的祖先节点，所以在`Cupertino`模式下使用`forceUseMaterial`参数时会默认套上一层`Material`，`BaseTheme.withoutSplashOnCupertino = true`时还会去除Material组件上的水波纹效果，此时`BaseApp.theme`是不会生效的，所以`Theme.of(context)`是取不到正确的效果的。
>
> `请慎用！慎用！慎用！避免出现样式混乱等不可预知的bug`

### disabled

> 每个Base组件的`baseParam`参数里都会有`disabledOnXxx`参数，disabledOnXxx = true 会使用Container()代替，详情请查看[BaseParam](#BaseParam) 

# Base组件基类

## BaseMixin

基础通用类，有beforeBuild、beforeBuildByMaterial、beforeBuildByCupertino、valueOf、getBuildMode五个方法，其中beforeBuild、beforeBuildByMaterial、beforeBuildByCupertino用于构建

BaseClass、BaseStatelessWidget、BaseState都会混入该类，构建时执行顺序如下

> Cupertino模式：beforeBuild -> beforeBuildByCupertino -> buildByCupertino

> Material模式：beforeBuild -> beforeBuildByMaterial -> buildByMaterial

valueOf(String key, dynamic value)用于取个性化参数值，getBuildMode用于获取组件的实际构建模式，返回类型为`WidgetBuildMode`

```dart
/// 组件实际的构建模式
enum WidgetBuildMode {
  /// Cupertino模式
  cupertino,
  /// Material模式
  material,
  /// 强制使用Cupertino模式
  forceUseCupertino,
  /// 强制使用Material模式
  forceUseMaterial,
  /// 禁止构建，使用Container()代替
  disabledOnXxx,
}
```

## BaseParam

组件个性化参数

* cupertino - Cupertino 模式的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* material - Material 模式的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* andriod - android的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* fuchsia - fuchsia的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* iOS - iOS的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* linux - linux的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* macOS - macOS的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* windows - windows的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* web - web的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* others - 其他平台的个性化参数

  类型：Map<String, dynamic>?

  默认值：--

* forceUseMaterial - 强制使用Material模式构建

  类型：bool

  默认值：false

* forceUseCupertino - 强制使用Cupertino模式构建

  类型：bool

  默认值：false

* disabledOnMaterial - 在Material模式下禁止构建，使用Container()代替

  类型：bool

  默认值：false

* disabledOnCupertino - 在Cupertino模式下禁止构建，使用Container()代替

  类型：bool

  默认值：false

* disabledOnAndroid - 在android上禁止构建，使用Container()代替

  类型：bool

  默认值：false

* disabledOnFuchsia - 在fuchsia上禁止构建，使用Container()代替

  类型：bool

  默认值：false

* disabledOnIOS - 在iOS上禁止构建，使用Container()代替

  类型：bool

  默认值：false

* disabledOnLinux - 在linux上禁止构建，使用Container()代替

  类型：bool

  默认值：false

* disabledOnMacOS - 在macOS上禁止构建，使用Container()代替

  类型：bool

  默认值：false

* disabledOnWindows - 在Windows上禁止构建，使用Container()代替

  类型：bool

  默认值：false

* disabledOnWeb - 在web上禁止构建，使用Container()代替

  类型：bool

  默认值：false

* disabledOnOthers - 在其他平台上禁止构建，使用Container()代替

  类型：bool

  默认值：false

* withoutSplashOnCupertino - 在Cupertino模式下使用Material组件时是否去除水波纹效果

  类型：bool

  默认值：false

## BaseClass

普通基础类，用于构建普通类，子类必须实现 `buildByCupertino、buildByMaterial` 方法，分别用于构建Cupertino、Material模式，使用时需手动调用`build`方法

## BaseStatelessWidget

无状态Base组件，用于构建无状态组件，子类必须实现 `buildByCupertino、buildByMaterial` 方法，分别用于构建Cupertino、Material模式，组件里的参数取值都必须使用`valueOf`取值

## BaseStatefulWidget

状态Base组件，用于构建有状态的组件，子类的State类必须继承 `BaseState` 类并实现`buildByCupertino、buildByMaterial` 方法，分别用于构建Cupertino、Material模式，组件里的参数取值都必须使用`valueOf`取值

## BasePlatformMode

平台构建模式，用于定义各个平台所使用的构建模式，可使用`currentBaseMode`获取当前的平台模式

```dart
// 默认值
const BasePlatformMode({
  // andriod使用material模式
  this.android = BaseMode.material,
  // fuchsia使用material模式
  this.fuchsia = BaseMode.material,
  // iOS使用cupertino模式
  this.iOS = BaseMode.cupertino,
  // linux使用material模式
  this.linux = BaseMode.material,
  // macOS使用cupertino模式
  this.macOS = BaseMode.cupertino,
  // windows使用material模式
  this.windows = BaseMode.material,
  // web使用material模式
  this.web = BaseMode.material,
  // 其他平台使用material模式
  this.others = BaseMode.material,
});
```

## BaseTheme

Base组件样式，类似于Theme，CupertinoTheme

## BaseThemeData

* appBarHeight - 全局BaseAppBar.height

  类型：double?

  默认值：--

* appBarBackdropFilter- 全局BaseAppBar.backdropFilter

  类型：bool?

  默认值：--

* platformMode - 平台构建模式

  类型：BasePlatformMode?

  默认值：const BasePlatformMode()

  iOS, macOS 默认使用`Cupertino`风格组件，andriod、fuchsia、windows、linux、其他平台默认使用`Material`风格组件

  ```dart
  // 直接修改平台模式
  BaseApp(
    baseTheme: BaseTheme(
      platformMode: ...,
    ),
  );
  // 主动调用方法修改平台模式
  setBasePlatformMode(BasePlatformMode? basePlatformMode);
  ```

* routeFullscreenGackGesture - 全局BaseRoute.fullscreenGackGesture

  类型：bool?

  默认值：--

* sectionDividerColor - 全局BaseSection.dividerColor

  类型：Color?

  默认值：--

* tileBackgroundColor - 全局BaseTile.backgroundColor

  类型：Color?

  默认值：--

* materialTheme - 同App.theme

  类型：ThemeData?

  默认值：--

* materialDarkTheme - 同App.dartTheme

  类型：ThemeData?

  默认值：--

* materialHighContrastTheme - 同App.highContrastTheme

  类型：ThemeData?

  默认值：--

* materialHighContrastDarkTheme - 同App.highContrastDarkTheme

  类型：ThemeData?

  默认值：--

# Base组件列表

> 无特殊说明的参数，同原生参数一致

## BaseAlertDialog

Cupertino模式：CupertinoAlertDialog

Material模式：AlertDialog

## BaseActionSheet

Cupertino模式：CupertinoActionSheet

Material模式：自定义的BottomSheet

## BaseActionSheetAction

Cupertino模式: CupertinoActionSheetAction

Material模式: TextButton

## BaseApp

Cupertino模式：CupertinoApp

Material模式：MaterialApp

* cupertinoTheme - CupertinoApp.theme

  类型：CupertinoThemeData?

  默认值：--

* materialTheme - MaterialApp.theme

  类型：ThemeData?

  默认值：--

* basePlatformMode - 平台构建模式

  类型：BasePlatformMode?

  默认值：const BasePlatformMode()

* withoutSplashOnCupertino - 全局是否禁用水波纹，Cupertino模式下，`forceUseMaterial = true` 才会生效

  类型：bool

  默认值：true

## BaseAppBar

Cupertino模式：修改过的CupertinoNavigationBar

Material模式：修改过的AppBar

* backdropFilter - 背景是否使用滤镜，Cupertino模式下backgroundColor有透明度时有效

  类型：bool

  默认值：true

  CupertinoNavigationBar的背景色有透明度时默认会添加高斯模糊，backdropFilter = false，则不会添加高斯模糊，可实现全透明导航栏

* bottom - AppBar.bottom

  类型：PreferredSizeWidget?

  默认值：--

  Cupertino模式下也会生效

  如果title没有值，bottom有值，则bottom会替代title的位置

* bottomOpacity - AppBar.bottomOpacity

  类型：double

  默认值：--

* height - 导航栏高度

  类型：double

  默认值：Cupertino模式：44.0，Material模式：56.0

* middle - CupertinoNavigationBar.middle

  类型：Widget?

  默认值：--

  Cupertino模式下，取不到该值会取title的值

* title - AppBar.title

  类型：Widget?

  默认值：--

  Material模式下，取不到该值会取middle的值

* toolbarOpacity - AppBar.toolbarOpacity

  类型：double

  默认值：--

## BaseBarItem

Cupertino模式：BottomNavigationBarItem

Material模式：BottomNavigationBarItem

同原生BottomNavigationBarItem一致

## BaseButton

Cupertino模式：CupertinoButton / CupertinoButton.filled

Material模式：MaterialButton / TextButton / OutlineButton / RaisedButton

* elevatedButton - 是否使用ElevatedButton，Material模式下有效

  类型：bool

  默认值：false

* filledButton - 是否使用CupertinoButton.filled，Cupertino模式下有效

  类型：bool

  默认值：false

* outlinedButton - 是否使用OutlinedButton，Material模式下有效

  类型：bool

  默认值：false

* textButton - 是否使用TextButton，Material模式下有效

  类型：bool

  默认值：false

## BaseButton.icon

带icon和label的按钮，如不需要label，请使用BaseIconButton

Cupertino模式：CupertinoButton / CupertinoButton.filled

Material模式：MaterialButton / TextButton.icon / OutlineButton.icon / RaisedButton.icon

* icon - 图标

  类型：Widget

  默认值：--

* label - 文本

  类型：Widget

  默认值：--

## BaseDialogAction

Cupertino模式：CupertinoDialogAction

Material模式：TextButton

## BaseIcon

Cupertino模式：Icon

Material模式：Icon

## BaseIconButton

Cupertino模式：CupertinoButton

Material模式：IconButton

* iconSize - Icon.size / IconButton.iconSize

  类型：double

  默认值：24.0

## BaseIndicator

Cupertino模式：CupertinoActivityIndicator

Material模式：CircularProgressIndicator / LinearProgressIndicator

* linearIndicator - 是否使用LinearProgressIndicator，Material模式下有效

  类型：bool

  默认值：false

  linearIndicator = true则使用LinearProgressIndicator，否则使用CircularProgressIndicator

## BaseRefresh

Cupertino模式：CustomScrollView + CupertinoSliverRefreshControl

Material模式：RefreshIndicator

* child

  Cupertino模式下支持SliverList / ListView / CustomScrollView / BoxScrollView

  Material模式支持ListView / CustomScrollView

  类型：Widget?

  默认值：--

## BaseScaffold

Cupertino模式：CupertinoPageScaffold

Material模式：Scaffold

当`BaseTheme.of(context).appBarHeight`有值时，会先构建BaseAppBar，再构建BaseScaffold

这么做是为了使`BaseAppBar.height`生效，没值时，则构建顺序相反，后续会考虑使用更好的方式实现`BaseAppBar.height`

* appBar - 导航栏

  类型：BaseAppBar?

  默认值：--

  Material模式先取该值，取不到再取navBar

* navBar - 导航栏

  类型：BaseAppBar?

  默认值：--

  Cupertino模式先取该值，取不到再取appBar

* safeAreaTop - 同SafeArea.top

  类型：false

  默认值：--
  
  safeAreaTop = true，会在body外套多一层SafeArea，并且top = true
  
* safeAreaBottom - 同SafeArea.bottom

  类型：false

  默认值：--

  safeAreaBottom = true，会在body外套多一层SafeArea，并且bottom = true

## BaseScrollBar

Cupertino模式：CupertinoScrollBar

Material模式：ScrollBar

* padding - MediaQuery.data，有值时则会套多一层MediaQuery

  类型： EdgeInsets?

  默认值：--

## BaseSection

Cupertino模式：自定义的Container

Material模式：自定义的Container

略，后续会重构

## BaseSlider

Cupertino模式：CupertinoSlider

Material模式：Slider

## BaseSwitch

Cupertino模式：CupertinoSwitch

Material模式：Switch

## BaseTabBar

Cupertino模式：CupertinoTabBar

Material模式：BottomNavigationBar

## BaseTabScaffold

Cupertino模式：CupertinoTabScaffold + CupertinoTabView

Material模式：Scaffold

Cupertino模式是根据tab的索引在CupertinoTabScaffold.tabBuilder中返回`CupertinoTabView（builder => tabViews[index])`，实现方式太过简单，无法控制每个tab页的CupertinoTabView，后续会重构

* restorationScopeIds - CupertinoTabView.restorationScopeId

  类型：List<String?>?

  默认值：--

* tabBar - CupertinoTabScaffold.tabBar / Scaffold.bottomNavigationBar

  类型：CupertinoTabBar

  默认值：--

* tabViews - CupertinoTabView.builder / Scaffold.body

  类型：List&lt;Widget&gt;

  默认值：--

## BaseTextField

Cupertino模式：CupertinoTextField

Material模式：TextField

* cupertinoDecoration - CupertinoTextField.decoration

  类型： BoxDecoration

  默认值：_kDefaultRoundedBorderDecoration

* materialDecoration - TextField.decoration

  类型： InputDecoration

  默认值：InputDecoration()

## BaseTile

Cupertino模式：自定义的没有水波纹的InkWell

Material模式：ListTile

略，后续会重构

# Base通用组件，工具

## BaseColor

用于根据*Brightness*创建不同的颜色，一般用于字体颜色，背景颜色，需要手动调用build()方法

* color - Material模式下，brightness = Brightness.light 取的颜色

  类型： Color?

  默认值：Colors.black

  取不到该值则取dynamicColor?.color，最后取Colors.black

* darkColor - Material模式下，brightness = Brightness.dark 取的颜色

  类型： Color?

  默认值：Colors.white

  取不到该值则取dynamicColor?.dynamicColor，最后取Colors.white

* dynamicColor - Cupertino模式下取的颜色

  类型： CupertinoDynamicColor?

  默认值：CupertinoColors.secondarySystemBackground

  取不到该值brightness = Brightness.light取color，brightness = Brightness.dark取darkColor

## BaseRandomColor

用于生产随机颜色，继承于Color，用法同Color

* BaseRandomColor()

  同Color.fromARGB，如参数有值，则固定该值，其他随机

* BaseRandomColor.fromRGBO()

  同Color.fromRGBO，如参数有值，则固定该值，其他随机

* BaseRandomColor.withRed()

  固定red值，green，blue，alpha随机

* BaseRandomColor.withBlue()

  固定blue值，red，green，alpha随机

* BaseRandomColor.withGreen()

  固定green值，red，blue，alpha随机

* BaseRandomColor.withAlpha()

  固定alpha值，red，green，blue随机

* BaseRandomColor.withOpacity()

  固定opacity值，red，green，blue随机

## BaseDrawer

同Drawer，支持4个方向滑出，会重构

## BaseRoute

路由，用于跳转页面，不支持*Navigator2.0*用法

* Cupertino模式：CupertinoPageRoute

* Material模式：MaterialPageRoute

```dart
// 使用方法
BaseRoute<void>(...).push(context);
// 或者
pushBaseRoute(
	BaseRoute<void>(...),
	context,
	...
);
```


<p align="center">
  <img src="https://github.com/nillnil/flutter_base/blob/master/screenshot/logo.png?raw=true" alt="logo">
</p>


## 实现一套代码，2种模式，ios使用Cupertino风格组件，andriod、fuchsia使用Material风格组件


### [English](./README-EN.md)

### 当前只针对Cupertino模式进行了测试，Material组件相对比较完善了，后期也会补上Material模式的测试。

## 基础类
* BaseStatelessWidget

  继承于StatelessWidget，用于构建无状态组件

  子类必须实现 `buildByCupertino、buildByMaterial` 方法，分别用于构建2种模式

* BaseStatefulWidget

  继承于StatefulWidget，用于构建状态组件

  子类的State类必须继承 `BaseState` 类并实现  `buildByCupertino、buildByMaterial` 方法，分别用于构建2种模式

* BaseClass

  普通基础类，用于构建普通类

  子类必须实现 `buildByCupertino、buildByMaterial` 方法分别用于构建2种模式

* basePlatform 参数

  当前构建的平台，默认为 `defaultTargetPlatform` 

  使用 `setPlatform(TargetPlatform targetPlatform)` 方法修改平台

  推荐使用  `BaseApp(targetPlatform: TargetPlatform...)` 设置平台

  默认 `TargetPlatform.iOS` 使用 `Cupertino` 构建， `TargetPlatform.android` 或 `TargetPlatform.fuchsia` 使用 `Material` 构建


## Features
* `useCupertino, useMaterial` 
  使用这2个方法可以判断当前使用的模式，进行差异化构建。

* 每个基础组件都含有 `Map<String, dynamic> cupertino, Map<String, dynamic> material` 2个参数，用于组件模式差异化设置，2种模式有公共参数的，会优先取当前模式下的值，再取公共值，如：

      BaseIcon(
        // materil模式下先取material参数里的icon参数，取不到再取该值
        icon: Icons.info,
        'cupertino': <String, dynamic>{
          // cupertino模式下先取该值，因为取得到，所以不会取外层的icon
          'icon': CupertinoIcons.info,
        }
      );

    cupertino模式下使用的是CupertinoIcons.info，material模式下使用的是Icons.info

  <img src="https://github.com/nillnil/flutter_base/blob/master/screenshot/features_demo.png?raw=true" alt="features_demo" width="256" height="78">

* 可以使用 `forceUseMaterial, forceUseCupertino` 进行强制切换模式构建，使用 `disabled` 禁止构建（会用 `Container()` 代替）

      'cupertino': {
        // 可使该组件强制使用Material构建
        'forceUseMaterial': true,
        // 可使该组件不进行构建，但会使用Container()代替
        'disabled': true,
      }
      'material': {
        // 可使该组件强制使用Cupertino构建
        'forceUseCupertino': true,
        // 可使该组件不进行构建，但会使用Container()代替
        'disabled': true,
      }

* ### 特别说明，非常重要

    **`forceUseMaterial, forceUseCupertino`** 参数未经严格测试，请慎用！慎用！慎用！

    很多material组件是需要有Material祖先的，在Cupertino模式下设置forceUseMaterial: true时，会默认套上一层Material，且默认会去除水波纹效果，此时BaseApp上的cupertinoTheme参数是不生效的，可能会出现样式混乱等不可预知的bug，所以请慎用，后续可能会删除这2个参数

    ### 如果要切换模式，强烈建议直接设置BaseApp's targetPlatform参数


## 组件列表
|组件|Material组件|Cupertino组件|
|:---------------|:--------|:----------|
|BaseApp|MaterialApp|CupertinoApp|
|BaseAppBar|AppBar|CupertinoNavigationBar|
|BaseBarItem|BottomNavigationBarItem|BottomNavigationBarItem|
|BaseButton|MaterialButton<br>FlatButton, FlatButton.icon<br>OutlineButton, OutlineButton.icon|CupertinoButton|
|BaseIconButton|IconButton|CupertinoButton|
|BaseAlertDialog|AlertDialog|CupertinoAlertDialog|
|BaseDialogAction|FlatButton|CupertinoDialogAction|
|BaseIcon|Icon|Icon|
|BaseIndicator|CircularProgressIndicator|CupertinoActivityIndicator|
|BaseRefresh|RefreshIndicator|CustomScrollView + CupertinoSliverRefreshControl|
|BaseScaffold|Scaffold|CupertinoPageScaffold|
|BaseScrollBar|ScrollBar|CupertinoScrollBar|
|BaseSection|custom Container|custom Container|
|BaseTile|ListTile|custom InkWell without splash|
|BaseSlider|Slider|CupertinoSlider|
|BaseSwitch|Switch|CupertinoSwitch|
|BaseTabBar|BottomNavigationBar|CupertinoTabBar|

## [简单示例](./example/)

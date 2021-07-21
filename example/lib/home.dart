import 'package:base/base.dart';
import 'package:example/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'demos/demos.dart';
import 'demos/scaffold/scaffold_demos.dart';
import 'iconfont/iconfont.dart';
import 'settings.dart';

final List<Widget> _children = <Widget>[
  const _Item(
    icon: BaseIcon(icon: Icons.apps, size: 40, color: Colors.blueGrey),
    title: Text(
      'App',
      style: TextStyle(color: Colors.blueGrey),
    ),
    page: AppDemo(),
  ),
  const _Item(
    icon: BaseIcon(icon: IconFont.nav, size: 40, color: Colors.orangeAccent),
    title: Text(
      'AppBar',
      style: TextStyle(color: Colors.orangeAccent),
    ),
    page: AppBarDemo(),
  ),
  const _Item(
    icon: BaseIcon(icon: IconFont.page, size: 40, color: Colors.blueAccent),
    title: Text(
      'Scaffold',
      style: TextStyle(color: Colors.blueAccent),
    ),
    page: ScaffoldDemos(),
    fullscreenGackGesture: false,
  ),
  const _Item(
    icon: BaseIcon(icon: IconFont.tile, size: 40, color: Colors.redAccent),
    title: Text(
      'Section & Tile',
      style: TextStyle(color: Colors.redAccent),
    ),
    page: SectionDemo(),
  ),
  const _Item(
    icon: BaseIcon(
      icon: IconFont.buttons,
      size: 40,
      color: Colors.greenAccent,
    ),
    title: Text(
      'Button',
      style: TextStyle(color: Colors.greenAccent),
    ),
    page: ButtonDemos(),
    fullscreenGackGesture: false,
  ),
  const _Item(
    icon: BaseIcon(
      icon: IconFont.routes,
      size: 40,
      color: Colors.deepOrangeAccent,
    ),
    title: Text(
      'Routes',
      style: TextStyle(color: Colors.deepOrangeAccent),
    ),
    page: RouteDemo(),
  ),
  _Item(
    icon: const BaseIcon(
      icon: IconFont.dialog,
      size: 40,
      color: Colors.purpleAccent,
    ),
    title: const Text(
      'Alert Dialog',
      style: TextStyle(color: Colors.purpleAccent),
    ),
    page: DialogDemo(),
  ),
  const _Item(
    icon: BaseIcon(icon: IconFont.rows, size: 40, color: Colors.blueGrey),
    title: Text(
      'ActionSheet',
      style: TextStyle(color: Colors.blueGrey),
    ),
    page: ActionSheetDemo(),
  ),
  const _Item(
    icon: BaseIcon(
      icon: IconFont.refresh,
      size: 40,
      color: Colors.pinkAccent,
    ),
    title: Text('Refresh', style: TextStyle(color: Colors.pinkAccent)),
    page: RefreshDemos(),
    fullscreenGackGesture: false,
  ),
  const _Item(
    icon: BaseIcon(
      icon: IconFont.text,
      size: 40,
      color: Colors.deepOrangeAccent,
    ),
    title: Text(
      'TextField',
      style: TextStyle(color: Colors.deepOrangeAccent),
    ),
    page: TextFieldDemo(),
  ),
  _Item(
    icon: BaseIcon(
      icon: IconFont.components,
      size: 40,
      color: Colors.red.withBlue(150),
    ),
    title: Text(
      'Componentes',
      style: TextStyle(color: Colors.red.withBlue(150)),
    ),
    page: const ComponentesDemo(),
  ),
  _Item(
    icon: BaseIcon(
      icon: IconFont.tools,
      size: 40,
      color: Colors.indigo.withBlue(125),
    ),
    title: Text(
      'Tools',
      style: TextStyle(color: Colors.indigo.withBlue(125)),
    ),
    page: const ToolsDemo(),
  ),
];

const Widget _tipsWidget = Text(
  '1、Material组件相对比较完善，没经过严格的测试，后续会完善优化\n\n'
  '2、每个组件都保留有forceUseCupertino、forceUseMaterial参数，都未经过严格测试，请慎用！！！'
  '因为各个组件之间有关联度，如果要切换组件的整体样式，强烈建议直接切换整个app使用的平台样式（并且不在app中动态切换），而不是使用'
  '单个组件中的forceUseCupertino、forceUseMaterial，后续可能会删除这2参数。',
  style: TextStyle(
    fontSize: 16.0,
  ),
  textAlign: TextAlign.left,
);

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: const Text('Base Example'),
        padding: const EdgeInsetsDirectional.only(start: 5.0, end: 5.0),
        baseParam: BaseParam(
          cupertino: <String, dynamic>{
            'leading': BaseIconButton(
              icon: IconFont.info,
              iconSize: 24,
              onPressed: () {
                final double paddingTop = MediaQuery.of(context).padding.top;
                const GlobalObjectKey<BaseDrawerState> _drawerKey = GlobalObjectKey<BaseDrawerState>('home_drawer');
                final BaseDrawer baseDrawer = BaseDrawer(
                  key: _drawerKey,
                  axisDirection: AxisDirection.up,
                  size: Size.fromHeight(
                    MediaQuery.of(context).size.height - paddingTop,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.secondarySystemGroupedBackground.resolveFrom(context),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        _TipsHeader(
                          callback: () {
                            _drawerKey.currentState?.close();
                          },
                        ),
                        Expanded(
                          child: IgnorePointer(
                            child: ListView(
                              padding: const EdgeInsets.all(10.0),
                              children: const <Widget>[_tipsWidget],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                openBaseDrawer<void>(context, baseDrawer);
              },
            ),
          },
        ),
        actions: <Widget>[
          ClipOval(
            child: BaseIconButton(
              icon: IconFont.settings,
              iconSize: 20,
              baseParam: BaseParam(
                material: const <String, dynamic>{
                  'color': Colors.white,
                },
              ),
              onPressed: () {
                BaseRoute<dynamic>(
                  builder: (_) => const Settings(),
                ).push(context);
              },
            ),
          )
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (_, AppProvider appProvider, __) {
          return GridView.count(
            crossAxisCount: 3,
            children: _children,
          );
        },
      ),
      drawer: _MaterialTipsPage(),
    );
  }
}

class _MaterialTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).appBarTheme.color ?? Theme.of(context).primaryColor,
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: const Center(
              child: Text(
                '特别说明',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: _tipsWidget,
          ),
        ],
      ),
    );
  }
}

class _TipsHeader extends StatelessWidget {
  const _TipsHeader({
    Key? key,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        // border: Border(
        //   bottom: BorderSide(
        //     width: 1.0,
        //     color: Colors.grey.withOpacity(.3),
        //   ),
        // ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 50,
            child: BaseButton(
              padding: EdgeInsets.zero,
              child: BaseIcon(
                icon: CupertinoIcons.clear,
                size: 40,
                color: const BaseColor.highContrast().build(context),
              ),
              onPressed: () {
                if (callback != null) {
                  callback!();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          const Text('特别说明'),
          Container(
            width: 50,
          )
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.title,
    required this.icon,
    required this.page,
    this.fullscreenGackGesture,
  }) : super(key: key);

  final Text title;
  final BaseIcon icon;
  final Widget page;
  final bool? fullscreenGackGesture;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appprovider, _) {
        return GestureDetector(
          child: Container(
            color: const BaseColor(
              dynamicColor: CupertinoColors.secondarySystemGroupedBackground,
            ).build(context),
            child: Column(
              children: <Widget>[
                icon,
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                ),
                title
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          onTap: () {
            BaseRoute<dynamic>(
              builder: (_) => page,
              fullscreenGackGesture: fullscreenGackGesture ?? appprovider.routeFullscreenGackGesture,
            ).push(context);
          },
        );
      },
    );
  }
}

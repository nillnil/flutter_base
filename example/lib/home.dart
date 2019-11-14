
import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'demos/demos.dart';
import 'demos/scaffold/scaffold_demos.dart';
import 'iconfont/iconfont.dart';
import 'settings.dart';

final List<Widget> _children = <Widget>[
  _Item(
    icon: BaseIcon(icon: Icons.apps, size: 40, color: Colors.blueGrey),
    title: const Text(
      'App',
      style: TextStyle(color: Colors.blueGrey),
    ),
    page: AppDemo(),
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.nav, size: 40, color: Colors.orangeAccent),
    title: const Text(
      'AppBar',
      style: TextStyle(color: Colors.orangeAccent),
    ),
    page: AppBarDemo(),
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.page, size: 40, color: Colors.blueAccent),
    title: const Text(
      'Scaffold',
      style: TextStyle(color: Colors.blueAccent),
    ),
    page: ScaffoldDemos(),
    fullscreenGackGesture: false,
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.tile, size: 40, color: Colors.redAccent),
    title: const Text(
      'Section & Tile',
      style: TextStyle(color: Colors.redAccent),
    ),
    page: SectionDemo(),
  ),
  _Item(
    icon: BaseIcon(
      icon: IconFont.buttons,
      size: 40,
      color: Colors.greenAccent,
    ),
    title: const Text(
      'Button',
      style: TextStyle(color: Colors.greenAccent),
    ),
    page: ButtonDemos(),
    fullscreenGackGesture: false,
  ),
  _Item(
    icon: BaseIcon(
      icon: IconFont.routes,
      size: 40,
      color: Colors.deepOrangeAccent,
    ),
    title:
        const Text('Routes', style: TextStyle(color: Colors.deepOrangeAccent)),
    page: RouteDemo(),
  ),
  _Item(
    icon: BaseIcon(
      icon: IconFont.dialog,
      size: 40,
      color: Colors.purpleAccent,
    ),
    title: const Text('Alert Dialog',
        style: TextStyle(color: Colors.purpleAccent)),
    page: DialogDemo(),
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.rows, size: 40, color: Colors.blueGrey),
    title: const Text(
      'ActionSheet',
      style: TextStyle(color: Colors.blueGrey),
    ),
    page: const ActionSheetDemo(),
  ),
  _Item(
    icon: BaseIcon(
      icon: IconFont.refresh,
      size: 40,
      color: Colors.pinkAccent,
    ),
    title: const Text('Refresh', style: TextStyle(color: Colors.pinkAccent)),
    page: RefreshDemos(),
    fullscreenGackGesture: false,
  ),
  _Item(
    icon: BaseIcon(
      icon: IconFont.text,
      size: 40,
      color: Colors.deepOrangeAccent,
    ),
    title: const Text(
      'TextField',
      style: TextStyle(color: Colors.deepOrangeAccent),
    ),
    page: const TextFieldDemo(),
  ),
  _Item(
    icon: BaseIcon(
        icon: IconFont.components, size: 40, color: Colors.red.withBlue(150)),
    title: Text(
      'Componentes',
      style: TextStyle(color: Colors.red.withBlue(150)),
    ),
    page: const ComponentesDemo(),
  ),
];

const Widget _tipsWidget = Text(
  '1、Material组件相对比较完善，没经过严格的测试，后续会完善优化\n\n'
  '2、每个组件都保留有forceUseCupertino、forceUseMaterial参数，都未经过严格测试，请慎用！！！'
  '因为各个组件之间有关联度，如果要切换组件的整体样式，强烈建议直接切换整个app使用的平台样式（并且不在app中动态切换），而不是使用'
  '单个组件中的forceUseCupertino、forceUseMaterial，后续可能会删除这2参数。',
  style: TextStyle(
    color: Colors.red,
    fontSize: 16.0,
  ),
  textAlign: TextAlign.left,
);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: const Text('Base Example'),
        padding: const EdgeInsetsDirectional.only(start: 5.0, end: 5.0),
        cupertino: <String, dynamic>{
          'leading': BaseIconButton(
            icon: const BaseIcon(icon: IconFont.info, size: 24),
            onPressed: () {
              final double paddingTop = MediaQuery.of(context).padding.top;
              const GlobalObjectKey<BaseDrawerState> _drawerKey =
                  GlobalObjectKey<BaseDrawerState>('home_drawer');
              final BaseDrawer baseDrawer = BaseDrawer(
                key: _drawerKey,
                axisDirection: AxisDirection.up,
                size: Size.fromHeight(MediaQuery.of(context).size.height - paddingTop),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      _TipsHeader(
                        callback: () {
                          _drawerKey.currentState.close();
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
          )
        },
        actions: <Widget>[
          ClipOval(
            child: BaseIconButton(
              icon: const BaseIcon(
                icon: IconFont.settings,
                size: 20,
                material: <String, dynamic>{
                  'color': Colors.white,
                },
              ),
              onPressed: () {
                BaseRoute<dynamic>(
                  Settings(),
                  fullscreenGackGesture: true,
                ).push(context);
              },
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 3,
          children: _children,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
        ),
      ),
      drawer: _MaterialTipsPage(),
    );
  }
}

class _MaterialTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).appBarTheme.color ??
                  Theme.of(context).primaryColor,
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
      ),
    );
  }
}

class _TipsHeader extends StatelessWidget {
  const _TipsHeader({Key key, this.callback}) : super(key: key);

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.grey.withOpacity(.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 50,
            child: BaseButton(
              padding: EdgeInsets.zero,
              child: BaseIcon(
                icon: CupertinoIcons.clear,
                size: 40,
                color: Colors.black,
              ),
              onPressed: () {
                if (callback != null) {
                  callback();
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
    Key key,
    this.title,
    this.icon,
    this.page,
    this.fullscreenGackGesture = true,
  }) : super(key: key);

  final Text title;
  final BaseIcon icon;
  final Widget page;
  final bool fullscreenGackGesture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
          page,
          fullscreenGackGesture: fullscreenGackGesture,
        ).push(context);
      },
    );
  }
}

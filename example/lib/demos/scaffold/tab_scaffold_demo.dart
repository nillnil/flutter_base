import 'package:base/base.dart';
import 'package:example/iconfont/iconfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

/// Tab Scaffold Demo
class TabScaffoldDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[
      DemoTile(
        title: const Text('tab scaffold'),
        page: _Demo(),
      )
    ];
    return DemoPage(
      widgetName: 'BaseTabScaffold',
      materialDesc: 'use Scaffold',
      cupertinoDesc: 'use CupertinoTabScaffold',
      parameterDesc: const <String, String>{
        'tabBar': 'BaseTabBar, use CupertinoTabBar on Cupertino, '
            'use BottomNavigationBar on Material.\n'
            'BaseTabBar.items is List<BaseBarItem> '
            'and the BaseBarItem use custom BottomNavigationBarItem, '
            'the icon can be null',
        'tabViews': 'The scaffolds.'
      },
      demos: _demos,
    );
  }
}

class _Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      const _TabPage(title: '消息'),
      const _TabPage(title: '联系人'),
      const _TabPage(title: '发现'),
      const _TabPage(title: '我'),
    ];
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: BaseTabScaffold(
        tabBar: const BaseTabBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: BaseIcon(
                icon: IconFont.dialog,
              ),
              label: '消息',
            ),
            BottomNavigationBarItem(
              icon: BaseIcon(
                icon: IconFont.contacts,
              ),
              label: '联系人',
            ),
            BottomNavigationBarItem(
              icon: BaseIcon(
                icon: IconFont.discover,
              ),
              label: '发现',
            ),
            BottomNavigationBarItem(
              icon: BaseIcon(
                icon: IconFont.profile,
              ),
              label: '我',
            ),
          ],
          iconSize: 24.0,
        ),
        tabViews: children,
      ),
    );
  }
}

class _TabPage extends StatelessWidget {
  const _TabPage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        padding: const EdgeInsetsDirectional.only(start: 3.0),
        leading: BaseIconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        title: Text(title),
      ),
      body: _Body(title: title),
      cupertino: const <String, dynamic>{
        'backgroundColor': CupertinoColors.systemGroupedBackground,
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key key,
    this.title = '',
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        // 底部高度包括TabBar
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}

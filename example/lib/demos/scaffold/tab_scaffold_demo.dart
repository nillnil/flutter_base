import 'package:base/base.dart';
import 'package:example/iconfont/iconfont.dart';
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
      demos: _demos,
    );
  }
}

class _Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      _TabPage(title: '消息'),
      _TabPage(title: '联系人'),
      _TabPage(title: '发现'),
      _TabPage(title: '我'),
    ];
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: BaseTabScaffold(
        tabBar: BaseTabBar(
          type: BottomNavigationBarType.fixed,
          items: <BaseBarItem>[
            BaseBarItem(
              icon: BaseIcon(
                icon: IconFont.dialog,
              ),
              title: const Text('消息'),
            ),
            BaseBarItem(
              icon: BaseIcon(
                icon: IconFont.contacts,
              ),
              title: const Text('联系人'),
            ),
            BaseBarItem(
              icon: BaseIcon(
                icon: IconFont.discover,
              ),
              title: const Text('发现'),
            ),
            BaseBarItem(
              icon: BaseIcon(
                icon: IconFont.profile,
              ),
              title: const Text('我'),
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
  _TabPage({
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
    );
  }
}

class _Body extends StatelessWidget {
  _Body({
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

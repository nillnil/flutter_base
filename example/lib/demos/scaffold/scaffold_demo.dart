import 'package:base/base.dart';
import 'package:example/demos/scaffold/safeArea_demo.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

/// Scaffold 示例
class ScaffoldDemo extends StatelessWidget {
  const ScaffoldDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[];
    if (isCupertinoMode) {
      _demos.add(const DemoTile(
        title: Text('safeArea scaffold'),
        page: SateAreaDemo(),
      ));
    }
    return DemoPage(
      widgetName: 'BaseScaffold',
      materialDesc: 'use Scaffold',
      cupertinoDesc: 'CupertinoPageScaffold',
      parameterDesc: const <String, String>{
        'safeAreaTop': 'Cupertino模式下有效，默认false。'
            '相当于SafeArea的top，当状态栏背景色可能为透明时，'
            '且没有用到BoxScrollView等自动设置top padding的组件时， '
            '可以设置为true，此时页面起点在导航栏下方',
        'safeAreaBottom': 'Cupertino模式下有效，默认false。相当于SafeArea的bottom，'
            '设置为true可以避免页面被iphone下方的Home Indicator遮住',
      },
      demos: _demos,
    );
  }
}

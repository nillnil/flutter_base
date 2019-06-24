import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

/// Route 示例
class RouteDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[
      DemoTile(
        page: _Demo(),
      )
    ];
    return DemoPage(
      title: 'Route',
      widgetName: 'BaseRoute',
      materialDesc: 'use MaterialPageRoute',
      cupertinoDesc: 'use CupertinoPageRoute',
      parameterDesc: const <String, String> {
        'backGestureWidth': 'Cupertino模式下有效，默认20.0，设置右滑返回时离屏幕边缘的宽度',
        'fullscreenGackGesture': 'Cupertino模式下有效，默认false，该值设置成true时，'
          'backGestureWidth = MediaQuery.of(context).size.width, 可以实现全屏右滑返回，且'
          'backGestureWidth参数失效',
      },
      tips: 'Use like: \nBaseRoute<void>('
          '\n\t\t...\n).push(context);'
          '\nor\n'
          'pushBaseRoute(\n\t\t\t'
          'BaseRoute<void>(...)\n\t\t\t'
          'context,\n\t\t\t'
          '...\n'
          ');',
      demos: _demos,
    );
  }
}

class _Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: BaseButton(
              color: Colors.white,
              child: const Text(
                'normal',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                pushBaseRoute(
                  BaseRoute<void>(
                    const _NewPage(title: 'normal route'),
                    fullscreenGackGesture: false,
                  ),
                  context,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: BaseButton(
              color: Colors.white,
              child: const Text(
                'fullscreenGackGesture',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                pushBaseRoute(
                  BaseRoute<void>(
                    const _NewPage(title: 'fullscreenGackGesture'),
                    fullscreenGackGesture: true,
                  ),
                  context,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: BaseButton(
              color: Colors.white,
              child: const Text(
                'fullscreen',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                BaseRoute<void>(
                  const _NewPage(title: 'fullscreen route'),
                  fullscreenDialog: true,
                ).push(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NewPage extends StatelessWidget {
  const _NewPage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: Text('New Page'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }
}

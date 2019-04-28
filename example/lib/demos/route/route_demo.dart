import 'package:base/base.dart';
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
      tips: 'Use like: \nBaseRoute<void>('
          '\n\t\t...\n).push(context);',
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
                BaseRoute<void>(
                  _NewPage(title: 'normal route'),
                ).push(context);
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
                  _NewPage(title: 'fullscreen route'),
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
  _NewPage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: const Text('New Page'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }
}

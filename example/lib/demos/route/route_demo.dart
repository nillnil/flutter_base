import 'package:base/base.dart';
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:example/demos/utils/color_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'BaseRoute',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(children: <Widget>[
            ColorBlock.material(),
            const Expanded(
              child: Text('Material：use MaterialPageRoute'),
            )
          ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.cupertino(),
              const Expanded(
                child: Text(
                  'Cupertino：use CupertinoPageRoute',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: Text(
                  'Use like: \nBaseRoute<void>(\n\t\t...\n).push(context);',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
  }): super(key: key);

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
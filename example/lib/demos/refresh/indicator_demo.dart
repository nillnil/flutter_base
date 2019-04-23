import 'package:base/base.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';
import '../demos.dart';

class IndicatorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[
      DemoTile(
        page: Container(
          padding: const EdgeInsets.all(50.0),
          alignment: Alignment.center,
          child: BaseIndicator(
            radius: 20.0,
          ),
        ),
      )
    ];
    return DemoPage(
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'BaseIndicator',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(children: <Widget>[
            ColorBlock.material(),
            const Expanded(
              child: Text('Material：use CircularProgressIndicator'),
            )
          ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.cupertino(),
              const Expanded(
                child: Text(
                  'Cupertino：use CupertinoActivityIndicator',
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
import 'package:base/base.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

class IndicatorDemo extends StatelessWidget {
  const IndicatorDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[
      DemoTile(
        page: Container(
          padding: const EdgeInsets.all(50.0),
          alignment: Alignment.center,
          child: const BaseIndicator(
            radius: 20.0,
          ),
        ),
      )
    ];
    return DemoPage(
      widgetName: 'BaseIndicator',
      materialDesc: 'use CircularProgressIndicator',
      cupertinoDesc: 'use CupertinoActivityIndicator',
      demos: _demos,
    );
  }
}

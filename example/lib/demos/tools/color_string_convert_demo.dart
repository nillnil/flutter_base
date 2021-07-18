import 'package:base/base.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

class ColorStringConvertDemo extends StatelessWidget {
  const ColorStringConvertDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'Color String Convert',
      desc: '\n用于color与argb，rgb，rgba互转，参数请自行检验'
          '\ncolorToArgb(color), colorToRgb(color), colorToRgba(color)'
          '\nargbToColor(argb), rgbToColor(rgb), rgbaToColor(rgba)',
      demos: <DemoTile>[
        DemoTile(
          page: _Demo(),
        ),
      ],
    );
  }
}

class _Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  BaseRandomColor _randomColor = BaseRandomColor();

  Color get _color => _randomColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: 100,
              color: _color,
              alignment: Alignment.center,
              child: const Text('Tap me'),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            onTap: () {
              _randomColor = BaseRandomColor();
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                const Text('argb: '),
                Text(colorToArgb(_color))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[const Text('rgb: '), Text(colorToRgb(_color))],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                const Text('rgba: '),
                Text(colorToRgba(_color))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

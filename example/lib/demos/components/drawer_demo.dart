import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

/// Drawer 说明
class DrawerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'Drawer',
      widgetName: 'BaseDrawer',
      materialDesc: '自定义Drawer',
      cupertinoDesc: '自定义Drawer',
      parameterDesc: const <String, String> {
        'axisDirection': 'Drawer 向哪个方向画出，默认 AxisDirection.right',
        'duration': '画出动画时间，默认 300ms. ',
        'backgroundColor': '背景颜色, 默认 Colors.black54',
        'size': 'Drawer的大小',
        'percent': '高度/宽度的百分比，默认50. 当有size参数时，该参数失效',
      },
      tips: 'Use like: \npushBaseDrawer<void>(\n\t\t\t'
          'context: ...\n\t\t\t'
          'drawer: BaseDrawer(...)\n'
          ');'
          '\nor\n'
          'BaseDrawer(\n\t\t\t'
          '...\n'
          ').push<void>(context);',
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
  State<StatefulWidget> createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  TextEditingController _colorController;
  TextEditingController _durationController;
  TextEditingController _widthController;
  AxisDirection _axisDirection = AxisDirection.right;
  String _directionText = '向右';

  final TextStyle _textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );

  final EdgeInsets _textPadding = const EdgeInsets.symmetric(
    vertical: 5.0,
    horizontal: 5.0,
  );

  @override
  void initState() {
    super.initState();
    _colorController = TextEditingController(
      text: _colorToString(Colors.black54),
    );
    _durationController = TextEditingController(
      text: '${300}',
    );
    _widthController = TextEditingController(
      text: '${50}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('背景色(rgba)  '),
                Container(
                  height: 32,
                  width: 120,
                  color: Colors.white,
                  child: BaseTextField(
                    controller: _colorController,
                    padding: _textPadding,
                    materialDecoration: InputDecoration(
                      contentPadding: _textPadding,
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('动画时间(ms)  '),
                Container(
                  height: 32,
                  width: 100,
                  color: Colors.white,
                  child: BaseTextField(
                    controller: _durationController,
                    padding: _textPadding,
                    materialDecoration: InputDecoration(
                      contentPadding: _textPadding,
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('宽度/高度(%)  '),
                Container(
                  height: 32,
                  width: 100,
                  color: Colors.white,
                  child: BaseTextField(
                    controller: _widthController,
                    padding: _textPadding,
                    materialDecoration: InputDecoration(
                      contentPadding: _textPadding,
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('方向  '),
                BaseButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    _directionText,
                    style: _textStyle,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (_) {
                        int initialItem = 0;
                        switch (_axisDirection) {
                          case AxisDirection.right:
                            initialItem = 0;
                            break;
                          case AxisDirection.left:
                            initialItem = 1;
                            break;
                          case AxisDirection.up:
                            initialItem = 2;
                            break;
                          case AxisDirection.down:
                            initialItem = 3;
                            break;
                          default:
                            initialItem = 0;
                            break;
                        }
                        final FixedExtentScrollController _scrollController =
                            FixedExtentScrollController(
                          initialItem: initialItem,
                        );
                        return SizedBox(
                          height: 200,
                          child: CupertinoPicker(
                            itemExtent: 32.0,
                            backgroundColor: Colors.white,
                            children: const <Widget>[
                              Text('向右'),
                              Text('向左'),
                              Text('向上'),
                              Text('向下'),
                            ],
                            scrollController: _scrollController,
                            onSelectedItemChanged: (int index) {
                              switch (index) {
                                case 0:
                                  _axisDirection = AxisDirection.right;
                                  _directionText = '向右';
                                  break;
                                case 1:
                                  _axisDirection = AxisDirection.left;
                                  _directionText = '向左';
                                  break;
                                case 2:
                                  _axisDirection = AxisDirection.up;
                                  _directionText = '向上';
                                  break;
                                case 3:
                                  _axisDirection = AxisDirection.down;
                                  _directionText = '向下';
                                  break;
                                default:
                                  _axisDirection = AxisDirection.right;
                                  _directionText = '向右';
                                  break;
                              }
                              setState(() {});
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          BaseButton(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 15.0,
            ),
            child: Text(
              '打开Drawer',
              style: _textStyle,
            ),
            color: Colors.white,
            onPressed: () {
              // pushBaseDrawer<void>(context, _buildDrawer());
              _buildDrawer().push<void>(context);
            },
          ),
        ],
      ),
    );
  }

  BaseDrawer _buildDrawer() {
    int duration;
    try {
      duration = int.parse(_durationController.text).abs();
    } catch (e) {
      _durationController.text = '${300}';
      duration = 300;
    }
    double percent;
    try {
      percent = double.parse(_widthController.text).abs();
    } catch (e) {
      _widthController.text = '${50}';
      percent = 50;
    }
    percent = percent.clamp(0.0, 100.0);
    return BaseDrawer(
      backgroundColor: _stringToColor(_colorController.text),
      duration: Duration(
        milliseconds: duration,
      ),
      percent: percent,
      axisDirection: _axisDirection,
      child: Container(
        color: Colors.white,
        child: ListView.separated(
          itemCount: 20,
          separatorBuilder: (_, __) => const Divider(
            height: 0.0,
          ),
          itemBuilder: (_, int index) {
            return BaseTile(
              titleText: '${index + 1}',
            );
          },
        ),
      ),
    );
  }

  Color _stringToColor(String string) {
    if (string.startsWith('#')) {
      string = string.replaceAll('#', '');
    }
    final int red = int.parse(string.substring(0, 2), radix: 16);
    final int green = int.parse(string.substring(2, 4), radix: 16);
    final int blue = int.parse(string.substring(4, 6), radix: 16);
    int alpha = 255;
    if (string.length > 6) {
      alpha = int.parse(string.substring(6, 8), radix: 16);
    }
    return Color.fromARGB(alpha, red, green, blue);
  }

  String _colorToString(Color color) {
    String _redStr = color.red.toRadixString(16);
    String _greenStr = color.green.toRadixString(16);
    String _blueStr = color.blue.toRadixString(16);
    String _alphaStr = color.alpha.toRadixString(16);
    if (color.red < 10) {
      _redStr = '0$_redStr';
    }
    if (color.green < 10) {
      _greenStr = '0$_greenStr';
    }
    if (color.blue < 10) {
      _blueStr = '0$_blueStr';
    }
    if (color.alpha < 10) {
      _alphaStr = '0$_alphaStr}';
    }
    return '#$_redStr$_greenStr$_blueStr$_alphaStr';
  }

  @override
  void dispose() {
    _colorController.dispose();
    _durationController.dispose();
    _widthController.dispose();
    super.dispose();
  }
}

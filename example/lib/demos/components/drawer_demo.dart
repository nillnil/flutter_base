import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

final FocusNode _focusNode = FocusNode();

/// Drawer 说明
class DrawerDemo extends StatelessWidget {
  const DrawerDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: DemoPage(
        title: 'Drawer',
        widgetName: 'BaseDrawer',
        materialDesc: '自定义Drawer',
        cupertinoDesc: '自定义Drawer',
        parameterDesc: const <String, String>{
          'axisDirection': 'Drawer 向哪个方向滑出，默认 AxisDirection.right',
          'duration': '画出动画时间，默认 300ms. ',
          'backgroundColor': '背景颜色, 默认 Colors.black54',
          'size':
              'Drawer的大小, 当size == null && percent == null 时，size = Size.fromWidth(304)，取至Drawer默认宽度',
          'percent': '高度/宽度的百分比，size与percent不能同时提供',
          'allowMultipleGesture': '是否允许多手势，默认false，允许多手势时，子widget必须自己处理冲突\n'
              '可使用allowMultipleGesture()，notAllowMultipleGesture()开启或关闭多手势，以便于解决手势冲突'
        },
        tips: 'Use like: \nopenBaseDrawer<void>(\n\t\t\t'
            'context: ...\n\t\t\t'
            'drawer: BaseDrawer(...)\n'
            ');'
            '\nor\n'
            'BaseDrawer(\n\t\t\t'
            '...\n'
            ').open<void>(context);',
        demos: <DemoTile>[
          DemoTile(
            page: _Demo(),
          ),
        ],
      ),
    );
  }
}

const EdgeInsets _textPadding = EdgeInsets.symmetric(
  vertical: 5.0,
  horizontal: 5.0,
);

const TextStyle _textStyle = TextStyle(
  color: Colors.black,
  fontSize: 16.0,
);

class _Demo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  TextEditingController? _colorController;
  TextEditingController? _durationController;
  TextEditingController? _widthController;
  AxisDirection _axisDirection = AxisDirection.right;
  String _directionText = '向右';

  final GlobalObjectKey<BaseDrawerState> _drawerKey =
      const GlobalObjectKey<BaseDrawerState>('DrawerDemoKey');
  bool _gestureConflict = true;
  bool _allowGesture = true;
  bool _allowMutipleGesture = false;

  @override
  void initState() {
    super.initState();
    _colorController = TextEditingController(
      text: '#${colorToRgba(Colors.black54)}',
    );
    _durationController = TextEditingController(
      text: '300',
    );
    _widthController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _BgColor(colorController: _colorController!),
          _Animate(durationController: _durationController!),
          _Size(widthController: _widthController!),
          _AxisButton(
            axisDirection: _axisDirection,
            directionText: _directionText,
            onSelectedItemChanged: _onAxisChange,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('允许手势滑动  '),
                if (isCupertinoMode)
                  Container(
                    height: 31.0,
                    width: 48.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: BaseSwitch(
                      value: _allowGesture,
                      onChanged: (bool value) {
                        setState(() {
                          _allowGesture = value;
                        });
                      },
                    ),
                  )
                else
                  BaseSwitch(
                    value: _allowGesture,
                    onChanged: (bool value) {
                      setState(() {
                        _allowGesture = value;
                      });
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('允许多手势  '),
                if (isCupertinoMode)
                  Container(
                    height: 31.0,
                    width: 48.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: BaseSwitch(
                      value: _allowMutipleGesture,
                      onChanged: (bool value) {
                        setState(() {
                          if (value) {
                            _axisDirection = AxisDirection.up;
                            _directionText = '向上';
                          }
                          _allowMutipleGesture = value;
                        });
                      },
                    ),
                  )
                else
                  BaseSwitch(
                    value: _allowMutipleGesture,
                    onChanged: (bool value) {
                      setState(() {
                        if (value) {
                          _axisDirection = AxisDirection.up;
                          _directionText = '向上';
                        }
                        _allowMutipleGesture = value;
                      });
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
            child: const Text(
              '打开Drawer',
              style: _textStyle,
            ),
            color: Colors.white,
            onPressed: () {
              // pushBaseDrawer<void>(context, _buildDrawer());
              _buildDrawer().open<void>(context);
            },
          ),
        ],
      ),
    );
  }

  void _onAxisChange(int index) {
    switch (index) {
      case 0:
        _axisDirection = AxisDirection.right;
        _directionText = '向右';
        _allowMutipleGesture = false;
        break;
      case 1:
        _axisDirection = AxisDirection.left;
        _directionText = '向左';
        _allowMutipleGesture = false;
        break;
      case 2:
        _axisDirection = AxisDirection.up;
        _directionText = '向上';
        break;
      case 3:
        _axisDirection = AxisDirection.down;
        _directionText = '向下';
        _allowMutipleGesture = false;
        break;
      default:
        _axisDirection = AxisDirection.right;
        _directionText = '向右';
        _allowMutipleGesture = false;
        break;
    }
    setState(() {});
  }

  BaseDrawer _buildDrawer() {
    int duration;
    try {
      duration = int.parse(_durationController!.text).abs();
    } catch (e) {
      _durationController!.text = '300';
      duration = 300;
    }
    Size? size;
    double? percent;
    try {
      String text = _widthController!.text;
      if (text.endsWith('%')) {
        text = text.replaceAll('%', '');
        percent = double.parse(text).abs();
        percent = percent.clamp(0.0, 100.0);
      } else {
        if (text.isEmpty) {
          percent = null;
        } else {
          final double num = double.parse(text).abs();
          if (_axisDirection == AxisDirection.left ||
              _axisDirection == AxisDirection.right) {
            size = Size.fromWidth(num);
          } else {
            size = Size.fromHeight(num);
          }
        }
      }
    } catch (e) {
      _widthController!.text = '';
      percent = null;
    }
    final ScrollController _scrollController = ScrollController();
    _gestureConflict = true;
    if (_axisDirection == AxisDirection.up) {
      _scrollController.addListener(() {
        if (_scrollController.offset < 0) {
          _scrollController.jumpTo(0.0);
          if (!_gestureConflict) {
            _gestureConflict = true;
            _drawerKey.currentState?.allowMultipleGesture();
          }
        } else if (_scrollController.offset > 0 && _gestureConflict) {
          _gestureConflict = false;
          _drawerKey.currentState?.notAllowMultipleGesture();
        }
      });
    }
    return BaseDrawer(
      key: _drawerKey,
      backgroundColor: rgbaToColor(_colorController!.text),
      duration: Duration(
        milliseconds: duration,
      ),
      size: size,
      percent: percent,
      axisDirection: _axisDirection,
      child: Container(
        color: const BaseColor(
          dynamicColor: CupertinoColors.secondarySystemGroupedBackground,
        ).build(context),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          controller: _scrollController,
          itemCount: 20,
          separatorBuilder: (_, __) => const Divider(
            height: 0.2,
          ),
          itemBuilder: (_, int index) {
            return BaseTile(
              titleText: '${index + 1}',
            );
          },
        ),
      ),
      allowGesture: _allowGesture,
      allowMultipleGesture: _allowMutipleGesture,
    );
  }

  @override
  void dispose() {
    _colorController?.dispose();
    _durationController?.dispose();
    _widthController?.dispose();
    super.dispose();
  }
}

class _Size extends StatelessWidget {
  const _Size({
    Key? key,
    required TextEditingController widthController,
  })   : _widthController = widthController,
        super(key: key);

  final TextEditingController _widthController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('宽度/高度(可加%)  '),
          SizedBox(
            height: 32,
            width: 100,
            child: BaseTextField(
              controller: _widthController,
              padding: _textPadding,
              cupertinoDecoration: BoxDecoration(
                color: const BaseColor(
                  dynamicColor: CupertinoDynamicColor.withBrightness(
                    color: Colors.white,
                    darkColor: Color.fromARGB(255, 28, 28, 30),
                  ),
                ).build(context),
              ),
              materialDecoration: const InputDecoration(
                contentPadding: _textPadding,
              ),
              textInputAction: TextInputAction.done,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
            ),
          ),
        ],
      ),
    );
  }
}

class _Animate extends StatelessWidget {
  const _Animate({
    Key? key,
    required TextEditingController durationController,
  })   : _durationController = durationController,
        super(key: key);

  final TextEditingController _durationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('动画时间(ms)  '),
          SizedBox(
            height: 32,
            width: 100,
            child: BaseTextField(
              controller: _durationController,
              padding: _textPadding,
              cupertinoDecoration: BoxDecoration(
                color: const BaseColor(
                  dynamicColor: CupertinoDynamicColor.withBrightness(
                    color: Colors.white,
                    darkColor: Color.fromARGB(255, 28, 28, 30),
                  ),
                ).build(context),
              ),
              materialDecoration: const InputDecoration(
                contentPadding: _textPadding,
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}

class _BgColor extends StatelessWidget {
  const _BgColor({
    Key? key,
    required TextEditingController colorController,
  })   : _colorController = colorController,
        super(key: key);

  final TextEditingController _colorController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('背景色(rgba)  '),
          SizedBox(
            height: 32,
            width: 120,
            child: BaseTextField(
              controller: _colorController,
              padding: _textPadding,
              cupertinoDecoration: BoxDecoration(
                color: const BaseColor(
                  dynamicColor: CupertinoDynamicColor.withBrightness(
                    color: Colors.white,
                    darkColor: Color.fromARGB(255, 28, 28, 30),
                  ),
                ).build(context),
              ),
              materialDecoration: const InputDecoration(
                contentPadding: _textPadding,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}

class _AxisButton extends StatelessWidget {
  const _AxisButton({
    Key? key,
    required this.directionText,
    required this.axisDirection,
    required this.onSelectedItemChanged,
  }) : super(key: key);

  final String directionText;
  final AxisDirection axisDirection;
  final Function(int index) onSelectedItemChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              directionText,
              style: _textStyle,
            ),
            color: Colors.white,
            onPressed: () {
              showCupertinoModalPopup<void>(
                context: context,
                builder: (_) {
                  int initialItem = 0;
                  switch (axisDirection) {
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
                      backgroundColor: CupertinoColors.secondarySystemBackground
                          .resolveFrom(context),
                      children: const <Widget>[
                        Text('向右'),
                        Text('向左'),
                        Text('向上'),
                        Text('向下'),
                      ],
                      scrollController: _scrollController,
                      onSelectedItemChanged: (int index) {
                        onSelectedItemChanged(index);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

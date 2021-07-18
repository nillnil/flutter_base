import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

final FocusNode _focusNode = FocusNode();

class RandomColorDemo extends StatelessWidget {
  const RandomColorDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: DemoPage(
        title: 'RandomColor',
        desc: '\n用于创建随机颜色\nColor color = RandomColor(); '
            '用法同Color',
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
  horizontal: 15.0,
);

class _Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

GlobalKey<_ItemState> _redItemKey = GlobalKey<_ItemState>();
GlobalKey<_ItemState> _greenItemKey = GlobalKey<_ItemState>();
GlobalKey<_ItemState> _blueItemKey = GlobalKey<_ItemState>();
GlobalKey<_ItemState> _opacityItemKey = GlobalKey<_ItemState>();
GlobalKey<_ItemState> _alphaItemKey = GlobalKey<_ItemState>();

class _DemoState extends State<_Demo> {
  BaseRandomColor? _randomColor;

  int? _red;
  int? _green;
  int? _blue;
  int? _alpha;
  Color? get _color => _randomColor;

  TextEditingController? _redController;
  TextEditingController? _greenController;
  TextEditingController? _blueController;
  TextEditingController? _opacityController;
  TextEditingController? _alphaController;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _randomColor = BaseRandomColor(
      a: _alpha,
      r: _red,
      g: _green,
      b: _blue,
    );
    _redController = TextEditingController(text: '${_randomColor!.red}');
    _greenController = TextEditingController(text: '${_randomColor!.green}');
    _blueController = TextEditingController(text: '${_randomColor!.blue}');
    _opacityController = TextEditingController(
      text: _randomColor!.opacity.toStringAsFixed(2),
    );
    _alphaController = TextEditingController(text: '${_randomColor!.alpha}');
  }

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
            ),
            onTap: () {
              _refresh();
              FocusScope.of(context).requestFocus(_focusNode);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _Item(
                  key: _redItemKey,
                  text: 'red  ',
                  value: '${_color!.red}',
                  controller: _redController!,
                  onSubmited: (_) {
                    _refresh();
                  },
                ),
                _Item(
                  key: _greenItemKey,
                  text: 'green  ',
                  value: '${_color!.green}',
                  controller: _greenController!,
                  onSubmited: (_) {
                    _refresh();
                  },
                ),
                _Item(
                  key: _blueItemKey,
                  text: 'blue  ',
                  value: '${_color!.blue}',
                  controller: _blueController!,
                  onSubmited: (_) {
                    _refresh();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _Item(
                  key: _opacityItemKey,
                  text: 'opacity  ',
                  value: _color!.opacity.toStringAsFixed(2),
                  controller: _opacityController!,
                  tapCallback: () {
                    _alphaItemKey.currentState?.disabled();
                  },
                  onSubmited: (_) {
                    _refresh();
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                _Item(
                  key: _alphaItemKey,
                  text: 'alpha  ',
                  value: '${_color!.alpha}',
                  controller: _alphaController!,
                  tapCallback: () {
                    _opacityItemKey.currentState?.disabled();
                  },
                  onSubmited: (_) {
                    _refresh();
                  },
                ),
              ],
            ),
          ),
          const _Tips(),
        ],
      ),
    );
  }

  void _refresh() {
    final num? red = _redItemKey.currentState?.getValue();
    final num? green = _greenItemKey.currentState?.getValue();
    final num? blue = _blueItemKey.currentState?.getValue();
    final num? opacity = _opacityItemKey.currentState?.getValue(
      type: 2,
    );
    final num? alpha = _alphaItemKey.currentState?.getValue();
    if (opacity == null) {
      _randomColor = BaseRandomColor(
        a: alpha?.toInt(),
        r: red?.toInt(),
        g: green?.toInt(),
        b: blue?.toInt(),
      );
    } else {
      _randomColor = BaseRandomColor.fromRGBO(
        r: red?.toInt(),
        g: green?.toInt(),
        b: blue?.toInt(),
        opacity: opacity.toDouble(),
      );
    }
    _redController!.text = '${_color!.red}';
    _greenController!.text = '${_color!.green}';
    _blueController!.text = '${_color!.blue}';
    _opacityController!.text = _color!.opacity.toStringAsFixed(2);
    _alphaController!.text = '${_color!.alpha}';
    setState(() {});
  }

  @override
  void dispose() {
    _redController?.dispose();
    _greenController?.dispose();
    _blueController?.dispose();
    _opacityController?.dispose();
    _alphaController?.dispose();
    super.dispose();
  }
}

class _Tips extends StatefulWidget {
  const _Tips({
    Key? key,
  }) : super(key: key);

  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<_Tips> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller?.addListener(() {
      setState(() {});
    });
    _controller?.repeat(
      reverse: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Opacity(
        opacity: _controller!.value,
        child: const Text(
          '双击标签切换编辑模式',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class _Item extends StatefulWidget {
  const _Item({
    Key? key,
    required this.text,
    this.width = 65,
    this.value,
    this.enabled = false,
    this.readonly = false,
    this.controller,
    this.tapCallback,
    this.onSubmited,
    this.keyboardType = TextInputType.number,
  }) : super(key: key);

  final String text;
  final String? value;
  final double width;
  final bool enabled;
  final bool readonly;
  final TextEditingController? controller;
  final VoidCallback? tapCallback;
  final ValueChanged<String>? onSubmited;
  final TextInputType keyboardType;

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _enabled = widget.enabled;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: Text(
            widget.text,
            style: _enabled
                ? null
                : const TextStyle(
                    color: Colors.grey,
                  ),
          ),
          onDoubleTap: () {
            if (!widget.readonly) {
              setState(() {
                _enabled = !_enabled;
              });
              if (widget.tapCallback != null) {
                widget.tapCallback!();
              }
            }
          },
        ),
        SizedBox(
          width: widget.width,
          child: BaseTextField(
            padding: _textPadding,
            controller: widget.controller ??
                TextEditingController(
                  text: widget.value ?? '',
                ),
            textAlign: TextAlign.center,
            enabled: _enabled,
            onSubmitted: (String text) {
              if (widget.onSubmited != null) {
                widget.onSubmited!(text);
              }
            },
            cupertinoDecoration: BoxDecoration(
              color: BaseColor(
                dynamicColor: CupertinoDynamicColor.withBrightness(
                  color: _enabled ? Colors.white : Colors.grey.withOpacity(.2),
                  darkColor: _enabled
                      ? const Color.fromARGB(255, 28, 28, 30)
                      : Colors.black.withOpacity(.2),
                ),
              ).build(context),
            ),
            materialDecoration: const InputDecoration(
              contentPadding: _textPadding,
            ),
            textInputAction: TextInputAction.done,
            keyboardType: widget.keyboardType,
          ),
        ),
      ],
    );
  }

  /// type = 1 return int
  /// type = 2 return double
  num? getValue({int type = 1}) {
    if (_enabled) {
      String? text = widget.controller!.text;
      num? n;
      try {
        if (type == 1) {
          n = int.parse(text).clamp(0, 255);
        } else {
          n = double.parse(text).clamp(0, 1.0);
        }
      } catch (e) {
        text = null;
      }
      return n;
    }
    return null;
  }

  void disabled() {
    setState(() {
      _enabled = false;
    });
  }
}

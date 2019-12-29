import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const Duration _drawerTransitionDuration = Duration(milliseconds: 300);

const Color _drawerBackgroundColor = Colors.black54;

const double _minFlingVelocity = 1.0;

/// alose see [Drawer._kWidth]
const double _defaultDrawerSize = 304;

/// 自定义drawer
/// 不可指定起点位置跟终点位置
/// default is 304 width or height
class BaseDrawer extends StatefulWidget {
  const BaseDrawer({
    Key key,
    this.duration = _drawerTransitionDuration,
    this.axisDirection = AxisDirection.right,
    this.size,
    this.percent,
    this.backgroundColor = _drawerBackgroundColor,
    @required this.child,
    this.curve = Curves.linearToEaseOut,
    this.reverseCurve = Curves.linearToEaseOut,
    this.allowGesture = true,
    this.allowMultipleGesture = false,
    this.barrierDismissible = true,
  })  : assert(size == null || percent == null,
            'Cannot provide both a size and a percent'),
        assert(child != null),
        super(key: key);

  const BaseDrawer.size({
    Key key,
    this.duration = _drawerTransitionDuration,
    this.axisDirection = AxisDirection.right,
    this.backgroundColor = _drawerBackgroundColor,
    @required this.size,
    @required this.child,
    this.curve = Curves.linearToEaseOut,
    this.reverseCurve = Curves.linearToEaseOut,
    this.allowGesture = true,
    this.allowMultipleGesture = false,
    this.barrierDismissible = true,
  })  : percent = 0.0,
        assert(size != null),
        assert(child != null),
        super(key: key);

  /// 指定百分比
  const BaseDrawer.percent({
    Key key,
    this.duration = _drawerTransitionDuration,
    this.axisDirection = AxisDirection.right,
    this.backgroundColor = _drawerBackgroundColor,
    @required this.percent,
    @required this.child,
    this.curve = Curves.linearToEaseOut,
    this.reverseCurve = Curves.linearToEaseOut,
    this.allowGesture = true,
    this.allowMultipleGesture = false,
    this.barrierDismissible = true,
  })  : size = null,
        assert(percent > 0 && percent <= 100),
        assert(child != null),
        super(key: key);

  /// 指定宽度
  /// axisDirection 只能为 AxisDirection.left or AxisDirection.right
  BaseDrawer.width({
    Key key,
    this.duration = _drawerTransitionDuration,
    this.axisDirection = AxisDirection.right,
    this.backgroundColor = _drawerBackgroundColor,
    @required double width,
    @required this.child,
    this.curve = Curves.linearToEaseOut,
    this.reverseCurve = Curves.linearToEaseOut,
    this.allowGesture = true,
    this.allowMultipleGesture = false,
    this.barrierDismissible = true,
  })  : size = Size.fromWidth(width),
        percent = 0.0,
        assert(width > 0),
        assert(axisDirection == AxisDirection.right ||
            axisDirection == AxisDirection.left,
            'the axisDirection must be AxisDirection.left or AxisDirection.right.'),
        assert(child != null),
        super(key: key);

  /// 指定高度
  /// axisDirection 只能为 AxisDirection.up or AxisDirection.down
  BaseDrawer.height({
    Key key,
    this.duration = _drawerTransitionDuration,
    this.axisDirection = AxisDirection.up,
    this.backgroundColor = _drawerBackgroundColor,
    @required double height,
    @required this.child,
    this.curve = Curves.linearToEaseOut,
    this.reverseCurve = Curves.linearToEaseOut,
    this.allowGesture = true,
    this.allowMultipleGesture = false,
    this.barrierDismissible = true,
  })  : size = Size.fromHeight(height),
        percent = 0.0,
        assert(height > 0),
        assert(
            axisDirection == AxisDirection.up ||
                axisDirection == AxisDirection.down,
            'the axisDirection must be AxisDirection.up or AxisDirection.down.'),
        assert(child != null),
        super(key: key);

  /// transitionDuration, default is [_drawerTransitionDuration]
  final Duration duration;

  /// axisDirection
  final AxisDirection axisDirection;

  /// size
  final Size size;

  /// (width or height)'s percent
  /// Cannot provide both a size and a percent
  /// size == null && percent == null, the size = _defaultDrawerSize
  /// axisDirection = up / down, width = 100%, height = percent
  /// axisDirection = left / right, width = percent, height = 100%
  final double percent;

  /// backgroundColor
  final Color backgroundColor;

  /// child
  final Widget child;

  final Curve curve;

  final Curve reverseCurve;

  // 是否允许手势
  // true 则可以滑动
  final bool allowGesture;

  // 是否允许多手势
  // 允许多手势时，子widget必须自己处理冲突
  final bool allowMultipleGesture;

  // 点击背景是否关闭，默认true
  final bool barrierDismissible;

  @override
  State<StatefulWidget> createState() => BaseDrawerState();

  Future<T> open<T>(
    BuildContext context, {
    bool rootNavigator = true,
  }) {
    return Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        transitionDuration: duration,
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return this;
        },
      ),
    );
  }

  void close(
    GlobalObjectKey<BaseDrawerState> drawerKey,
  ) {
    drawerKey.currentState.close();
  }
}

class BaseDrawerState extends State<BaseDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _slideAnimationController;

  Widget _child;

  Size _size;
  Size _drawerSize = Size.zero;
  Axis _axis;
  double _tweenBegin;
  double _tweenEnd = 0.0;
  ColorTween _colorTween;

  double _offset = 0.0;
  final double _hideDrawerOffsetPercent = .5;
  double _hideDrawerOffset;

  double _flingVelocitySize;

  bool _gestureConflict = true;
  final Map<Type, GestureRecognizerFactory> _gestures =
      <Type, GestureRecognizerFactory>{};

  final GlobalKey _gestureDetectorKey = GlobalKey();
  final GlobalKey _backgroundGestureDetectorKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _colorTween = ColorTween(
      begin: Colors.transparent,
      end: widget.backgroundColor,
    );

    // slideAnimation
    _slideAnimationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    CurvedAnimation(
      parent: _slideAnimationController,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
    );
    _slideAnimationController.addListener(() {
      setState(() {
        _offset = _lerpOffsetTween(_slideAnimationController.value);
      });
    });
    _slideAnimationController.forward();

    Timer(const Duration(milliseconds: 0), () {
      _init();
    });
  }

  void _init() {
    _size ??= MediaQuery.of(context).size;
    Size widgetSize = widget.size;
    final double percent = widget.percent;
    switch (widget.axisDirection) {
      case AxisDirection.left:
        // widget params
        if (widgetSize == null && percent == null) {
          widgetSize = const Size.fromWidth(_defaultDrawerSize);
        }
        _drawerSize = widgetSize ??
            Size.fromWidth(
              _size.width * percent / 100,
            );
        _drawerSize = resetSize(_drawerSize, context);
        _hideDrawerOffset = _drawerSize.width * _hideDrawerOffsetPercent;
        _flingVelocitySize = _drawerSize.width;

        // animation params
        _axis = Axis.horizontal;
        _tweenBegin = _size.width;
        _tweenEnd = _size.width - _drawerSize.width;
        break;
      case AxisDirection.right:
        // widget params
        if (widgetSize == null && percent == null) {
          widgetSize = const Size.fromWidth(_defaultDrawerSize);
        }
        _drawerSize = widgetSize ??
            Size.fromWidth(
              _size.width * percent / 100,
            );
        _drawerSize = resetSize(_drawerSize, context);
        _hideDrawerOffset = _drawerSize.width * _hideDrawerOffsetPercent;
        _flingVelocitySize = _drawerSize.width;

        // animation params
        _axis = Axis.horizontal;
        _tweenBegin = -_drawerSize.width;
        _tweenEnd = 0.0;
        break;
      case AxisDirection.up:
        // widget params
        if (widgetSize == null && percent == null) {
          widgetSize = const Size.fromHeight(_defaultDrawerSize);
        }
        _drawerSize = widgetSize ??
            Size.fromHeight(
              _size.height * percent / 100,
            );
        _drawerSize = resetSize(_drawerSize, context);
        _hideDrawerOffset = _drawerSize.height * _hideDrawerOffsetPercent;
        _flingVelocitySize = _drawerSize.height;

        // animation params
        _axis = Axis.vertical;
        _tweenBegin = _size.height;
        _tweenEnd = _size.height - _drawerSize.height;
        break;
      case AxisDirection.down:
        // widget params
        if (widgetSize == null && percent == null) {
          widgetSize = const Size.fromHeight(_defaultDrawerSize);
        }
        _drawerSize = widgetSize ??
            Size.fromHeight(
              _size.height * percent / 100,
            );
        _drawerSize = resetSize(_drawerSize, context);
        _hideDrawerOffset = _drawerSize.height * _hideDrawerOffsetPercent;
        _flingVelocitySize = _drawerSize.height;

        // animation params
        _axis = Axis.vertical;
        _tweenBegin = -_drawerSize.height;
        _tweenEnd = 0.0;
        break;
    }

    // child
    _child = Container(
      child: SizedBox(
        width: _drawerSize.width,
        height: _drawerSize.height,
        child: widget.child,
      ),
    );

    // gestures
    if (widget.allowGesture) {
      if (widget.allowMultipleGesture) {
        _gestureConflict = true;
      } else {
        _gestureConflict = false;
      }
      if (_axis == Axis.horizontal) {
        _gestures[_DrawerHorizontalDragGestureRecognizer] =
            GestureRecognizerFactoryWithHandlers<
                _DrawerHorizontalDragGestureRecognizer>(
          () => _DrawerHorizontalDragGestureRecognizer(
            conflict: _gestureConflict,
          ),
          (_DrawerHorizontalDragGestureRecognizer instance) {
            instance.onUpdate =
                (DragUpdateDetails details) => _onDragUpdate(details);
            instance.onEnd = (DragEndDetails details) => _onDragEnd(details);
          },
        );
      } else {
        _gestures[_DrawerVerticalDragGestureRecognizer] =
            GestureRecognizerFactoryWithHandlers<
                _DrawerVerticalDragGestureRecognizer>(
          () => _DrawerVerticalDragGestureRecognizer(
            conflict: _gestureConflict,
          ),
          (_DrawerVerticalDragGestureRecognizer instance) {
            instance.onUpdate =
                (DragUpdateDetails details) => _onDragUpdate(details);
            instance.onEnd = (DragEndDetails details) => _onDragEnd(details);
          },
        );
      }
    }
  }

  // 保证size不超过屏幕物理大小
  Size resetSize(Size size, BuildContext context) {
    double width = size.width;
    double height = size.height;
    final Size physicalSize = MediaQuery.of(context, nullOk: true)?.size;
    if (physicalSize != null) {
      width = min(width, physicalSize.width);
      height = min(height, physicalSize.height);
      size = Size(width, height);
    }
    return size;
  }

  @override
  Widget build(BuildContext context) {
    Widget backgroundWidget = Container(
      color: _colorTween.evaluate(_slideAnimationController),
    );

    if (widget.barrierDismissible) {
      backgroundWidget = GestureDetector(
        key: _backgroundGestureDetectorKey,
        child: backgroundWidget,
        onTap: () {
          close();
        },
      );
    }
    return RawGestureDetector(
      key: _gestureDetectorKey,
      gestures: _gestures,
      child: Stack(
        children: <Widget>[
          backgroundWidget,
          Transform.translate(
            offset: _axis == Axis.horizontal
                ? Offset(_offset, 0.0)
                : Offset(0.0, _offset),
            child: _child,
          ),
        ],
      ),
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!widget.allowMultipleGesture ||
        (widget.allowMultipleGesture && _gestureConflict)) {
      switch (widget.axisDirection) {
        case AxisDirection.left:
          _offset = max(0.0, _offset + details.delta.dx);
          break;
        case AxisDirection.right:
          _offset = min(0.0, _offset + details.delta.dx);
          break;
        case AxisDirection.up:
          _offset = max(0.0, _offset + details.delta.dy);
          break;
        case AxisDirection.down:
          _offset = min(0.0, _offset + details.delta.dy);
          break;
      }
      _slideAnimationController.value = _lerpOffset();
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (!widget.allowMultipleGesture ||
        (widget.allowMultipleGesture && _gestureConflict)) {
      final double _primaryVelocity =
          details.primaryVelocity / _flingVelocitySize;
      final double _interval = _offset.abs() - _tweenEnd;
      if (_primaryVelocity.abs() > _minFlingVelocity) {
        bool _open = false;
        switch (widget.axisDirection) {
          case AxisDirection.left:
          case AxisDirection.up:
            if (_primaryVelocity > 0) {
              _open = false;
            } else {
              _open = true;
            }
            break;
          case AxisDirection.right:
          case AxisDirection.down:
            if (_primaryVelocity > 0) {
              _open = true;
            } else {
              _open = false;
            }
            break;
        }
        if (_open) {
          open();
        } else {
          close();
        }
      } else if (_interval > _hideDrawerOffset) {
        close();
      } else {
        open();
      }
    }
  }

  double _lerpOffsetTween(double value) {
    return _tweenBegin + (_tweenEnd - _tweenBegin) * value;
  }

  double _lerpOffset() {
    return (_offset - _tweenBegin) / (_tweenEnd - _tweenBegin);
  }

  void close() {
    _slideAnimationController.reverse(
      from: _lerpOffset(),
    );
    Navigator.of(context).pop();
  }

  void open() {
    _slideAnimationController.forward(
      from: _lerpOffset(),
    );
  }

  void allowMultipleGesture() {
    setState(() {
      _gestureConflict = true;
    });
  }

  void notAllowMultipleGesture() {
    setState(() {
      _gestureConflict = false;
    });
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }
}

class _DrawerVerticalDragGestureRecognizer
    extends VerticalDragGestureRecognizer {
  _DrawerVerticalDragGestureRecognizer({
    this.conflict = false,
  });

  // 是否允许手势冲突
  // 允许冲突时，子widget必须自己处理冲突
  final bool conflict;

  @override
  void rejectGesture(int pointer) {
    if (!conflict) {
      super.rejectGesture(pointer);
    } else {
      super.acceptGesture(pointer);
    }
  }
}

class _DrawerHorizontalDragGestureRecognizer
    extends HorizontalDragGestureRecognizer {
  _DrawerHorizontalDragGestureRecognizer({
    this.conflict = false,
  });

  // 是否允许手势冲突
  // 允许冲突时，子widget必须自己处理冲突
  final bool conflict;

  @override
  void rejectGesture(int pointer) {
    if (!conflict) {
      super.rejectGesture(pointer);
    } else {
      super.acceptGesture(pointer);
    }
  }
}

Future<T> openBaseDrawer<T>(
  BuildContext context,
  BaseDrawer drawer, {
  bool rootNavigator = true,
}) {
  return Navigator.of(
    context,
    rootNavigator: rootNavigator,
  ).push<T>(
    PageRouteBuilder<T>(
      opaque: false,
      transitionDuration: drawer.duration,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return drawer;
      },
    ),
  );
}

void closeBaseDrawer(
  GlobalObjectKey<BaseDrawerState> drawerKey,
) {
  drawerKey.currentState.close();
}

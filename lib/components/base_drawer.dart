import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const Duration _drawerTransitionDuration = Duration(milliseconds: 300);

const Color _drawerBackgroundColor = Colors.black54;

const double _minFlingVelocity = 1.0;

class BaseDrawer extends StatefulWidget {
  const BaseDrawer({
    Key key,
    this.duration = _drawerTransitionDuration,
    this.axisDirection = AxisDirection.right,
    this.size,
    this.percent = 50,
    this.backgroundColor = _drawerBackgroundColor,
    @required this.child,
    this.curve = Curves.linearToEaseOut,
    this.reverseCurve = Curves.easeInToLinear,
  })  : assert(percent > 0 && percent <= 100),
        assert(child != null),
        super(key: key);

  /// transitionDuration, default is [_drawerTransitionDuration]
  final Duration duration;

  /// axisDirection
  final AxisDirection axisDirection;

  /// size
  final Size size;

  /// (width or height)'s percent, when the size is null, percent will use, default is 50
  /// axisDirection = up / down, width = 100%, height = percent
  /// axisDirection = left / right, width = percent, height = 100%
  final double percent;

  /// backgroundColor
  final Color backgroundColor;

  /// child
  final Widget child;

  final Curve curve;

  final Curve reverseCurve;

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
  Size _drawerSize;
  Axis _axis;
  double _tweenBegin;
  double _tweenEnd;
  ColorTween _colorTween;

  double _offset = 0.0;
  final double _hideDrawerOffsetPercent = .5;
  double _hideDrawerOffset;

  double _flingVelocitySize;

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
    switch (widget.axisDirection) {
      case AxisDirection.left:
        // widget params
        _drawerSize = widget.size ??
            Size.fromWidth(
              _size.width * widget.percent / 100,
            );
        _hideDrawerOffset = _drawerSize.width * _hideDrawerOffsetPercent;
        _flingVelocitySize = _drawerSize.width;

        // animation params
        _axis = Axis.horizontal;
        _tweenBegin = _size.width;
        _tweenEnd = _size.width - _drawerSize.width;
        break;
      case AxisDirection.right:
        // widget params
        _drawerSize = widget.size ??
            Size.fromWidth(
              _size.width * widget.percent / 100,
            );
        _hideDrawerOffset = _drawerSize.width * _hideDrawerOffsetPercent;
        _flingVelocitySize = _drawerSize.width;

        // animation params
        _axis = Axis.horizontal;
        _tweenBegin = -_drawerSize.width;
        _tweenEnd = 0.0;
        break;
      case AxisDirection.up:
        // widget params
        _drawerSize = widget.size ??
            Size.fromHeight(
              _size.height * widget.percent / 100,
            );
        _hideDrawerOffset = _drawerSize.height * _hideDrawerOffsetPercent;
        _flingVelocitySize = _drawerSize.height;

        // animation params
        _axis = Axis.vertical;
        _tweenBegin = _size.height;
        _tweenEnd = _size.height - _drawerSize.height;
        break;
      case AxisDirection.down:
        // widget params
        _drawerSize = widget.size ??
            Size.fromHeight(
              _size.height * widget.percent / 100,
            );
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
    if (_axis == Axis.horizontal) {
      _gestures[HorizontalDragGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
        () => HorizontalDragGestureRecognizer(),
        (HorizontalDragGestureRecognizer instance) {
          instance.onUpdate =
              (DragUpdateDetails details) => _onDragUpdate(details);
          instance.onEnd = (DragEndDetails details) => _onDragEnd(details);
        },
      );
    } else {
      _gestures[VerticalDragGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
        () => VerticalDragGestureRecognizer(),
        (VerticalDragGestureRecognizer instance) {
          instance.onUpdate =
              (DragUpdateDetails details) => _onDragUpdate(details);
          instance.onEnd = (DragEndDetails details) => _onDragEnd(details);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      key: _gestureDetectorKey,
      gestures: _gestures,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            key: _backgroundGestureDetectorKey,
            child: Container(
              color: _colorTween.evaluate(_slideAnimationController),
            ),
            onTap: () {
              close();
            },
          ),
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

  void _onDragEnd(DragEndDetails details) {
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

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
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

import 'dart:math';

import 'package:flutter/cupertino.dart';
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

  Future<T> push<T>(
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
}

class BaseDrawerState extends State<BaseDrawer> with TickerProviderStateMixin {
  AnimationController _fadeAimationController;
  AnimationController _slideAimationController;
  Color _backgroundColor = Colors.transparent;

  Widget _child;
  Size _size;
  Size _drawerSize;
  Alignment _alignment;
  Axis _axis;
  double _tweenBegin;
  double _tweenEnd;

  double _offset = 0.0;
  final double _hideDrawerOffsetPercent = .5;
  double _hideDrawerOffset;

  double _flingVelocitySize;

  final GlobalKey _gestureDetectorKey = GlobalKey();
  final GlobalKey _backgroundGestureDetectorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _fadeAimationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    CurvedAnimation(
      parent: _fadeAimationController,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
    );
    _fadeAimationController.addListener(() {
      setState(() {
        _backgroundColor = _lerpFadeTween(_fadeAimationController.value);
      });
    });
    _fadeAimationController.forward();

    _slideAimationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    CurvedAnimation(
      parent: _slideAimationController,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
    );
    switch (widget.axisDirection) {
      case AxisDirection.left:
        _axis = Axis.horizontal;
        _tweenBegin = 1.0;
        _tweenEnd = 0.0;
        break;
      case AxisDirection.right:
        _axis = Axis.horizontal;
        _tweenBegin = -1.0;
        _tweenEnd = 0.0;
        break;
      case AxisDirection.up:
        _axis = Axis.vertical;
        _tweenBegin = 1.0;
        _tweenEnd = 0.0;
        break;
      case AxisDirection.down:
        _axis = Axis.vertical;
        _tweenBegin = -1.0;
        _tweenEnd = 0.0;
        break;
    }
    _slideAimationController.addListener(() {
      setState(() {
        _offset = _lerpSilderTween(_slideAimationController.value);
      });
    });
    _slideAimationController.forward();
  }

  void _buildInit() {
    if (_drawerSize == null) {
      _size ??= MediaQuery.of(context).size;
      final Widget blankWidget = GestureDetector(
        child: Container(
          color: Colors.transparent,
        ),
        onTap: () {
          _fadeAimationController.reverse();
          _slideAimationController.reverse();
          Navigator.of(context).pop();
        },
      );
      _child = widget.child;
      switch (widget.axisDirection) {
        case AxisDirection.left:
          _drawerSize = widget.size ??
              Size.fromWidth(
                _size.width * widget.percent / 100,
              );
          _alignment = Alignment.topRight;
          _hideDrawerOffset = _drawerSize.width * _hideDrawerOffsetPercent;
          _flingVelocitySize = _drawerSize.width;
          _child = Row(
            children: <Widget>[
              Expanded(
                child: blankWidget,
              ),
              SizedBox(
                width: _drawerSize.width,
                height: _drawerSize.height,
                child: _child,
              ),
            ],
          );
          break;
        case AxisDirection.right:
          _drawerSize = widget.size ??
              Size.fromWidth(
                _size.width * widget.percent / 100,
              );
          _alignment = Alignment.topLeft;
          _hideDrawerOffset = _drawerSize.width * _hideDrawerOffsetPercent;
          _flingVelocitySize = _drawerSize.width;
          _child = Row(
            children: <Widget>[
              SizedBox(
                width: _drawerSize.width,
                height: _drawerSize.height,
                child: _child,
              ),
              Expanded(
                child: blankWidget,
              ),
            ],
          );
          break;
        case AxisDirection.up:
          _drawerSize = widget.size ??
              Size.fromHeight(
                _size.height * widget.percent / 100,
              );
          _alignment = Alignment.bottomLeft;
          _hideDrawerOffset = _drawerSize.height * _hideDrawerOffsetPercent;
          _flingVelocitySize = _drawerSize.height;
          _child = Column(
            children: <Widget>[
              Expanded(
                child: blankWidget,
              ),
              SizedBox(
                width: _drawerSize.width,
                height: _drawerSize.height,
                child: _child,
              ),
            ],
          );
          break;
        case AxisDirection.down:
          _drawerSize = widget.size ??
              Size.fromHeight(
                _size.height * widget.percent / 100,
              );
          _alignment = Alignment.topLeft;
          _hideDrawerOffset = _drawerSize.height * _hideDrawerOffsetPercent;
          _flingVelocitySize = _drawerSize.height;
          _child = Column(
            children: <Widget>[
              SizedBox(
                width: _drawerSize.width,
                height: _drawerSize.height,
                child: _child,
              ),
              Expanded(
                child: blankWidget,
              ),
            ],
          );
          break;
      }
      if (_axis == Axis.horizontal) {
        _child = GestureDetector(
          key: _gestureDetectorKey,
          child: Container(
            alignment: _alignment,
            child: _child,
          ),
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            _onDragUpdate(details);
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            _onDragEnd(details);
          },
        );
      } else {
        _child = GestureDetector(
          key: _gestureDetectorKey,
          child: Container(
            alignment: _alignment,
            child: _child,
          ),
          onVerticalDragUpdate: (DragUpdateDetails details) {
            _onDragUpdate(details);
          },
          onVerticalDragEnd: (DragEndDetails details) {
            _onDragEnd(details);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _buildInit();
    return Stack(
      children: <Widget>[
        GestureDetector(
          key: _backgroundGestureDetectorKey,
          child: Container(
            color: _backgroundColor,
          ),
          onTap: () {
            hideDrawer();
          },
        ),
        Transform.translate(
          offset: _axis == Axis.horizontal
              ? Offset(_offset, 0.0)
              : Offset(0.0, _offset),
          child: _child,
        ),
      ],
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    double offset;
    switch (widget.axisDirection) {
      case AxisDirection.left:
        offset = max(0.0, _offset + details.delta.dx);
        break;
      case AxisDirection.right:
        offset = min(0.0, _offset + details.delta.dx);
        break;
      case AxisDirection.up:
        offset = max(0.0, _offset + details.delta.dy);
        break;
      case AxisDirection.down:
        offset = min(0.0, _offset + details.delta.dy);
        break;
    }
    final double opacity = (calculateRatio() * widget.backgroundColor.opacity)
        .clamp(0.0, widget.backgroundColor.opacity);
    setState(() {
      _offset = offset;
      _backgroundColor = _backgroundColor.withOpacity(opacity);
    });
  }

  double calculateRatio() {
    double _size = 0.0;
    if (_axis == Axis.horizontal) {
      _size = _drawerSize.width;
    } else {
      _size = _drawerSize.height;
    }
    return (_size - _offset.abs()) / _size;
  }

  void _onDragEnd(DragEndDetails details) {
    final double _primaryVelocity =
        details.primaryVelocity / _flingVelocitySize;
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
        showDrawer();
      } else {
        hideDrawer();
      }
    } else if (_offset.abs() > _hideDrawerOffset) {
      hideDrawer();
    } else {
      showDrawer();
    }
  }

  double _lerpSilderTween(double value) {
    value = _tweenBegin + (_tweenEnd - _tweenBegin) * value;
    if (_axis == Axis.horizontal) {
      value = value * _size.width;
    } else {
      value = value * _size.height;
    }
    return value;
  }

  double _lerpOffset() {
    double offset = _offset;
    if (_axis == Axis.horizontal) {
      offset = offset / _size.width;
    } else {
      offset = offset / _size.height;
    }
    return (offset - _tweenBegin) / (_tweenEnd - _tweenBegin);
  }

  Color _lerpFadeTween(double value) {
    return widget.backgroundColor
        .withOpacity(0.0 + (widget.backgroundColor.opacity - 0.0) * value);
  }

  double _lerpFade() {
    return (_backgroundColor.opacity - 0.0) /
        (widget.backgroundColor.opacity - 0.0);
  }

  void hideDrawer() {
    _fadeAimationController.reverse(
      from: _lerpFade(),
    );
    _slideAimationController.reverse(
      from: _lerpOffset(),
    );
    Navigator.of(context).pop();
  }

  void showDrawer() {
    _fadeAimationController.forward(
      from: _lerpFade(),
    );
    _slideAimationController.forward(from: _lerpOffset());
  }

  @override
  void dispose() {
    _fadeAimationController.dispose();
    _slideAimationController.dispose();
    super.dispose();
  }
}

Future<T> pushBaseDrawer<T>(
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

bool popBaseDrawer<T>(
  BuildContext context,
) {
  return Navigator.of(context).pop<T>();
}

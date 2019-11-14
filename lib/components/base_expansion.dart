import 'package:flutter/material.dart';

const Duration _expansionTransitionDuration = Duration(milliseconds: 300);

class BaseExpansion extends StatefulWidget {
  const BaseExpansion({
    Key key,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    this.width,
    this.height,
    this.duration = _expansionTransitionDuration,
    @required this.child,
    this.barrierDismissible = true,
    this.curve = Curves.bounceInOut,
  }) : super(key: key);

  const BaseExpansion.fromHeight({
    Key key,
    this.left = 0.0,
    this.top = 0.0,
    this.height,
    this.duration = _expansionTransitionDuration,
    @required this.child,
    this.barrierDismissible = true,
    this.curve = Curves.bounceInOut,
  })  : width = null,
        right = null,
        bottom = null,
        super(key: key);

  final double left;
  final double top;
  final double right;
  final double bottom;
  final double width;
  final double height;
  final Duration duration;
  final Widget child;
  final bool barrierDismissible;
  final Curve curve;

  @override
  State<StatefulWidget> createState() => BaseExpansionState();

  Future<void> open(
    BuildContext context,
    BaseExpansion baseExpansion, {
    Duration duration = const Duration(milliseconds: 0),
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        transitionDuration: duration,
        barrierDismissible: true,
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return baseExpansion;
        },
      ),
    );
  }
}

class BaseExpansionState extends State<BaseExpansion> {
  double _height;
  double _width;

  @override
  void initState() {
    super.initState();
    _height = 0.0;
    _width = widget.width;
    Future<void>.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _height = widget.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _width ??= MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          child: Container(
            color: Colors.transparent,
          ),
          onTap: () {
            if (widget.barrierDismissible) {
              close();
            }
          },
        ),
        Positioned(
          left: widget.left,
          top: widget.top,
          child: AnimatedContainer(
            duration: widget.duration,
            curve: widget.curve,
            child: widget.child,
            height: _height,
            width: _width,
          ),
        ),
      ],
    );
  }
  
  Future<void> close() {
    setState(() {
      _height = 0.0;
    });
    return Future<void>.delayed(widget.duration, () {
      Navigator.of(context).pop();
    });
  }
}

Future<void> openBaseExpansion(
  BuildContext context,
  BaseExpansion baseExpansion,
) {
  return Navigator.of(context).push(
    PageRouteBuilder<void>(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 0),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return baseExpansion;
      },
    ),
  );
}

void closeBaseExpansion(GlobalKey<BaseExpansionState> key) {
  key?.currentState?.close();
}

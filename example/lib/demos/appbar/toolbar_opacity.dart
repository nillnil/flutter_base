import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 状态栏leading，title，trailing透明度变化
/// 复杂的还是建议使用SliverAppBar实现
class ToolbarOpacity extends StatefulWidget {
  const ToolbarOpacity({
    Key? key,
  }) : super(key: key);
  @override
  _ToolbarOpacityState createState() => _ToolbarOpacityState();
}

class _ToolbarOpacityState extends State<ToolbarOpacity>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  // 不设置为1.0是因为当设置成1.0之后，body的内容就不会沉淀在appBar下方，导致ScrollController的offset重新计算
  final double _maxOpacity = .99;
  ScrollController? _scrollController;
  final double hieght = 400;
  Color _barBackgroundColor = Colors.transparent;
  double _height = 1000;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final double offset = _scrollController!.offset / 100;
        if (offset > 1.0 && offset < 3.0) {
          // 防止快速滑动之后_opacity没有设置为1
          setState(() {
            _opacity = _maxOpacity;
          });
        } else if (offset < 1.0) {
          setState(() {
            _opacity = offset;
          });
        }
      });
    Future<void>.delayed(const Duration(microseconds: 0), () {
      _barBackgroundColor = CupertinoTheme.of(context).barBackgroundColor;
      _height = MediaQuery.of(context).size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: const Text('toolbarOpacity'),
        backgroundColor: _barBackgroundColor.withOpacity(_opacity),
        backdropFilter: false,
        border: null,
        toolbarOpacity: _opacity,
        elevation: 0.0,
        trailing: Text(_opacity.toStringAsPrecision(1)),
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: BaseScrollBar(
        padding: EdgeInsets.zero,
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          controller: _scrollController,
          children: <Widget>[
            Container(
              height: _height,
              alignment: Alignment.center,
              child: const Text('向下滑动↓'),
            ),
            Container(
              height: _height / 4,
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.only(bottom: 10.0),
              alignment: Alignment.center,
              child: const Text('到底了', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }
}

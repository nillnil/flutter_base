

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 状态栏leading，title，trailing透明度变化
/// 复杂的还是建议使用SliverAppBar实现
class BottomOpacity extends StatefulWidget {

  @override
  _BottomOpacityState createState() => _BottomOpacityState();

}

class _BottomOpacityState extends State<BottomOpacity> with SingleTickerProviderStateMixin {

  double _opacity = 0.0;
  // 不设置为1.0是因为当设置成1.0之后，body的内容就不会沉淀在appBar下方，导致ScrollController的offset重新计算
  double _maxOpacity = .99;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        double offset = _scrollController.offset / 100;
        if (offset > 1.0 && offset < 3.0) {
          // 防止快速滑动之后_opacity没有设置为1
          setState(() {
            _opacity = _maxOpacity;
          });
        } else if (offset < 1.0){
          setState(() {
            _opacity = offset;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: Text('Bottom Opacity'),
        backgroundColor: Colors.white.withOpacity(_opacity),
        backdropFilter: false,
        border: null,
        toolbarOpacity: _opacity,
        elevation: 0.0,
        trailing: Text('${_opacity.toStringAsPrecision(1)}'),
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        controller: _scrollController,
        children: <Widget>[
          Container(
            color: Colors.indigo,
            height: 800,
          ),
          Container(
            color: Colors.limeAccent,
            height: 800,
          ),
          Container(
            color: Colors.purpleAccent,
            height: 1800,
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 10.0),
            alignment: Alignment.center,
            child: Text('到底了', style: TextStyle(color: Colors.grey)),
          ),
        ],
      )
    );
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}
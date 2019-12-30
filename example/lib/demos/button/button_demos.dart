import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'button_demo.dart';
import 'icon_button_demo.dart';

class ButtonDemos extends StatefulWidget {
  @override
  _ButtonDemosState createState() => _ButtonDemosState();
}

class _ButtonDemosState extends State<ButtonDemos>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        bottom: TabBar(
          controller: tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Button',
            ),
            Tab(
              text: 'IconButton',
            ),
          ],
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 1.0,
              color: const BaseColor.highContrast(
                color: Colors.white,
                darkColor: Colors.white,
              ).build(context),
            ),
            insets: const EdgeInsets.symmetric(horizontal: 50.0),
          ),
        ),
        trailing: Container(
          width: 40,
        ),
        transitionBetweenRoutes: false,
        material: <String, dynamic>{
          'trailing': Container(
            width: 44,
          ),
        },
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          ButtonDemo(),
          IconButtonDemo(),
        ],
      ),
    );
  }
}

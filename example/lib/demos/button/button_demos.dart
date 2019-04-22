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
            )
          ],
          indicatorColor: Colors.white,
        ),
        trailing: Container(
          width: 40,
        ),
        transitionBetweenRoutes: false,
        material: <String, Object>{
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

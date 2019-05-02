import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'scaffold_demo.dart';
import 'tab_scaffold_demo.dart';

/// Scaffold Demos
class ScaffoldDemos extends StatefulWidget {
  @override
  _ScaffoldDemosState createState() => _ScaffoldDemosState();
}

class _ScaffoldDemosState extends State<ScaffoldDemos> with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        bottom: TabBar(
          controller: tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Scaffold',
            ),
            Tab(
              text: 'Tab Scaffold',
            )
          ],
          indicatorColor: Colors.white,
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
          ScaffoldDemo(),
          TabScaffoldDemo(),
        ],
      )
    );
  }

}
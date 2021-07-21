import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'scaffold_demo.dart';
import 'tab_scaffold_demo.dart';

/// Scaffold Demos
class ScaffoldDemos extends StatefulWidget {
  const ScaffoldDemos({
    Key? key,
  }) : super(key: key);
  @override
  _ScaffoldDemosState createState() => _ScaffoldDemosState();
}

class _ScaffoldDemosState extends State<ScaffoldDemos> with SingleTickerProviderStateMixin {
  TabController? tabController;

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
        baseParam: BaseParam(
          material: <String, dynamic>{
            'trailing': Container(
              width: 44,
            ),
          },
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const <Widget>[
          ScaffoldDemo(),
          TabScaffoldDemo(),
        ],
      ),
    );
  }
}

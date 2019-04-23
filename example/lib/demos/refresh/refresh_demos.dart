import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'indicator_demo.dart';
import 'refresh_demo.dart';

class RefreshDemos extends StatefulWidget {
  @override
  _RefreshDemosState createState() => _RefreshDemosState();
}

class _RefreshDemosState extends State<RefreshDemos>
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
              text: 'indicator',
            ),
            Tab(
              text: 'refresh',
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
          IndicatorDemo(),
          RefreshDemo(),
        ],
      ),
    );
  }
}

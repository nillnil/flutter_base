import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'indicator_demo.dart';
import 'refresh_demo.dart';

class RefreshDemos extends StatefulWidget {
  const RefreshDemos({
    Key? key,
  }) : super(key: key);
  @override
  _RefreshDemosState createState() => _RefreshDemosState();
}

class _RefreshDemosState extends State<RefreshDemos> with SingleTickerProviderStateMixin {
  TabController? tabController;

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
          IndicatorDemo(),
          RefreshDemo(),
        ],
      ),
    );
  }
}

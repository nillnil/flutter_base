
import 'package:base/navbar/base_navbar.dart';
import 'package:base/page/base_page.dart';
import 'package:flutter/widgets.dart';

class RouteDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      navBar: BaseNavBar(
        title: Text('Route')
      ),
      body: Center(
        child: Text('Route'),
      ),
    );
  }

}
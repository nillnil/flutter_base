
import 'package:base/navbar/base_navbar.dart';
import 'package:base/page/base_page.dart';
import 'package:flutter/cupertino.dart';

class PageDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      navBar: BaseNavBar(
        title: Text('Page')
      ),
      body: Center(
        child: Text('Page'),
      ),
    );
  }

}
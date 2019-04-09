
import 'package:base/navbar/base_navbar.dart';
import 'package:base/page/base_page.dart';
import 'package:flutter/widgets.dart';

class ButtonDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      navBar: BaseNavBar(
        title: Text('Button')
      ),
      body: Center(
        child: Text('Button'),
      ),
    );
  }

}
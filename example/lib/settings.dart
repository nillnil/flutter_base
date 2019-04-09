

import 'package:base/navbar/base_navbar.dart';
import 'package:base/page/base_page.dart';
import 'package:flutter/widgets.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: BaseNavBar(
        title: Text('Settings')
      ),
      body: Container(
        
      ),
    );
  }
  
}
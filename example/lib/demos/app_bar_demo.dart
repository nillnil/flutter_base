
import 'package:base/navbar/base_navbar.dart';
import 'package:base/page/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      navBar: BaseNavBar(
        title: Text('AppBar')
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Cupertino使用CupertinoNavigationBar\nMaterial使用AppBar.'),
            );
          }
          return Container();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        }, 
        itemCount: 10,
      )
    );
  }

}
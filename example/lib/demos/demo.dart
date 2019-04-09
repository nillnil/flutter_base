
import 'package:base/icon/base_icon.dart';
import 'package:base/route/base_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo extends StatelessWidget {

  final Text title;
  final BaseIcon icon;
  final Widget page;

  const Demo({
    Key key, 
    this.title, 
    this.icon,
    this.page
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            icon,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
            ),
            title
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      onTap: () {
        BaseRoute(page).push(context);
      },
    );
  }

}

import 'package:base/icon/base_icon.dart';
import 'package:base/route/base_route.dart';
import 'package:base/section/base_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoTile extends StatelessWidget {

  final Widget title;
  final GestureTapCallback onTop;
  final Widget page;

  const DemoTile({
    Key key, 
    this.title, 
    this.onTop,
    this.page
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      title: title,
      trailing: BaseIcon(
        icon: CupertinoIcons.right_chevron,
        color: Colors.grey,
      ),
      onTap: () {
        if (onTop != null) {
          onTop();
        } else if (page != null){
          BaseRoute(page).push(context);
        } else {
          return null;
        }
      },
    );
  }

}
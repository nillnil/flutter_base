import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoTile extends StatelessWidget {
  const DemoTile({
    Key? key,
    this.title,
    this.onTop,
    this.page,
    this.fullscreenGackGesture = true,
  }) : super(key: key);

  final Widget? title;
  final Function(BuildContext context)? onTop;
  final Widget? page;
  final bool fullscreenGackGesture;

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return BaseTile(
        title: title,
        trailing: const BaseIcon(
          icon: CupertinoIcons.right_chevron,
          color: Colors.grey,
        ),
        onTap: () {
          if (onTop != null) {
            onTop!(context);
          } else if (page != null) {
            BaseRoute<dynamic>(
              builder: (_) => page!,
              fullscreenGackGesture: fullscreenGackGesture,
            ).push(context);
          }
        },
      );
    } else {
      return page != null ? page! : Container();
    }
  }
}

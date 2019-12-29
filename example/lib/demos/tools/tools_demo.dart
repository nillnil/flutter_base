import 'package:base/appbar/base_app_bar.dart';
import 'package:base/base.dart';
import 'package:base/section/base_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'color_tools_demo.dart';

/// Tools 说明
class ToolsDemo extends StatelessWidget {
  const ToolsDemo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: Text('Tools'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            BaseTile(
              titleText: 'color tools',
              trailing: const BaseIcon(
                icon: CupertinoIcons.right_chevron,
                color: Colors.grey,
              ),
              onTap: () {
                BaseRoute<void>(
                  builder: (_) => ColorToolsDemo(),
                ).push(context);
              },
            ),
          ],
        ),
      ),
      cupertino: const <String, dynamic>{
        'backgroundColor': CupertinoColors.systemGroupedBackground,
      },
    );
  }
}

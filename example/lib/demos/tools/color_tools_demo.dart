import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_string_convert_demo.dart';
import 'random_color_demo.dart';

class ColorToolsDemo extends StatelessWidget {
  const ColorToolsDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: Text('Color Tools'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            BaseTile(
              titleText: 'random color',
              trailing: const BaseIcon(
                icon: CupertinoIcons.right_chevron,
                color: Colors.grey,
              ),
              onTap: () {
                BaseRoute<void>(
                  builder: (_) => const RandomColorDemo(),
                ).push(context);
              },
            ),
            BaseTile(
              titleText: 'color string convert',
              trailing: const BaseIcon(
                icon: CupertinoIcons.right_chevron,
                color: Colors.grey,
              ),
              onTap: () {
                BaseRoute<void>(
                  builder: (_) => const ColorStringConvertDemo(),
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

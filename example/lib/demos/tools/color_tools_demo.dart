import 'package:base/base.dart';
import 'package:example/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<AppProvider>(
        builder: (_, AppProvider appProvider, __) {
          return BaseScrollBar(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20.0),
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
          );
        },
      ),
      baseParam: BaseParam(
        cupertino: const <String, dynamic>{
          'backgroundColor': CupertinoColors.systemGroupedBackground,
        },
      ),
    );
  }
}

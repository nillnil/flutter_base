import 'package:base/base.dart';
import 'package:example/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'color_tools_demo.dart';

/// Tools 说明
class ToolsDemo extends StatelessWidget {
  const ToolsDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: Text('Tools'),
      ),
      body: Consumer<AppProvider>(
        builder: (_, AppProvider appProvider, __) {
          return BaseScrollBar(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20.0),
                BaseTile(
                  titleText: 'color tools',
                  trailing: const BaseIcon(
                    icon: CupertinoIcons.right_chevron,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    BaseRoute<void>(
                      builder: (_) => const ColorToolsDemo(),
                    ).push(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
      cupertino: const <String, dynamic>{
        'backgroundColor': CupertinoColors.systemGroupedBackground,
      },
    );
  }
}

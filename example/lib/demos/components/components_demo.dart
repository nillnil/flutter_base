import 'package:base/appbar/base_app_bar.dart';
import 'package:base/base.dart';
import 'package:base/section/base_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'drawer_demo.dart';
// import 'expansion_demo.dart';

/// Componentes 说明
class ComponentesDemo extends StatelessWidget {
  const ComponentesDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: Text('Components'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            BaseTile(
              titleText: 'drawer',
              trailing: const BaseIcon(
                icon: CupertinoIcons.right_chevron,
                color: Colors.grey,
              ),
              onTap: () {
                BaseRoute<void>(
                  builder: (_) => const DrawerDemo(),
                ).push(context);
              },
            ),
            // BaseTile(
            //   titleText: 'expansion',
            //   trailing: const BaseIcon(
            //     icon: CupertinoIcons.right_chevron,
            //     color: Colors.grey,
            //   ),
            //   onTap: () {
            //     BaseRoute<void>(
            //       builder: (_) => ExpansionDemo(),
            //     ).push(context);
            //   },
            // ),
          ],
        ),
      ),
      cupertino: const <String, dynamic>{
        'backgroundColor': CupertinoColors.systemGroupedBackground,
      },
    );
  }
}

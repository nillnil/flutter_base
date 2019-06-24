import 'package:base/base.dart';
import 'package:flutter/material.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

/// ActionSheet Demo
class ActionSheetDemo extends StatelessWidget {
  const ActionSheetDemo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[
      DemoTile(
        page: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BaseButton(
                  child: const Text(
                    'ActionSheet',
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    BaseActionSheet(
                      title: const Text('标题'),
                      message: const Text('内容'),
                      actions: <Widget>[
                        BaseActionSheetAction(
                          child: const Text('选项1'),
                          onPressed: () {},
                        ),
                        BaseActionSheetAction(
                          child: const Text('选项2'),
                          onPressed: () {},
                          isDefaultAction: true,
                        ),
                        BaseActionSheetAction(
                          child: const Text('选项3'),
                          onPressed: () {},
                          isDestructiveAction: true,
                        ),
                      ],
                      cancelButton: BaseActionSheetAction(
                        child: const Text('取消'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ).show<void>(context);
                  },
                ),
              ),
            ],
          ),
        ),
      )
    ];
    return DemoPage(
      title: 'ActionSheet',
      widgetName: 'BaseActionSheet',
      materialDesc: 'use custom BottomSheet',
      cupertinoDesc: 'use CupertinoActionSheet',
      tips: 'Use like: \nBaseActionSheet('
          '\n\t\t\ttitle: ...\n\t\t\t'
          'actions: ...\n'
          ').show<void>(context);',
      demos: _demos,
    );
  }
}

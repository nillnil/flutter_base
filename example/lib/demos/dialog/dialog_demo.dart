import 'package:base/dialog/base_alert_dialog.dart';
import 'package:base/dialog/base_dialog_action.dart';
import 'package:flutter/material.dart';

import '../demo_page.dart';
import '../demo_tile.dart';
import 'alert_dialog_demo.dart';

/// Dialo Demo
class DialogDemo extends StatelessWidget {
  DialogDemo({
    Key? key,
  }) : super(key: key);
  final List<DemoTile> _demos = <DemoTile>[
    DemoTile(
      title: const Text('normal'),
      page: const AlertDialogDemo(),
      onTop: (BuildContext context) {
        const BaseAlertDialog(
          content: Text(
            'qwertyuioplkjhgfdsazxcvbnm',
            style: TextStyle(fontSize: 16.0),
          ),
        ).show<void>(context);
      },
    ),
    DemoTile(
      title: const Text('action'),
      page: const AlertDialogDemo(),
      onTop: (BuildContext context) {
        BaseAlertDialog(
          content: const Text('qwertyuioplkjhgfdsazxcvbnm'),
          actions: <Widget>[
            BaseDialogAction(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ).show<void>(
          context,
          barrierDismissible: false,
        );
      },
    ),
    DemoTile(
      title: const Text('actions'),
      page: const AlertDialogDemo(),
      onTop: (BuildContext context) {
        BaseAlertDialog(
          content: const Text('qwertyuioplkjhgfdsazxcvbnm'),
          actions: <Widget>[
            BaseDialogAction(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            BaseDialogAction(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ).show<void>(
          context,
          barrierDismissible: false,
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'Alert Dialog',
      widgetName: 'BaseAlertDialog',
      materialDesc: 'use AlertDialog',
      cupertinoDesc: 'use CupertinoAlertDialog',
      tips: 'Use like: \nBaseAlertDialog(\n\t\t\t'
          'content: ...\n\t\t\t'
          'actions: ...\n'
          ').show<void>(context);'
          '\nor\n'
          'showBaseAlertDialog<void>(\n\t\t\t'
          'BaseAlertDialog(...),\n\t\t\t'
          'context,\n\t\t\t'
          '...\n'
          ');',
      demos: _demos,
    );
  }
}

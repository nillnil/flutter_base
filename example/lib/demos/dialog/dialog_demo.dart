import 'package:base/dialog/base_alert_dialog.dart';
import 'package:base/dialog/base_dialog_action.dart';
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'alert_dialog_demo.dart';

/// Dialo Demo
class DialogDemo extends StatelessWidget {
  final List<DemoTile> _demos = <DemoTile>[
    DemoTile(
      title: const Text('normal'),
      page: AlertDialogDemo(),
      onTop: (BuildContext context) {
        BaseAlertDialog(
          content: Container(
            child: const Text(
              'qwertyuioplkjhgfdsazxcvbnm',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ).show<void>(context);
      },
    ),
    DemoTile(
      title: const Text('action'),
      page: AlertDialogDemo(),
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
      page: AlertDialogDemo(),
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
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'BaseAlertDialog',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  right: 10.0,
                  top: 3.0,
                  bottom: 3.0,
                ),
                color: Colors.pinkAccent,
                width: 10.0,
                height: 16.0,
              ),
              const Expanded(
                child: Text('Material：use AlertDialog'),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  right: 10.0,
                  top: 3.0,
                  bottom: 3.0,
                ),
                color: Colors.lightBlueAccent,
                width: 10.0,
                height: 16.0,
              ),
              const Expanded(
                child: Text('Cupertino：use CupertinoAlertDialog'),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: Text(
                  'Use like: \nBaseAlertDialog(\n\t\t\tcontent: ...\n\t\t\tactions: ...\n).show<void>(context);',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      demos: _demos,
    );
  }
}

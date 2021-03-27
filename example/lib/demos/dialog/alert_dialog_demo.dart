import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlertDialogDemo extends StatelessWidget {
  const AlertDialogDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: Text('Alert Dialog'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: BaseButton(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: const Text(
                  'normal',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  const BaseAlertDialog(
                    content: Text(
                      'qwertyuioplkjhgfdsazxcvbnm',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ).show<void>(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: BaseButton(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: const Text(
                  'action',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
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
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: BaseButton(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: const Text(
                  'actions',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  showBaseAlertDialog<void>(
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
                    ),
                    context,
                    barrierDismissible: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

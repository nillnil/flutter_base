import 'package:base/base.dart';
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:example/demos/utils/color_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';

/// ActionSheet Demo
class ActionSheetDemo extends StatelessWidget {
  ActionSheetDemo({
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
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'BaseActionSheet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: <Widget>[
              ColorBlock.material(),
              const Expanded(
                child: Text('Material：use custom BottomSheet'),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.cupertino(),
              const Expanded(
                child: Text('Cupertino：use CupertinoActionSheet'),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: Text(
                  'Use like: \nBaseActionSheet(\n\t\t\ttitle: ...\n\t\t\tactions: ...\n).show<void>(context);',
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

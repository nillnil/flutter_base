import 'package:base/base.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:example/demos/utils/color_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';

class IconButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    children.add(
      Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: BaseIconButton(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          icon: const Icon(
            Icons.add_circle,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    );
    children.add(
      Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: BaseIconButton(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          icon: const Icon(
            Icons.info,
          ),
          onPressed: () {},
        ),
      ),
    );
    children.add(
      Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: BaseIconButton(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          icon: const Icon(
            Icons.image,
            size: 40,
          ),
          minSize: 40,
          iconSize: 40,
          disabledColor: Colors.grey,
        ),
      ),
    );
    return DemoPage(
      // title: 'Button',
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'BaseIconButton',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.material(),
              const Expanded(
                child: Text(
                  'Material：use IconButton',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.cupertino(),
              const Expanded(
                child: Text(
                  'Cupertino：use CupertinoButton',
                ),
              ),
            ],
          ),
          const Text(
            '\nIf you want to have a label with the icon, suggest use the BaseButton.',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      demos: <DemoTile>[
        DemoTile(
          page: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

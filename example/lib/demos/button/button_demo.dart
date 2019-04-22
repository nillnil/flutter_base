import 'package:base/button/base_button.dart';
import 'package:base/platform/platform.dart';
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:example/demos/utils/color_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Button 示例
class ButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    children.add(
      Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: BaseButton(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          color: Colors.white,
          child: const Text(
            'normal',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {},
        ),
      ),
    );
    children.add(
      Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: BaseButton(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          color: Colors.white,
          child: const Text(
            'disabled',
            style: TextStyle(color: Colors.black),
          ),
          disabledColor: Colors.grey,
          disabledTextColor: Colors.white,
        ),
      ),
    );
    if (useCupertino) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: BaseButton(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            child: const Text(
              'filled',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {},
            filled: true,
          ),
        ),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: BaseButton.icon(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            icon: const Icon(
              CupertinoIcons.bell_solid,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: BaseButton.icon(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            icon: const Icon(
              CupertinoIcons.bell_solid,
            ),
            label: const Text(
              'filled icon',
              style: TextStyle(),
            ),
            onPressed: () {},
            filled: true,
          ),
        ),
      );
    }
    if (useMaterial) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: BaseButton.icon(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            icon: const Icon(Icons.account_balance),
            label: const Text(
              'normal icon',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
          ),
        ),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: BaseButton(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            child: const Text(
              'flat',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            flat: true,
          ),
        ),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: BaseButton.icon(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            icon: const Icon(
              Icons.access_time,
            ),
            label: const Text(
              'flat icon',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            flat: true,
          ),
        ),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: BaseButton(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            child: const Text(
              'outline',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            outline: true,
          ),
        ),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: BaseButton.icon(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            icon: const Icon(
              Icons.add_location,
            ),
            label: const Text(
              'outline icon',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            outline: true,
          ),
        ),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: BaseButton(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            child: const Text(
              'raised',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            raised: true,
          ),
        ),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: BaseButton.icon(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            color: Colors.white,
            icon: const Icon(
              Icons.assignment_ind,
            ),
            label: const Text(
              'raised icon',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            raised: true,
          ),
        ),
      );
    }
    return DemoPage(
      // title: 'Button',
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'BaseButton',
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
                  'Material：use MaterialButton or FlatButton or OutlineButton or RaisedButton',
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
                  'Cupertino：use CupertinoButton or CupertinoButton.filled',
                ),
              ),
            ],
          ),
          const Text('\nSpecific parameter'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text(
                  'filled：effective on Cupertino, default is false. use CupertinoButton.filled',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text(
                  'flat：effective on Material, default is false. use FlatButton',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text(
                  'outline：effective on Material, default is false. use OutlineButton',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text(
                  'BaseButton.icon：icon cna\'t be null, use MaterialButton or FlatButton.icon or OutlineButton.icon on Material.',
                ),
              ),
            ],
          ),
          const Text(
            '\nIf you don\'t want to have a label with the icon, suggest use the BaseIconButton.',
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

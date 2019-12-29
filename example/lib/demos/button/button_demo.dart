import 'package:base/base.dart';
import 'package:base/button/base_button.dart';
import 'package:base/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

/// Button 示例
class ButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _isLightness =
        (MediaQuery.of(context).platformBrightness ?? Brightness.light) ==
            Brightness.light;
    final List<Widget> children = <Widget>[];
    const EdgeInsets _padding = EdgeInsets.only(bottom: 10.0);
    const EdgeInsets _buttonPadding = EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 15.0,
    );
    children.add(
      Padding(
        padding: _padding,
        child: BaseButton(
          padding: _buttonPadding,
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
      const Padding(
        padding: _padding,
        child: BaseButton(
          padding: _buttonPadding,
          color: Colors.white,
          child: Text(
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
          padding: _padding,
          child: BaseButton(
            padding: _buttonPadding,
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
          padding: _padding,
          child: BaseButton.icon(
            padding: _buttonPadding,
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
          padding: _padding,
          child: BaseButton.icon(
            padding: _buttonPadding,
            color: Colors.white,
            icon: const Icon(
              CupertinoIcons.bell_solid,
              color: Colors.white,
            ),
            label: const Text(
              'filled icon',
              style: TextStyle(
                color: Colors.white,
              ),
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
          padding: _padding,
          child: BaseButton.icon(
            padding: _buttonPadding,
            color: Colors.white,
            icon: const Icon(Icons.account_balance, color: Colors.black),
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
          padding: _padding,
          child: BaseButton(
            padding: _buttonPadding,
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
          padding: _padding,
          child: BaseButton.icon(
            padding: _buttonPadding,
            color: Colors.white,
            icon: const Icon(
              Icons.access_time,
              color: Colors.black,
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
          padding: _padding,
          child: BaseButton(
            padding: _buttonPadding,
            color: Colors.white,
            child: Text(
              'outline',
              style: TextStyle(
                color: (useMaterial && !_isLightness)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onPressed: () {},
            outline: true,
          ),
        ),
      );
      children.add(
        Padding(
          padding: _padding,
          child: BaseButton.icon(
            padding: _buttonPadding,
            color: Colors.white,
            icon: const Icon(
              Icons.add_location,
            ),
            label: Text(
              'outline icon',
              style: TextStyle(
                color: (useMaterial && !_isLightness)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onPressed: () {},
            outline: true,
          ),
        ),
      );
      children.add(
        Padding(
          padding: _padding,
          child: BaseButton(
            padding: _buttonPadding,
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
          padding: _padding,
          child: BaseButton.icon(
            padding: _buttonPadding,
            color: Colors.white,
            icon: const Icon(
              Icons.assignment_ind,
              color: Colors.black,
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
      widgetName: 'BaseButton',
      materialDesc: 'use MaterialButton or FlatButton or '
          'OutlineButton or RaisedButton',
      cupertinoDesc: 'use CupertinoButton or CupertinoButton.filled',
      parameterDesc: const <String, String>{
        'filled': 'effective on Cupertino, default is false. '
            'use CupertinoButton.filled',
        'flat': 'effective on Material, default is false. use FlatButton',
        'outline': 'effective on Material, default is false. use OutlineButton',
        'raised': 'effective on Material, default is false. use RaisedButton',
        'BaseButton.icon': 'icon cna\'t be null, use MaterialButton or '
            'FlatButton.icon or OutlineButton.icon or RaisedButon.icon on Material.'
      },
      tips: 'If you don\'t want to have a label with the icon, '
          'suggest use the BaseIconButton.',
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

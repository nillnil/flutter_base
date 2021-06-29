import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

/// Button 示例
class ButtonDemo extends StatelessWidget {
  const ButtonDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool _isLightness = (MediaQuery.maybeOf(context)?.platformBrightness ?? Brightness.light) == Brightness.light;
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
    if (isCupertinoMode) {
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
            filledButton: true,
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
            filledButton: true,
          ),
        ),
      );
    }
    if (isMaterialMode) {
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
              'TextButton',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            textButton: true,
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
              'TextButton.icon',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            textButton: true,
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
              'OutlinedButton',
              style: TextStyle(
                color: (isMaterialMode && !_isLightness) ? Colors.white : Colors.black,
              ),
            ),
            onPressed: () {},
            outlinedButton: true,
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
              'OutlinedButton.icon',
              style: TextStyle(
                color: (isMaterialMode && !_isLightness) ? Colors.white : Colors.black,
              ),
            ),
            onPressed: () {},
            outlinedButton: true,
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
              'ElevatedButton',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            elevatedButton: true,
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
              'ElevatedButton.icon',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
            elevatedButton: true,
          ),
        ),
      );
    }
    return DemoPage(
      widgetName: 'BaseButton',
      materialDesc: 'use MaterialButton or TextButton or '
          'OutlinedButton or ElevatedButton',
      cupertinoDesc: 'use CupertinoButton or CupertinoButton.filled',
      parameterDesc: const <String, String>{
        'filled': 'effective on Cupertino, default is false. '
            'use CupertinoButton.filled',
        'textButton': 'effective on Material, default is false. use TextButton',
        'outlinedButton': 'effective on Material, default is false. use OutlinedButton',
        'elevatedButton': 'effective on Material, default is false. use ElevatedButton',
        'BaseButton.icon': 'icon cna\'t be null, use MaterialButton or '
            'TextButton.icon or OutlinedButton.icon or ElevatedButton.icon on Material.'
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

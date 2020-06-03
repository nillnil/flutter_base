import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, _) {
        final List<Widget> _themes = <Widget>[];
        for (Color color in Colors.primaries) {
          _themes.add(
            _ThemeItem(
              color: color,
              selected: appProvider.primaryColor == color,
            ),
          );
        }
        return BaseScaffold(
          appBar: const BaseAppBar(
            title: Text('主题'),
            transitionBetweenRoutes: false,
          ),
          body: Container(
            child: GridView.count(
              children: _themes,
              crossAxisCount: 6,
            ),
          ),
        );
      },
    );
  }
}

class _ThemeItem extends StatelessWidget {
  const _ThemeItem({Key key, this.color, this.selected = true})
      : super(key: key);

  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, AppProvider appProvider, __) {
        return GestureDetector(
          child: Container(
            alignment: Alignment.center,
            color: color,
            height: 50,
            width: 50,
            child: selected
                ? const BaseIcon(
                    icon: CupertinoIcons.check_mark,
                    size: 40,
                    color: Colors.white,
                  )
                : Container(),
          ),
          onTap: () {
            if (!selected) {
              appProvider.changeTheme(color);
            }
          },
        );
      },
    );
  }
}

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

class ExpansionDemo extends StatelessWidget {
  const ExpansionDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'Expansion',
      widgetName: 'BaseExpansion',
      materialDesc: '自定义Expansion',
      cupertinoDesc: '自定义Expansion',
      desc: '目前还相当不完善',
      tips: 'Use like: \nopenBaseExpansion<void>(\n\t\t\t'
          'context: ...\n\t\t\t'
          'expansion: BaseExpansion(...)\n'
          ');'
          '\nor\n'
          'BaseExpansion(\n\t\t\t'
          '...\n'
          ').open<void>(context);',
      demos: <DemoTile>[
        DemoTile(
          page: _Demo(),
        ),
      ],
    );
  }
}

class _Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: 80,
      alignment: Alignment.center,
      child: BaseButton(
        color: const BaseColor(
          color: Colors.white,
          darkColor: Colors.white,
          dynamicColor: null,
        ).build(context),
        child: Text(
          '打开Expansion',
          style: TextStyle(
            color: const BaseColor(
              color: Colors.black,
              darkColor: Colors.black,
              dynamicColor: null,
            ).build(context),
          ),
        ),
        onPressed: () {
          openBaseExpansion<void>(
            context,
            BaseExpansion(
              top: 88.0,
              height: 200,
              child: Container(
                color: const BaseColor(
                  dynamicColor: null,
                  color: Color(0xFFF9F9F9),
                  darkColor: Color(0xFF1D1D1D),
                ).build(context),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (_, int index) {
                    return BaseTile(
                      titleText: '${index + 1}',
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(
                    height: .2,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

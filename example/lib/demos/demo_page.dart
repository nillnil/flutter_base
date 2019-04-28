import 'package:base/base.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'utils/color_block.dart';

class DemoPage extends StatelessWidget {
  DemoPage({
    Key key,
    this.title,
    this.doc,
    this.docStr,
    this.widgetName,
    this.materialDesc,
    this.cupertinoDesc,
    this.parameterDesc,
    this.tips,
    this.demos = const <DemoTile>[],
  }) : super(key: key);

  final String title;
  final Widget doc;
  final String docStr;
  final String widgetName;
  final String materialDesc;
  final String cupertinoDesc;
  final Map<String, String> parameterDesc;
  final String tips;
  final List<DemoTile> demos;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      Text(
        widgetName ?? title ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ColorBlock.material(),
          Expanded(
            child: Text('Material：${materialDesc ?? ''}'),
          )
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ColorBlock.cupertino(),
          Expanded(
            child: Text('Cupertino: ${cupertinoDesc ?? ''}'),
          )
        ],
      ),
    ];
    if (parameterDesc != null) {
      children.add(
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('特殊参数说明'),
        ),
      );
      parameterDesc.forEach((String key, String value) {
        children.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              Expanded(
                child: Text('$key: $value'),
              ),
            ],
          ),
        );
      });
    }
    if (tips != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            tips ?? '',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      );
    }
    return BaseScaffold(
      safeAreaTop: true,
      navBar: title != null
          ? BaseAppBar(
              title: Text(title),
              transitionBetweenRoutes: false,
            )
          : null,
      body: BaseScrollBar(
        child: ListView.separated(
          separatorBuilder: (_, __) => const Divider(height: .5),
          itemCount: 2 + demos?.length,
          itemBuilder: (_, int index) {
            if (index == 0) {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              );
            } else if (index == 1) {
              return const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Text(
                  '示例',
                  style: TextStyle(fontSize: 14.0),
                ),
              );
            } else {
              return demos[index - 2];
            }
          },
        ),
      ),
    );
  }
}

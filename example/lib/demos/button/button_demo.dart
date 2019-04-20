
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Button 示例
class ButtonDemo extends StatelessWidget {

  final List<DemoTile> _demos = <DemoTile>[];

  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'Button',
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('', style: TextStyle(
            fontWeight: FontWeight.bold
          )),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
                color: Colors.pinkAccent,
                width: 10.0,
                height: 16.0,
              ),
              const Expanded(
                child: Text('Material：'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
                color: Colors.lightBlueAccent,
                width: 10.0,
                height: 16.0,
              ),
              const Expanded(
                child: Text('Cupertino：'),
              )
            ]
          )
        ]
      ),
      demos: _demos
    );
  }

}
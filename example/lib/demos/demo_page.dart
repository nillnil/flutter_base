
import 'package:base/base.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoPage extends StatelessWidget {

  final String title;
  final Widget doc;
  final String docStr;
  final List<DemoTile> demos;

  DemoPage({
    Key key, 
    @required this.title, 
    this.doc, 
    this.docStr,
    this.demos
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      autoAddTopPadding: true,
      navBar: BaseAppBar(
        title: Text(title),
        transitionBetweenRoutes: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: doc ?? Text(docStr ?? ''),
          ),
          Divider(
            height: 0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10.0),
            child: Text('示例', 
              style: TextStyle(
                fontSize: 14.0
              )
            )
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return demos[index];
              }, 
              itemCount: demos.length, 
              separatorBuilder: (_, __) => Divider(
                height: 0.0,
              )
            )
          )
        ],
      )
    );
  }

}
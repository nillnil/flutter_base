
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
    this.demos = const []
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      safeAreaTop: true,
      navBar: BaseAppBar(
        title: Text(title),
        transitionBetweenRoutes: false,
      ),
      body: BaseScrollBar(
        child: ListView.separated(
          separatorBuilder: (_, __) => Divider(height: .5,),
          itemCount: 2 + demos?.length,
          itemBuilder: (_, index) {
            if (index == 0) {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: doc ?? Text(docStr ?? ''),
              );
            } else if (index == 1) {
              return Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Text('示例', 
                  style: TextStyle(
                    fontSize: 14.0
                  )
                )
              );
            } else {
              return demos[index - 2];
            }
          },
        ),
      )
    );
  }

}
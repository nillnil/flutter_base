
import 'package:base/base.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoPage extends StatelessWidget {
  DemoPage({
    Key key, 
    this.title, 
    this.doc, 
    this.docStr,
    this.demos = const <DemoTile>[],
  }) : super(key: key);

  final String title;
  final Widget doc;
  final String docStr;
  final List<DemoTile> demos;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      safeAreaTop: true,
      navBar: title != null ? BaseAppBar(
        title: Text(title),
        transitionBetweenRoutes: false,
      ): null,
      body: BaseScrollBar(
        child: ListView.separated(
          separatorBuilder: (_, __) => const Divider(height: .5,),
          itemCount: 2 + demos?.length,
          itemBuilder: (_, int index) {
            if (index == 0) {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: const EdgeInsets.all(10.0),
                child: doc ?? Text(docStr ?? ''),
              );
            } else if (index == 1) {
              return const Padding(
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
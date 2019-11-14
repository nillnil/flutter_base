
import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SateAreaDemo extends StatefulWidget {

  @override
  _SateAreaDemoState createState() => _SateAreaDemoState();

}

class _SateAreaDemoState extends State<SateAreaDemo> {

  bool safeAreaTop = false;
  bool safeAreaBottom = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: const Text('SafeArea Scaffold'),
        backgroundColor: Colors.white54,
      ),
      safeAreaTop: safeAreaTop,
      safeAreaBottom: safeAreaBottom,
      body: Container(
        color: Colors.indigoAccent,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.deepPurple,
            ),
            BaseSection(
              children: <Widget>[
                BaseTile(
                  titleText: 'safeAreaTop',
                  trailing: BaseSwitch(
                    value: safeAreaTop,
                    onChanged: (bool value) {
                      setState(() {
                        safeAreaTop = value;
                      });
                    },
                  ),
                ),
                BaseTile(
                  titleText: 'safeAreaBottom',
                  trailing: BaseSwitch(
                    value: safeAreaBottom,
                    onChanged: (bool value) {
                      setState(() {
                        safeAreaBottom = value;
                      });
                    },
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

}
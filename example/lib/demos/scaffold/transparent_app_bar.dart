
import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransparentAppBar extends StatefulWidget {

  @override
  _TransparentAppBarState createState() => _TransparentAppBarState();

}

class _TransparentAppBarState extends State<TransparentAppBar> {

  bool safeAreaTop = false;
  bool safeAreaBottom = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: Text('Transparent App Bar'),
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
              backgroundColor: Colors.white,
              children: <Widget>[
                BaseTile(
                  titleText: 'safeAreaTop',
                  trailing: BaseSwitch(
                    value: safeAreaTop,
                    onChanged: (value) {
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
                    onChanged: (value) {
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
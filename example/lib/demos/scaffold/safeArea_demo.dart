import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SateAreaDemo extends StatefulWidget {
  const SateAreaDemo({
    Key? key,
  }) : super(key: key);
  @override
  _SateAreaDemoState createState() => _SateAreaDemoState();
}

class _SateAreaDemoState extends State<SateAreaDemo> {
  bool safeAreaTop = false;
  bool safeAreaBottom = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: const BaseAppBar(
          title: Text('SafeArea Scaffold'),
        ),
        safeAreaTop: safeAreaTop,
        safeAreaBottom: safeAreaBottom,
        body: Container(
          color: const BaseColor().build(context),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 4,
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
                    cupertino: <String, dynamic>{
                      'backgroundColor': CupertinoColors
                          .tertiarySystemBackground
                          .resolveFrom(context),
                    },
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
                    cupertino: <String, dynamic>{
                      'backgroundColor': CupertinoColors
                          .tertiarySystemBackground
                          .resolveFrom(context),
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}

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
        appBar: BaseAppBar(
          title: const Text('SafeArea Scaffold'),
          backgroundColor: (const BaseColor().build(context) as Color).withAlpha(0),
          backdropFilter: false,
          border: null,
        ),
        safeAreaTop: safeAreaTop,
        safeAreaBottom: safeAreaBottom,
        body: Container(
          color: const BaseColor().build(context),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 8,
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
                    baseParam: BaseParam(
                      cupertino: <String, dynamic>{
                        'backgroundColor': CupertinoColors.tertiarySystemBackground.resolveFrom(context),
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
                    baseParam: BaseParam(
                      cupertino: <String, dynamic>{
                        'backgroundColor': CupertinoColors.tertiarySystemBackground.resolveFrom(context),
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

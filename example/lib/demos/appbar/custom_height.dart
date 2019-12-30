import 'package:base/base.dart';
import 'package:example/iconfont/iconfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomHeight extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomHeightState();
}

class _CustomHeightState extends State<CustomHeight> {
  int _height = 44;

  @override
  void initState() {
    super.initState();
    if (useCupertino) {
      _height = 44;
    } else {
      _height = 56;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: const Text('自定义高度'),
        height: _height.toDouble(),
        padding: const EdgeInsetsDirectional.only(end: 10.0),
        actions: <Widget>[
          Padding(
            padding: useCupertino
                ? EdgeInsets.zero
                : const EdgeInsets.only(right: 20.0),
            child: const BaseIcon(
              icon: IconFont.camera,
              size: 20,
            ),
          ),
        ],
      ),
      safeAreaTop: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 100),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3 * 2,
          child: Column(
            children: <Widget>[
              Text('$_height'),
              Row(
                children: <Widget>[
                  const Text('0'),
                  Expanded(
                    child: BaseSlider(
                      min: 0,
                      max: 200,
                      label: '$_height',
                      onChanged: (double value) {
                        setState(() {
                          _height = value.toInt();
                        });
                      },
                      value: _height.toDouble(),
                    ),
                  ),
                  const Text('200'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


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
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: Text('自定义高度'),
        height: _height.toDouble(),
        padding: EdgeInsetsDirectional.only(end: 10.0),
        actions: <Widget>[
          Padding(
            padding: useCupertino ? EdgeInsets.zero : EdgeInsets.only(right: 20.0),
            child: BaseIcon(
              icon: IconFont.camera,
              size: 20,
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 100),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3 * 2,
          child: Column(
            children: <Widget>[
              Text('$_height'),
              Row(
                children: <Widget>[
                  Text('0'),
                  Expanded(
                    child: BaseSlider(
                      min: 0,
                      max: 200,
                      label: '$_height',
                      onChanged: (double) {
                        setState(() {
                          _height = double.toInt();
                        });
                      },
                      value: _height.toDouble(),
                    ),
                  ),
                  Text('200'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  
}
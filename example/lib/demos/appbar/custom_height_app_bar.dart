
import 'package:base/base.dart';
import 'package:example/iconfont/iconfont.dart';
import 'package:flutter/widgets.dart';

class CustomHeightAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: Text('自定义高度'),
        height: 80,
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
      body: Container(),
    );
  }
  
}
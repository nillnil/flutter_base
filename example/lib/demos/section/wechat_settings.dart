
import 'package:base/base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class WechatSettings extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  	TextStyle style = TextStyle(
			fontSize: 16.0
		);
  	TextStyle trailingStyle = TextStyle(
			color: Colors.grey
		);
		EdgeInsets contentPadding = EdgeInsets.only(left: 20.0, right: 10.0);
		EdgeInsets margin = EdgeInsets.only(top: 5.0, bottom: 5.0);
		Icon trailingIcon = Icon(CupertinoIcons.right_chevron, color: Colors.grey);

  	return BaseScaffold(
      appBar: BaseAppBar(
        title: Text('设置'),
        backgroundColor: defaultTargetPlatform == TargetPlatform.iOS ?
          CupertinoTheme.of(context).scaffoldBackgroundColor : Theme.of(context).scaffoldBackgroundColor,
        border: null,
        elevation: 0.0,
        transitionBetweenRoutes: false,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                BaseSection(
                  margin: EdgeInsets.only(bottom: 10.0),
                  children: <Widget>[
                    BaseTile(
                      title: Text('账号与安全', style: style),
                      contentPadding: contentPadding,
                      trailing: trailingIcon
                    )
                  ]
                ),
                BaseSection(
                  margin: margin,
                  backgroundColor: Colors.white,
                  dividerIndent: 20.0,
                  children: <Widget>[
                    BaseTile(
                      title: Text('新消息通知', style: style),
                      contentPadding: contentPadding,
                      trailing: trailingIcon,
                      onTap: () {
                        // BaseRoute(ThemePage()).push(context);
                      }
                    ),
                    BaseTile(
                      title: Text('隐私', style: style),
                      contentPadding: contentPadding,
                      trailing: trailingIcon
                    ),
                    BaseTile(
                      title: Text('通用', style: style),
                      contentPadding: contentPadding,
                      trailing: trailingIcon
                    )
                  ]
                ),
                BaseSection(
                  margin: margin,
                  backgroundColor: Colors.white,
                  dividerIndent: 20.0,
                  children: [
                    BaseTile(
                      title: Text('帮助与反馈'),
                      contentPadding: contentPadding,
                      trailing: trailingIcon,
                    ),
                    BaseTile(
                      title: Text('关于', style: style),
                      contentPadding: contentPadding,
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('版本1.0.0', style: trailingStyle),
                            trailingIcon
                          ]
                        ),
                      )
                    )
                  ]
                ),
                BaseSection(
                  margin: margin,
                  children: <Widget>[
                    BaseTile(
                      title: Text('插件', style: style),
                      contentPadding: contentPadding,
                      trailing: trailingIcon
                    )
                  ],
                ),
                BaseSection(
                  margin: margin,
                  children: <Widget>[
                    BaseTile(
                      mainAxisAlignment: MainAxisAlignment.center,
                      title: Center(
                        child: Text('切换账号', style: style),
                      ),
                    )
                  ],
                ),
                BaseSection(
                  margin: margin,
                  children: <Widget>[
                    BaseTile(
                      mainAxisAlignment: MainAxisAlignment.center,
                      title: Center(
                        child: Text('退出登录',
                          style: TextStyle(
                            fontSize: 16.0
                          )
                        )
                      ),
                      onTap: () {
                        BaseAlertDialog(
                          content: Text('确定退出吗？', style: TextStyle(fontWeight: FontWeight.w600)),
                          actions: <Widget>[
                            BaseDialogAction(
                              child: Text('取消'),
                              textStyle: TextStyle(color: Colors.blue),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }
                            ),
                            BaseDialogAction(
                              child: Text('确定'),
                              textStyle: TextStyle(color: Colors.blue),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }
                            )
                          ]
                        ).show(context, barrierDismissible: false);
                      }
                    )
                  ]
                )
              ]
            );
          }
        )
      )
    );
  }
}
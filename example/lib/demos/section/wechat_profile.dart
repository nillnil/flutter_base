
import 'package:example/demos/section/wechat_settings.dart';
import 'package:example/iconfont/iconfont.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:base/base.dart';

class WechatProfile extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return WillPopScope(
      onWillPop: () => Future<bool>.value(false), // 禁用返回
      child: BaseScaffold(
        appBar: BaseAppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          border: null,
          elevation: 0.0,
          actions: <Widget>[
            BaseIcon(icon: IconFont.camera, size: 20)
          ],
        ),
        body: Container(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  BaseSection(
                    margin: EdgeInsets.only(top: 0.0, bottom: 15.0),
                    divider: null,
                    children: <Widget>[
                      BaseTile(
                        isThreeLine: false,
                        title: Text('Flutter Base Example', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0)),
                        subtitle: Text('ID: a1dslien1u3bxuanehqeuxye', style: TextStyle(color: Colors.grey)),
                        contentPadding: EdgeInsets.all(10.0),
                        leading: FlutterLogo(
                          size: 65.0,
                        ),
                        trailing: Container(
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(IconFont.qrcode, size: 15, color: Colors.grey)
                              ),
                              Icon(CupertinoIcons.right_chevron, color: Colors.grey)
                            ],
                          ),
                        )
                      )
                    ]
                  ),
                  BaseSection(
                    children: <Widget>[
                      BaseTile(
                        leading: Padding(
                          padding: EdgeInsets.only(right: 20.0, left: 10.0),
                          child: BaseIcon(
                            icon: IconFont.pay,
                            color: Colors.lightBlue
                          )
                        ),
                        title: Text('支付'),
                        trailing: Icon(CupertinoIcons.right_chevron, color: Colors.grey)
                      )
                    ]
                  ),
                  BaseSection(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    backgroundColor: Colors.white,
                    dividerIndent: 60.0,
                    children: <Widget>[
                      BaseTile(
                        leading: Padding(
                          padding: EdgeInsets.only(right: 20.0, left: 10.0),
                          child: Icon(
                            IconFont.collection,
                            color: Colors.redAccent
                          )
                        ),
                        title: Text('收藏'),
                        trailing: Icon(CupertinoIcons.right_chevron, color: Colors.grey)
                      ),
                      BaseTile(
                        leading: Padding(
                          padding: EdgeInsets.only(right: 20.0, left: 10.0),
                          child: Icon(
                            IconFont.photo,
                            color: Colors.blueAccent
                          )
                        ),
                        title: Text('相册'),
                        trailing: Icon(CupertinoIcons.right_chevron, color: Colors.grey)
                      ),
                      BaseTile(
                        leading: Padding(
                          padding: EdgeInsets.only(right: 20.0, left: 10.0),
                          child: Icon(
                            IconFont.card,
                            color: Colors.green
                          )
                        ),
                        title: Text('卡包'),
                        trailing: Icon(CupertinoIcons.right_chevron, color: Colors.grey)
                      ),
                      BaseTile(
                        leading: Padding(
                          padding: EdgeInsets.only(right: 20.0, left: 10.0),
                          child: Icon(
                            IconFont.emotion,
                            color: Colors.orangeAccent
                          )
                        ),
                        title: Text('表情'),
                        trailing: Icon(
                          CupertinoIcons.right_chevron, color: Colors.grey)
                      )
                    ]
                  ),
                  BaseSection(
                    children: <Widget>[
                      BaseTile(
                        leading: Padding(
                          padding: EdgeInsets.only(right: 20.0, left: 10.0),
                          child: Icon(
                            IconFont.settings,
                            color: Colors.blueGrey
                          )
                        ),
                        title: Text('设置'),
                        trailing: Container(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('点我', style: TextStyle(color: Colors.grey)),
                              Icon(CupertinoIcons.right_chevron, color: Colors.grey)
                            ],
                          ),
                        ),
                        onTap: () {
                          BaseRoute(
                            WechatSettings(),
                          ).push(context, rootNavigator: true);
                        }
                      )
                    ]
                  ),
                  BaseSection(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    children: <Widget>[
                      BaseTile(
                        title: Center(
                          child: Text('返回'),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ]
                  )
                ]
              );
            }
          )
        )
      ),
    );
	}

}

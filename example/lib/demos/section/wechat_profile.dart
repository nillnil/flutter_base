import 'package:example/demos/section/wechat_settings.dart';
import 'package:example/iconfont/iconfont.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:base/base.dart';

class WechatProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Widget cameraWidget = BaseIcon(
      icon: IconFont.camera,
      size: 20,
    );
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false), // 禁用返回
      child: BaseScaffold(
        appBar: BaseAppBar(
          automaticallyImplyLeading: false,
          border: null,
          elevation: 0.0,
          actions: <Widget>[
            useMaterial
                ? const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: cameraWidget,
                  )
                : cameraWidget,
          ],
          material: <String, dynamic>{
            'backgroundColor': Theme.of(context).cardColor ??
                const Color.fromARGB(255, 28, 28, 30),
          },
          cupertino: const <String, dynamic>{
            'backgroundColor': CupertinoColors.secondarySystemGroupedBackground,
          },
        ),
        body: Container(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (_, __) {
              return Column(
                children: const <Widget>[
                  BaseSection(
                    margin: EdgeInsets.only(top: 0.0, bottom: 15.0),
                    divider: null,
                    children: <Widget>[
                      _IdWidget(),
                    ],
                  ),
                  _Pay(),
                  BaseSection(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    divider: BaseSectionDivider(
                      insets: EdgeInsets.only(left: 20),
                    ),
                    children: <Widget>[
                      _Collection(),
                      _Photo(),
                      _Card(),
                      _Emotion(),
                    ],
                  ),
                  _Settings(),
                  _Back(),
                ],
              );
            },
          ),
        ),
        cupertino: const <String, dynamic>{
          'backgroundColor': CupertinoColors.systemGroupedBackground,
        },
      ),
    );
  }
}

const TextStyle _style = TextStyle(
  fontSize: 17.0,
);

const double _tileHeight = 58;

class _Back extends StatelessWidget {
  const _Back({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSection(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      children: <Widget>[
        BaseTile(
          title: const Center(
            child: Text(
              '返回',
              style: _style,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class _Settings extends StatelessWidget {
  const _Settings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSection(
      children: <Widget>[
        BaseTile(
          leading: const Padding(
            padding: EdgeInsets.only(right: 20.0, left: 10.0),
            child: Icon(
              IconFont.settings,
              color: Colors.blueGrey,
            ),
          ),
          height: _tileHeight,
          title: const Text(
            '设置',
            style: _style,
          ),
          trailing: Container(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Text(
                  '点我',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
                Icon(
                  CupertinoIcons.right_chevron,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          onTap: () {
            BaseRoute<dynamic>(
              builder: (_) => WechatSettings(),
              fullscreenGackGesture: true,
            ).push(context, rootNavigator: true);
          },
        ),
      ],
    );
  }
}

class _Emotion extends StatelessWidget {
  const _Emotion({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseTile(
      leading: Padding(
        padding: EdgeInsets.only(right: 20.0, left: 10.0),
        child: Icon(
          IconFont.emotion,
          color: Colors.orangeAccent,
        ),
      ),
      height: _tileHeight,
      title: Text(
        '表情',
        style: _style,
      ),
      trailing: Icon(
        CupertinoIcons.right_chevron,
        color: Colors.grey,
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      leading: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 10.0),
        child: Icon(IconFont.card, color: Colors.green),
      ),
      title: const Text(
        '卡包',
        style: _style,
      ),
      height: _tileHeight,
      trailing: const Icon(
        CupertinoIcons.right_chevron,
        color: Colors.grey,
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseTile(
      leading: Padding(
        padding: EdgeInsets.only(right: 20.0, left: 10.0),
        child: Icon(
          IconFont.photo,
          color: Colors.blueAccent,
        ),
      ),
      height: _tileHeight,
      title: Text(
        '相册',
        style: _style,
      ),
      trailing: Icon(
        CupertinoIcons.right_chevron,
        color: Colors.grey,
      ),
    );
  }
}

class _Collection extends StatelessWidget {
  const _Collection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseTile(
      leading: Padding(
        padding: EdgeInsets.only(right: 20.0, left: 10.0),
        child: Icon(
          IconFont.collection,
          color: Colors.redAccent,
        ),
      ),
      height: _tileHeight,
      title: Text(
        '收藏',
        style: _style,
      ),
      trailing: Icon(
        CupertinoIcons.right_chevron,
        color: Colors.grey,
      ),
    );
  }
}

class _Pay extends StatelessWidget {
  const _Pay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSection(
      children: <Widget>[
        BaseTile(
          leading: Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              left: 10.0,
            ),
            child: BaseIcon(
              icon: IconFont.pay,
              color: Colors.lightBlue,
            ),
          ),
          height: _tileHeight,
          title: const Text(
            '支付',
            style: _style,
          ),
          trailing: const Icon(
            CupertinoIcons.right_chevron,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _IdWidget extends StatelessWidget {
  const _IdWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      isThreeLine: false,
      title: const Text(
        'Flutter Base Example',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
        ),
      ),
      subtitle: const Text(
        'ID: a1dslien1u3bxuanehqeuxye',
        style: TextStyle(color: Colors.grey),
      ),
      contentPadding: const EdgeInsets.all(10.0),
      leading: const FlutterLogo(
        size: 65.0,
      ),
      trailing: Container(
        width: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                IconFont.qrcode,
                size: 15,
                color: Colors.grey,
              ),
            ),
            Icon(
              CupertinoIcons.right_chevron,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

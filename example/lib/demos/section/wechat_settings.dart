import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

const TextStyle style = TextStyle(fontSize: 17.0);
const double _tileHeight = 58;
const TextStyle trailingStyle = TextStyle(color: Colors.grey);
const EdgeInsets contentPadding = EdgeInsets.only(left: 20.0, right: 10.0);
const EdgeInsets margin = EdgeInsets.only(top: 5.0, bottom: 5.0);
const Icon trailingIcon = Icon(
  CupertinoIcons.right_chevron,
  color: Colors.grey,
);

class WechatSettings extends StatelessWidget {
  const WechatSettings({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool _isLight = (MediaQuery.maybeOf(context)?.platformBrightness ?? Brightness.light) == Brightness.light;
    return BaseScaffold(
      appBar: BaseAppBar(
        border: null,
        elevation: 0.0,
        height: isCupertinoMode ? 44.0 : 56.0,
        transitionBetweenRoutes: false,
        baseParam: BaseParam(
          cupertino: <String, dynamic>{
            'title': const Text('设置'),
            'backgroundColor': CupertinoTheme.of(context).scaffoldBackgroundColor,
          },
          material: <String, dynamic>{
            'title': Text(
              '设置',
              style: TextStyle(
                color: _isLight ? Colors.black : Colors.white,
              ),
            ),
            'iconTheme': Theme.of(context).iconTheme.copyWith(
                  color: _isLight ? Colors.black : Colors.white,
                ),
            'backgroundColor': Theme.of(context).scaffoldBackgroundColor,
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: const <Widget>[
              _Account(
                style: style,
                contentPadding: contentPadding,
                trailingIcon: trailingIcon,
              ),
              BaseSection(
                margin: margin,
                divider: BaseSectionDivider(
                  insets: EdgeInsets.only(left: 20),
                ),
                children: <Widget>[
                  _Message(
                    style: style,
                    contentPadding: contentPadding,
                    trailingIcon: trailingIcon,
                  ),
                  _Privacy(
                    style: style,
                    contentPadding: contentPadding,
                    trailingIcon: trailingIcon,
                  ),
                  _Gerenal(
                    style: style,
                    contentPadding: contentPadding,
                    trailingIcon: trailingIcon,
                  ),
                ],
              ),
              BaseSection(
                margin: margin,
                divider: BaseSectionDivider(
                  insets: EdgeInsets.only(left: 20),
                ),
                children: <Widget>[
                  _Help(
                    contentPadding: contentPadding,
                    trailingIcon: trailingIcon,
                  ),
                  _About(
                    style: style,
                    contentPadding: contentPadding,
                    trailingStyle: trailingStyle,
                    trailingIcon: trailingIcon,
                  ),
                ],
              ),
              _Plugin(
                margin: margin,
                style: style,
                contentPadding: contentPadding,
                trailingIcon: trailingIcon,
              ),
              _SwitchAccount(margin: margin, style: style),
              _Logout(margin: margin),
            ],
          );
        },
      ),
      baseParam: BaseParam(
        cupertino: const <String, dynamic>{
          'backgroundColor': CupertinoColors.systemGroupedBackground,
        },
      ),
    );
  }
}

class _SwitchAccount extends StatelessWidget {
  const _SwitchAccount({
    Key? key,
    required this.margin,
    required this.style,
  }) : super(key: key);

  final EdgeInsets margin;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return BaseSection(
      margin: margin,
      children: <Widget>[
        BaseTile(
          mainAxisAlignment: MainAxisAlignment.center,
          title: Center(
            child: Text('切换账号', style: style),
          ),
        ),
      ],
    );
  }
}

class _Plugin extends StatelessWidget {
  const _Plugin({
    Key? key,
    required this.margin,
    required this.style,
    required this.contentPadding,
    required this.trailingIcon,
  }) : super(key: key);

  final EdgeInsets margin;
  final TextStyle style;
  final EdgeInsets contentPadding;
  final Icon trailingIcon;

  @override
  Widget build(BuildContext context) {
    return BaseSection(
      margin: margin,
      children: <Widget>[
        BaseTile(
          title: Text('插件', style: style),
          contentPadding: contentPadding,
          trailing: trailingIcon,
        ),
      ],
    );
  }
}

class _Logout extends StatelessWidget {
  const _Logout({
    Key? key,
    required this.margin,
  }) : super(key: key);

  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return BaseSection(
      margin: margin,
      children: <Widget>[
        BaseTile(
          mainAxisAlignment: MainAxisAlignment.center,
          title: const Center(
            child: Text(
              '退出登录',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          onTap: () {
            BaseAlertDialog(
              content: const Text(
                '确定退出吗？',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              actions: <Widget>[
                BaseDialogAction(
                  child: const Text('取消'),
                  textStyle: const TextStyle(color: Colors.blue),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                BaseDialogAction(
                  child: const Text('确定'),
                  textStyle: const TextStyle(color: Colors.blue),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ).show<dynamic>(context, barrierDismissible: false);
          },
        ),
      ],
    );
  }
}

class _About extends StatelessWidget {
  const _About({
    Key? key,
    required this.style,
    required this.contentPadding,
    required this.trailingStyle,
    required this.trailingIcon,
  }) : super(key: key);

  final TextStyle style;
  final EdgeInsets contentPadding;
  final TextStyle trailingStyle;
  final Icon trailingIcon;

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      title: Text('关于', style: style),
      contentPadding: contentPadding,
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[Text('版本1.0.0', style: trailingStyle), trailingIcon],
        ),
      ),
    );
  }
}

class _Help extends StatelessWidget {
  const _Help({
    Key? key,
    required this.contentPadding,
    required this.trailingIcon,
  }) : super(key: key);

  final EdgeInsets contentPadding;
  final Icon trailingIcon;

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      title: const Text('帮助与反馈'),
      contentPadding: contentPadding,
      trailing: trailingIcon,
    );
  }
}

class _Gerenal extends StatelessWidget {
  const _Gerenal({
    Key? key,
    required this.style,
    required this.contentPadding,
    required this.trailingIcon,
  }) : super(key: key);

  final TextStyle style;
  final EdgeInsets contentPadding;
  final Icon trailingIcon;

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      title: Text('通用', style: style),
      contentPadding: contentPadding,
      trailing: trailingIcon,
    );
  }
}

class _Privacy extends StatelessWidget {
  const _Privacy({
    Key? key,
    required this.style,
    required this.contentPadding,
    required this.trailingIcon,
  }) : super(key: key);

  final TextStyle style;
  final EdgeInsets contentPadding;
  final Icon trailingIcon;

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      title: Text('隐私', style: style),
      contentPadding: contentPadding,
      trailing: trailingIcon,
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    Key? key,
    required this.style,
    required this.contentPadding,
    required this.trailingIcon,
  }) : super(key: key);

  final TextStyle style;
  final EdgeInsets contentPadding;
  final Icon trailingIcon;

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      title: Text('新消息通知', style: style),
      contentPadding: contentPadding,
      trailing: trailingIcon,
      height: _tileHeight,
    );
  }
}

class _Account extends StatelessWidget {
  const _Account({
    Key? key,
    required this.style,
    required this.contentPadding,
    required this.trailingIcon,
  }) : super(key: key);

  final TextStyle style;
  final EdgeInsets contentPadding;
  final Icon trailingIcon;

  @override
  Widget build(BuildContext context) {
    return BaseSection(
      margin: const EdgeInsets.only(bottom: 10.0),
      children: <Widget>[
        BaseTile(
          title: Text('账号与安全', style: style),
          contentPadding: contentPadding,
          trailing: trailingIcon,
        ),
      ],
    );
  }
}

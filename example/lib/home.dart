

import 'dart:async';

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'demos/demos.dart';
import 'demos/scaffold/scaffold_demos.dart';
import 'iconfont/iconfont.dart';
import 'settings.dart';

final List<Widget> _children = <Widget>[
  _Item(
    icon: BaseIcon(icon: IconFont.nav, size: 40, color: Colors.orangeAccent),
    title: const Text('AppBar', style: TextStyle(color: Colors.orangeAccent)),
    page: AppBarDemo()
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.page, size: 40, color: Colors.blueAccent),
    title: const Text('Scaffold', style: TextStyle(color: Colors.blueAccent)),
    page: ScaffoldDemos()
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.tile, size: 40, color: Colors.redAccent),
    title: const Text('Section & Tile', style: TextStyle(color: Colors.redAccent)),
    page: SectionDemo()
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.buttons, size: 40, color: Colors.greenAccent),
    title: const Text('Button', style: TextStyle(color: Colors.greenAccent)),
    page: ButtonDemos()
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.routes, size: 40, color: Colors.deepOrangeAccent),
    title: const Text('Routes', style: TextStyle(color: Colors.deepOrangeAccent)),
    page: RouteDemo()
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.dialog, size: 40, color: Colors.purpleAccent),
    title: const Text('Alert Dialog', style: TextStyle(color: Colors.purpleAccent)),
    page: DialogDemo()
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.rows, size: 40, color: Colors.blueGrey),
    title: const Text('ActionSheet', style: TextStyle(color: Colors.blueGrey)),
    page: ActionSheetDemo()
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.refresh, size: 40, color: Colors.pinkAccent),
    title: const Text('Refresh', style: TextStyle(color: Colors.pinkAccent)),
    page: RefreshDemos()
  ),
  _Item(
    icon: BaseIcon(icon: IconFont.text, size: 40, color: Colors.deepOrangeAccent),
    title: const Text('TextField', style: TextStyle(color: Colors.deepOrangeAccent)),
    page: TextFieldDemo()
  )
];

const  Widget _tipsWidget = Text('1、Material组件相对比较完善，没经过严格的测试，后续会完善优化\n\n'
  '2、每个组件都保留有forceUseCupertino、forceUseMaterial参数，都未经过严格测试，请慎用！！！'
  '因为各个组件之间有关联度，如果要切换组件的整体样式，强烈建议直接切换整个app使用的平台样式（并且不在app中动态切换），而不是使用'
  '单个组件中的forceUseCupertino、forceUseMaterial，后续可能会删除这2参数。',
  style: TextStyle(
    color: Colors.red,
    fontSize: 16.0,
  ),
  textAlign: TextAlign.left
);

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: const Text('Base Example'),
        padding: const EdgeInsetsDirectional.only(start: 5.0, end: 5.0),
        cupertino: <String, dynamic>{
          'leading': BaseIconButton(
            icon: BaseIcon(
              icon: IconFont.info,
              size: 24
            ),
            onPressed: () {
              const Duration transitionDuration = Duration(milliseconds: 300);
              Navigator.of(context).push<dynamic>(
                PageRouteBuilder<dynamic>(
                  opaque: false,
                  transitionDuration: transitionDuration,
                  transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                    return CupertinoFullscreenDialogTransition(
                      animation: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                    return const _CupertinoTipsPage(
                      transitionDuration: transitionDuration
                    );
                  }
                )
              );
            }
          )
        },
        actions: <Widget>[
          ClipOval(
            child: BaseIconButton(
              icon: BaseIcon(
                icon: IconFont.settings,
                size: 20,
                material: const <String, dynamic>{
                  'color': Colors.white,
                },
              ),
              onPressed: () {
                BaseRoute<dynamic>(Settings()).push(context);
              },
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 3,
          children: _children,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0
        )
      ),
      drawer: _MaterialTipsPage()
    );
  }
}

class _MaterialTipsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).appBarTheme.color ?? Theme.of(context).primaryColor,
              height: kToolbarHeight + MediaQuery.of(context).padding.top,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Center(
                child: const Text('特别说明', 
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  )
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: _tipsWidget,
            )
          ],
        ),
      )
    );
  }

}

class _CupertinoTipsPage extends StatefulWidget {

  const _CupertinoTipsPage({ 
    this.height,
    this.child,
    this.transitionDuration
  });

  final double height;
  final Widget child;
  final Duration transitionDuration;

  @override
  State<StatefulWidget> createState() => _CupertinoTipsPageState();

}

class _CupertinoTipsPageState extends State<_CupertinoTipsPage>  {

  double _offsetY = 0.0;
  double _originalOffsetY; 
  double _height;
  bool visible = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.transitionDuration, (){
      setState(() {
        visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _height = widget.height ?? size.height;
    if (_originalOffsetY == null) {
      _originalOffsetY = size.height - _height;
      _offsetY = _originalOffsetY;
    }
    final double paddingTop = MediaQuery.of(context).padding.top;
    final Widget content = Container(
      width: size.width,
      height: _height,
      margin: EdgeInsets.only(top: paddingTop),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10.0)
        )
      ),
      child: Column(
        children: <Widget>[
          _TipsHeader(callback: close),
          Expanded(
            child: IgnorePointer(
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: const <Widget>[
                  _tipsWidget
                ],
              ),
            ),
          )
        ],
      ),
    );
    final Widget gestureLayer = GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: paddingTop + 44.0),
        color: Colors.transparent,
      ),
      onVerticalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          final double _tempY = _offsetY + details.delta.dy;
          if (_tempY < _originalOffsetY) {
            _offsetY = _originalOffsetY;
          } else {
            _offsetY = _tempY;
          }
        });
      },
      onVerticalDragEnd: (DragEndDetails details) {
        if (_offsetY > (_originalOffsetY + _height / 4)) {
          close();
        } else {
          setState(() {
            _offsetY = _originalOffsetY ?? 0.0;
          });
        }
      },
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Visibility(
          child: Container(
            color: Colors.black.withOpacity(.5),
          ),
          visible: visible,
        ),
        AnimatedPositioned(
          top: _offsetY,
          duration: const Duration(milliseconds: 150),
          child: content,
        ),
        gestureLayer
      ],
    );
  }

  void close() {
    setState(() {
      visible = false;
    });
    Navigator.of(context).pop();
  }

}

class _TipsHeader extends StatelessWidget {

  const _TipsHeader({
    Key key,
    this.callback
  }) : super(key: key);

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.grey.withOpacity(.3)
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 50,
            child: BaseButton(
              padding: EdgeInsets.zero,
              child: BaseIcon(
                icon: CupertinoIcons.clear,
                size: 40,
                color: Colors.black,
              ),
              onPressed: () {
                if (callback != null) {
                  callback();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          const Text('特别说明'),
          Container(
            width: 50,
          )
        ],
      ),
    );
  }

}

class _Item extends StatelessWidget {
  const _Item({
    Key key, 
    this.title, 
    this.icon,
    this.page
  }) : super(key: key);

  final Text title;
  final BaseIcon icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            icon,
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
            ),
            title
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      onTap: () {
        BaseRoute<dynamic>(page).push(context);
      },
    );
  }

}

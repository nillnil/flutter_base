import 'dart:async';

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

class RefreshDemo extends StatelessWidget {
  const RefreshDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[
      DemoTile(
        page: _RefreshPage(),
      ),
    ];
    return DemoPage(
      widgetName: 'BaseRoute',
      materialDesc: 'use RefreshIndicator',
      cupertinoDesc: 'use CustomScrollView + CupertinoSliverRefreshControl',
      demos: _demos,
    );
  }
}

class _RefreshPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RefreshPageState();
}

class _RefreshPageState extends State<_RefreshPage> {
  int count = 1;
  int extent = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(20.0),
            child: const Text('pull refresh'),
          ),
          Expanded(
            child: BaseRefresh(
              child: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    if (index == count * 2 + 1) {
                      return null;
                    }
                    if (index.isOdd) {
                      return const Divider(height: .3);
                    }
                    return BaseTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      titleText: '${count - (index + 1) ~/ 2 + 1}',
                      baseParam: BaseParam(
                        cupertino: <String, dynamic>{
                          'backgroundColor': CupertinoColors.tertiarySystemBackground.resolveFrom(context),
                        },
                      ),
                    );
                  },
                ),
              ),
              onRefresh: () {
                return _refresh();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(
      const Duration(seconds: 1),
      () {
        setState(() {
          count += extent;
        });
        completer.complete();
      },
    );
    return completer.future;
  }
}

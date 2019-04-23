import 'dart:async';

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';
import '../demos.dart';

class RefreshDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[
      DemoTile(
        page: _RefreshPage(),
      ),
    ];
    return DemoPage(
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'BaseRoute',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(children: <Widget>[
            ColorBlock.material(),
            const Expanded(
              child: Text('Material：use RefreshIndicator'),
            )
          ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.cupertino(),
              const Expanded(
                child: Text(
                  'Cupertino：use CustomScrollView + CupertinoSliverRefreshControl',
                ),
              ),
            ],
          ),
        ],
      ),
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
    return Container(
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
                      return const Divider(height: .2);
                    }
                    return BaseTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                      titleText: '${count - (index + 1) ~/ 2 + 1}',
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
      Duration(seconds: 1),
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

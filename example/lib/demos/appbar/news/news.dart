import 'dart:convert';
import 'dart:ui' show window;

import 'package:base/base.dart';
import 'package:example/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'news_item.dart';

/// 简单的新闻页面
class News extends StatefulWidget {
  const News({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 12, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final TabBar tabBar = TabBar(
      controller: _controller,
      isScrollable: true,
      indicatorColor: BaseColor(
        dynamicColor: CupertinoDynamicColor.withBrightness(
          color: Colors.black.withOpacity(.5),
          darkColor: Colors.white.withOpacity(.5),
        ),
      ).build(context),
      tabs: const <Widget>[
        Tab(text: '头条'),
        Tab(text: '国内'),
        Tab(text: '国际'),
        Tab(text: '娱乐'),
        Tab(text: '体育'),
        Tab(text: '军事'),
        Tab(text: '科技'),
        Tab(text: '财经'),
        Tab(text: '时尚'),
        Tab(text: '游戏'),
        Tab(text: '汽车'),
        Tab(text: '健康'),
      ],
    );
    return BaseScaffold(
      appBar: BaseAppBar(
        bottom: tabBar,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
          TabBarView(
            controller: _controller,
            children: const <NewsList>[
              NewsList(type: 'top'),
              NewsList(type: 'guonei'),
              NewsList(type: 'guoji'),
              NewsList(type: 'yule'),
              NewsList(type: 'tiyu'),
              NewsList(type: 'junshi'),
              NewsList(type: 'keji'),
              NewsList(type: 'caijing'),
              NewsList(type: 'shishang'),
              NewsList(type: 'youxi'),
              NewsList(type: 'qiche'),
              NewsList(type: 'jiankang'),
            ],
          ),
          Positioned(
            right: 10.0,
            bottom: 88.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white.withOpacity(.5),
              foregroundColor: Colors.black,
              child: const BaseIcon(
                icon: Icons.arrow_back,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class NewsList extends StatefulWidget {
  const NewsList({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  State<StatefulWidget> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<NewsItem> _news = <NewsItem>[];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _news = <NewsItem>[];
    rootBundle.loadString('data/news/${widget.type}.json').then((String value) {
      final Map<String, dynamic> map = json.decode(value);
      final List<dynamic> list = map['data'];
      for (final dynamic item in list) {
        _news.add(NewsItem(news: item));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _news.isEmpty
        ? Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: const BaseIndicator(),
          )
        : Consumer<AppProvider>(
            builder: (_, AppProvider appProvider, __) {
              return ListView.custom(
                padding: MediaQuery.of(context).padding.copyWith(
                      top: MediaQueryData.fromWindow(window).padding.top + appProvider.appBarHeight!,
                    ),
                controller: PrimaryScrollController.of(context),
                childrenDelegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == _news.length * 2) {
                      return const SizedBox(
                        height: 60.0,
                        child: Center(
                          child: Text(
                            '没有更多数据',
                            style: TextStyle(fontSize: 14.0, color: Colors.grey),
                          ),
                        ),
                      );
                    }
                    if (index == _news.length * 2 + 1) {
                      return null;
                    }
                    if (index.isOdd) {
                      return const Divider(height: 1.0);
                    }
                    return _news[index ~/ 2];
                  },
                ),
              );
            },
          );
  }
}

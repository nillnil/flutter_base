
import 'dart:convert';

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

import 'news_item.dart';

/// 简单的新闻页面
class News extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _NewsState();

}

class _NewsState extends State<News> with SingleTickerProviderStateMixin{

	TabController _controller;

	@override
	void initState() {
		super.initState();
		_controller = TabController(length: 10, vsync: this);
	}

  @override
  Widget build(BuildContext context) {
    final TabBar tabBar = TabBar(
      controller: _controller,
      isScrollable: true,
      indicatorColor: Colors.white.withOpacity(.5),
      tabs: const <Widget>[
        Tab(text: '头条'),
        Tab(text: '社会'),
        Tab(text: '国内'),
        Tab(text: '国际'),
        Tab(text: '娱乐'),
        Tab(text: '体育'),
        Tab(text: '军事'),
        Tab(text: '科技'),
        Tab(text: '财经'),
        Tab(text: '时尚')
      ]
    );
    return BaseScaffold(
      appBar: BaseAppBar(
        title: const Text('Bottom'),
        height: 0.0,
        bottom: tabBar,
      ),
      body: Stack(
        children: <Widget>[
          TabBarView(
            controller: _controller,
            children: const <NewsList>[
              NewsList(type: 'top'),
              NewsList(type: 'shehui'),
              NewsList(type: 'guonei'),
              NewsList(type: 'guoji'),
              NewsList(type: 'yule'),
              NewsList(type: 'tiyu'),
              NewsList(type: 'junshi'),
              NewsList(type: 'keji'),
              NewsList(type: 'caijing'),
              NewsList(type: 'shishang'),
            ]
          ),
          Positioned(
            right: 10.0,
            bottom: 88.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white.withOpacity(.5),
              foregroundColor: Colors.black,
              child: BaseIcon(
                icon: Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}
 
class NewsList extends StatefulWidget {

  const NewsList({
    Key key, 
    this.type
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
      final List<dynamic> list = map[widget.type];
      for (dynamic item in list) {
        _news.add(NewsItem(news: item));
      }
      setState(() {
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return _news.isEmpty ? Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: BaseIndicator(),
    ): ListView.custom(
      controller: PrimaryScrollController.of(context),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == _news.length * 2) {
            return Container(
              height: 60.0,
              child: Center(
                child: const Text('没有更多数据',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey))
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
        }
      )
    );
  }

}


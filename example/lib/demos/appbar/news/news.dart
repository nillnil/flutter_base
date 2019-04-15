
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
    TabBar tabBar = TabBar(
      controller: _controller,
      isScrollable: true,
      indicatorColor: Colors.white.withOpacity(.5),
      tabs: <Widget>[
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
        title: Text('Bottom'),
        height: 0.0,
        bottom: tabBar,
      ),
      body: TabBarView(
        controller: _controller,
        children: [
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}
 
class NewsList extends StatefulWidget {

  final String type;

  const NewsList({
    Key key, 
    this.type
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsListState();

}

class _NewsListState extends State<NewsList> {

  List<NewsItem> _news = [];

  @override
  void initState() {
		super.initState();
    _loadData();
  }

  _loadData() {
    _news = [];
    rootBundle.loadString('data/news/${widget.type}.json').then((value) {
      Map<String, dynamic> map = json.decode(value);
      List<dynamic> list = map[widget.type];
      list.forEach((item) {
        _news.add(NewsItem(news: item));
      });
      setState(() {
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return _news.length == 0 ? Container(
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
                child: Text('没有更多数据',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey))
              ),
            );
          }
          if (index == _news.length * 2 + 1) {
            return null;
          }
          if (index.isOdd) {
            return Divider(height: 1.0);
          }
          return _news[index ~/ 2];
        }
      )
    );
  }

}


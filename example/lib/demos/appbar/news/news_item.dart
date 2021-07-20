import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/iconfont/iconfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsItem extends StatefulWidget {
  const NewsItem({
    Key? key,
    required this.news,
  }) : super(key: key);

  final Map<String, dynamic> news;

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget child;
    if (widget.news['thumbnail_pic_s02'] != null && widget.news['thumbnail_pic_s03'] != null) {
      child = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(widget.news['title'])),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.news['thumbnail_pic_s'],
                    placeholder: (BuildContext context, String url) {
                      return const Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: BaseIndicator(),
                        ),
                      );
                    },
                    errorWidget: (
                      BuildContext context,
                      String url,
                      dynamic error,
                    ) {
                      return const Icon(IconFont.brokenImage, size: 72);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.news['thumbnail_pic_s02'],
                    placeholder: (BuildContext context, String url) {
                      return const Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: BaseIndicator(),
                        ),
                      );
                    },
                    errorWidget: (
                      BuildContext context,
                      String url,
                      dynamic error,
                    ) {
                      return const Icon(IconFont.brokenImage, size: 72);
                    },
                  ),
                ),
              ),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: widget.news['thumbnail_pic_s03'],
                  placeholder: (BuildContext context, String url) {
                    return const Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: BaseIndicator(),
                      ),
                    );
                  },
                  errorWidget: (
                    BuildContext context,
                    String url,
                    dynamic error,
                  ) {
                    return const Icon(IconFont.brokenImage, size: 72);
                  },
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                widget.news['author_name'] + ' ' + widget.news['date'],
                style: const TextStyle(fontSize: 11.0, color: Colors.grey),
              ),
            ],
          ),
        ],
      );
    } else {
      child = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              margin: const EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.news['title']),
                  Text(
                    (widget.news['author_name'] ?? '') + ' ' + (widget.news['date'] ?? ''),
                    style: const TextStyle(fontSize: 11.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          if (widget.news['thumbnail_pic_s'] != null)
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: CachedNetworkImage(
                  imageUrl: widget.news['thumbnail_pic_s'],
                  height: 100,
                  fit: BoxFit.fill,
                  placeholder: (BuildContext context, String url) {
                    return const Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: BaseIndicator(),
                      ),
                    );
                  },
                  errorWidget: (
                    BuildContext context,
                    String url,
                    dynamic error,
                  ) {
                    return const Icon(IconFont.brokenImage, size: 72);
                  },
                ),
              ),
            )
          else
            Container()
        ],
      );
    }
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
          right: 10.0,
          bottom: 5.0,
          left: 10.0,
        ),
        child: child,
      ),
      onTap: () {
        BaseRoute<void>(
          builder: (_) => BaseScaffold(
            appBar: BaseAppBar(
              title: Text(
                widget.news['title'],
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const SizedBox(
                width: 34.0,
              ),
              transitionBetweenRoutes: false,
            ),
            safeAreaTop: true,
            body: WebView(
              initialUrl: widget.news['url'],
              javascriptMode: JavascriptMode.disabled,
            ),
          ),
          fullscreenGackGesture: false,
        ).push(context);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

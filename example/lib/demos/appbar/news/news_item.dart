
import 'package:base/indicator/base_indicator.dart';
import '../../../iconfont/iconfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsItem extends StatelessWidget{

	final Map<String, dynamic> news;

	NewsItem({
		Key key,
		this.news
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		Widget child;
		if (news['thumbnail_pic_s02'] != null && news['thumbnail_pic_s03'] != null) {
			child = Column(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					Row(
						children: <Widget>[
							Expanded(
								child: Text(news['title'])
							)
						]
					),
					Row(
						children: <Widget>[
							Expanded(
								child: Padding(
									padding: EdgeInsets.only(right: 5.0),
									child: CachedNetworkImage(
										imageUrl: news['thumbnail_pic_s'],
										placeholder: (BuildContext context, String url) {
                      return Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: BaseIndicator(),
                        )
                      );
                    },
										errorWidget: (BuildContext context, String url, Object error) {
                      return Icon(IconFont.brokenImage, size: 72);
                    }
									)
								)
							),
							Expanded(
								child: Padding(
									padding: EdgeInsets.only(right: 5.0),
									child: CachedNetworkImage(
										imageUrl: news['thumbnail_pic_s02'],
										placeholder: (BuildContext context, String url) {
                      return Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: BaseIndicator(),
                        )
                      );
                    },
										errorWidget: (BuildContext context, String url, Object error) {
                      return Icon(IconFont.brokenImage, size: 72);
                    }
									)
								)
							),
							Expanded(
								child: CachedNetworkImage(
									imageUrl: news['thumbnail_pic_s03'],
									placeholder: (BuildContext context, String url) {
                    return Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: BaseIndicator(),
                      )
                    );
                  },
                  errorWidget: (BuildContext context, String url, Object error) {
                    return Icon(IconFont.brokenImage, size: 72);
                  }
								)
							)
						]
					),
					Row(
						children: <Widget>[
							Text(news['author_name'] + ' ' + news['date'],
								style: TextStyle(fontSize: 11.0, color: Colors.grey)
							)
						],
					)
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
              margin: EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(news['title']),
                  Text((news['author_name'] ?? '') + ' ' + (news['date'] ?? ''),
                    style: TextStyle(fontSize: 11.0, color: Colors.grey)
                  )
                ]
              )
            )
					),
					news['thumbnail_pic_s'] != null ? Expanded(
						flex: 1,
						child: Padding(
							padding: EdgeInsets.all(0.0),
							child: CachedNetworkImage(
								imageUrl: news['thumbnail_pic_s'],
                height: 100,
                fit: BoxFit.fill,
								placeholder: (BuildContext context, String url) {
                  return Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: BaseIndicator(),
                    )
                  );
                },
                errorWidget: (BuildContext context, String url, Object error) {
                  return Icon(IconFont.brokenImage, size: 72);
                }
							)
						)
					): Container()
				]
			);
		}
		return GestureDetector(
			child: Container(
				padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 5.0, left: 10.0),
				color: Colors.white,
				child: child
			),
			onTap: () {
				_launchDetail(news['url']);
			}
		);
	}

	Future<Null> _launchDetail(String url) async {
		if (await canLaunch(url)) {
			await launch(url, forceWebView: true, forceSafariVC: true);
		} else {
			throw 'Could not launch $url';
		}
	}

}
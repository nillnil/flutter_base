
import 'package:flutter/material.dart';

class CupertinoTopBar extends StatefulWidget {

	final TabBar tabBar;
  final List<Widget> tabs;
  final Color backgroundColor;
  final TextStyle labelStyle;
  final PageController pageController;

	final Color indicatorColor;
	final double indicatorWeight;
	final EdgeInsetsGeometry indicatorPadding;
	final Decoration indicator;

  CupertinoTopBar({
    Key key,
		this.tabBar,
    this.backgroundColor,
    this.labelStyle,
    this.pageController,
  }) : tabs = tabBar?.tabs,
		indicatorColor = tabBar?.indicatorColor,
		indicatorWeight = tabBar?.indicatorWeight,
		indicatorPadding = tabBar?.indicatorPadding,
		indicator = tabBar?.indicator,
 		super(key: key);

  @override
  CupertinoTopBarState createState() => CupertinoTopBarState();

}

class CupertinoTopBarState extends State<CupertinoTopBar> {

  static const double _kTabHeight = 46.0;
  static const double _kTextAndIconTabHeight = 72.0;

  int _selectTabIndex = 0;
  TextStyle _style;

  @override
  void initState() {
    super.initState();
    _style = TextStyle(
      fontSize: 14.0,
      color: Colors.white
    ).merge(widget.labelStyle);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    int index = 0;
    widget.tabs.forEach((item) {
      Tab tab = item as Tab;
      children.add(_buildTab(tab, index));
      index += 1;
    });
    return PreferredSize(
      preferredSize: Size.infinite,
      child: Container(
        color: widget.backgroundColor,
        height: 44.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: children
              )
            )
          ]
        )
      )
    );
  }

  Widget _buildLabelText(Tab tab) {
    return tab.child ?? Text(
      tab.text,
      softWrap: false,
      overflow:
      TextOverflow.fade,
      style: _style
    );
  }

	Decoration get _indicator {
		if (widget.indicator != null) {
			return widget.indicator;
		}
		final TabBarTheme tabBarTheme = TabBarTheme.of(context);
		if (tabBarTheme.indicator != null) {
			return tabBarTheme.indicator;
		}
		Color color = widget.indicatorColor ?? Theme.of(context).indicatorColor ?? Colors.white;
		return UnderlineTabIndicator(
			insets: widget.indicatorPadding,
			borderSide: BorderSide(
				width: widget.indicatorWeight,
				color: color,
			),
		);
	}

  Widget _buildTab(Tab tab, int index) {
    double height;
    Widget label;
    if (tab.icon == null) {
      height = _kTabHeight;
      label = _buildLabelText(tab);
    } else if (tab.text == null) {
      height = _kTabHeight;
      label = tab.icon;
    } else {
      height = _kTextAndIconTabHeight;
      label = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: tab.icon,
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          _buildLabelText(tab)
        ]
      );
    }
    return GestureDetector(
      child: SizedBox(
        height: height,
        child: Container(
          decoration: index == _selectTabIndex ? _indicator : null,
          child: Center(
						child: Padding(
							padding: EdgeInsets.symmetric(horizontal: 16.0),
							child: label
						),
						widthFactor: 1.0
					)
        )
      ),
      onTapUp: (_) {
        setState(() {
          _selectTabIndex = index;
          widget.pageController.jumpToPage(_selectTabIndex);
        });
      }
    );
  }

  void changeTab(int index) {
    setState(() {
      _selectTabIndex = index;
    });
  }

}

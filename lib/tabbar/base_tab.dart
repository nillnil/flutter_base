import 'package:base/base_stateless_widget.dart';
import 'package:flutter/material.dart';

class BaseTab extends BaseStatelessWidget {
  BaseTab({
    Key key,
    this.text,
    this.child,
    this.icon,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  final String text;
  final Widget child;
  final Widget icon;

  static const double _kTabHeight = 46.0;
  static const double _kTextAndIconTabHeight = 72.0;

  @override
  Widget buildByCupertino(BuildContext context) {
    double height;
    Widget label;
    if (icon == null) {
      height = _kTabHeight;
      label = _buildLabelText();
    } else if (text == null) {
      height = _kTabHeight;
      label = icon;
    } else {
      height = _kTextAndIconTabHeight;
      label = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: icon,
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          _buildLabelText(),
        ],
      );
    }
    return SizedBox(
      height: height,
      child: Container(
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(
              width: 4.0,
              color: Colors.white30,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: label,
          ),
          widthFactor: 1.0,
        ),
      ),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return Tab(
      text: valueFromMaterial('text', text),
      icon: valueFromMaterial('icon', icon),
      child: valueFromMaterial('child', child),
    );
  }

  Widget _buildLabelText() {
    return child ?? Text(text, softWrap: false, overflow: TextOverflow.fade);
  }
}


import 'package:base/base.dart';
import 'package:example/store/action.dart';
import 'package:example/store/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ThemePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Color>(
      converter: (Store store) => store.state.primaryColor,
      builder: (BuildContext context, Color primaryColor) {
        List<Widget> _themes = [];
        Colors.primaries.forEach((color) {
          _themes.add(
            _ThemeItem(
              color: color,
              selected: primaryColor == color,
            )
          );
        });
        return BaseScaffold(
          appBar: BaseAppBar(
            title: Text('主题'),
            transitionBetweenRoutes: false,
          ),
          body: Container(
            color: Colors.white,
            child: GridView.count(
              children: _themes, 
              crossAxisCount: 6,
            ),
          ),
        );
      },
    );
  }

}

class _ThemeViewModel {

  final Color primaryColor;
  final void Function(Color primaryColor) changeTheme;

  _ThemeViewModel({
    this.primaryColor,
    this.changeTheme
  });

}

class _ThemeItem extends StatelessWidget {

  final Color color;
  final bool selected;

  const _ThemeItem({
    Key key, 
    this.color,
    this.selected = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ThemeViewModel>(
      converter: (Store store) {
        return _ThemeViewModel(
          primaryColor: store.state.primaryColor,
          changeTheme: (primaryColor) => store.dispatch(ThemeAction(primaryColor: primaryColor))
        );
      }, 
      builder: (BuildContext context, _ThemeViewModel vm) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            color: color,
            height: 60,
            width: 60,
            child: selected ? BaseIcon(
              icon: CupertinoIcons.check_mark,
              size: 40,
              color: Colors.white,
            ): Container()
          ),
          onTap: () {
            if (!selected) {
              vm.changeTheme(this.color);
            }
          },
        );
      }
    );
  }

}
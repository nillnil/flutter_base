// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// modify from https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/cupertino/bottom_tab_bar.dart
/// lastest push: 2019.12.29
/// flutter v1.13.5
/// 
/// lastest commit:  2019.12.17
/// commit https://github.com/flutter/flutter/commit/449f4a6673f6d89609b078eb2b595dee62fd1c79
/// #45502 https://github.com/flutter/flutter/pull/45502

import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoDynamicColor, CupertinoTheme;
import 'package:flutter/material.dart' hide BottomNavigationBarItem;
import 'package:flutter/painting.dart';

import '../widgets/bottom_navigation_bar_item.dart';

// Standard iOS 10 tab bar height.
const double _kTabBarHeight = 50.0;

const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x4C000000),
  darkColor: Color(0x29000000),
);
const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;

/// An iOS-styled bottom navigation tab bar.
///
/// Displays multiple tabs using [BottomNavigationBarItem] with one tab being
/// active, the first tab by default.
///
/// This [StatelessWidget] doesn't store the active tab itself. You must
/// listen to the [onTap] callbacks and call `setState` with a new [currentIndex]
/// for the new selection to reflect. This can also be done automatically
/// by wrapping this with a [CupertinoTabScaffold].
///
/// Tab changes typically trigger a switch between [Navigator]s, each with its
/// own navigation stack, per standard iOS design. This can be done by using
/// [CupertinoTabView]s inside each tab builder in [CupertinoTabScaffold].
///
/// If the given [backgroundColor]'s opacity is not 1.0 (which is the case by
/// default), it will produce a blurring effect to the content behind it.
///
/// When used as [CupertinoTabScaffold.tabBar], by default `CupertinoTabBar` has
/// its text scale factor set to 1.0 and does not respond to text scale factor
/// changes from the operating system, to match the native iOS behavior. To override
/// this behavior, wrap each of the `navigationBar`'s components inside a [MediaQuery]
/// with the desired [MediaQueryData.textScaleFactor] value. The text scale factor
/// value from the operating system can be retrieved in many ways, such as querying
/// [MediaQuery.textScaleFactorOf] against [CupertinoApp]'s [BuildContext].
///
/// See also:
///
///  * [CupertinoTabScaffold], which hosts the [CupertinoTabBar] at the bottom.
///  * [BottomNavigationBarItem], an item in a [CupertinoTabBar].
class CupertinoTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a tab bar in the iOS style.
  const CupertinoTabBar({
    Key key,
    @required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = _kDefaultTabBarInactiveColor,
    this.iconSize = 30.0,
    this.border = const Border(
      top: BorderSide(
        color: _kDefaultTabBarBorderColor,
        width: 0.0, // One physical pixel.
        style: BorderStyle.solid,
      ),
    ),
    this.showIndicator = true,
  })  : assert(items != null),
        assert(
          items.length >= 2,
          "Tabs need at least 2 items to conform to Apple's HIG",
        ),
        assert(currentIndex != null),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(iconSize != null),
        assert(inactiveColor != null),
        super(key: key);

  /// The interactive items laid out within the bottom navigation bar.
  ///
  /// Must not be null.
  final List<BottomNavigationBarItem> items;

  /// The callback that is called when a item is tapped.
  ///
  /// The widget creating the bottom navigation bar needs to keep track of the
  /// current index and call `setState` to rebuild it with the newly provided
  /// index.
  final ValueChanged<int> onTap;

  /// The index into [items] of the current active item.
  ///
  /// Must not be null and must inclusively be between 0 and the number of tabs
  /// minus 1.
  final int currentIndex;

  /// The background color of the tab bar. If it contains transparency, the
  /// tab bar will automatically produce a blurring effect to the content
  /// behind it.
  ///
  /// Defaults to [CupertinoTheme]'s `barBackgroundColor` when null.
  final Color backgroundColor;

  /// The foreground color of the icon and title for the [BottomNavigationBarItem]
  /// of the selected tab.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color activeColor;

  /// The foreground color of the icon and title for the [BottomNavigationBarItem]s
  /// in the unselected state.
  ///
  /// Defaults to a [CupertinoDynamicColor] that matches the disabled foreground
  /// color of the native `UITabBar` component. Cannot be null.
  final Color inactiveColor;

  /// The size of all of the [BottomNavigationBarItem] icons.
  ///
  /// This value is used to configure the [IconTheme] for the navigation bar.
  /// When a [BottomNavigationBarItem.icon] widget is not an [Icon] the widget
  /// should configure itself to match the icon theme's size and color.
  ///
  /// Must not be null.
  final double iconSize;

  /// The border of the [CupertinoTabBar].
  ///
  /// The default value is a one physical pixel top border with grey color.
  final Border border;

  /// when the icon is null, will add an indicator.
  final bool showIndicator;

  @override
  Size get preferredSize => const Size.fromHeight(_kTabBarHeight);

  /// Indicates whether the tab bar is fully opaque or can have contents behind
  /// it show through it.
  bool opaque(BuildContext context) {
    final Color backgroundColor =
        this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor;
    return CupertinoDynamicColor.resolve(backgroundColor, context).alpha == 0xFF;
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    final Color backgroundColor = CupertinoDynamicColor.resolve(
      this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      context,
    );

    BorderSide resolveBorderSide(BorderSide side) {
      return side == BorderSide.none
        ? side
        : side.copyWith(color: CupertinoDynamicColor.resolve(side.color, context));
    }

    // Return the border as is when it's a subclass.
    final Border resolvedBorder = border == null || border.runtimeType != Border
      ? border
      : Border(
        top: resolveBorderSide(border.top),
        left: resolveBorderSide(border.left),
        bottom: resolveBorderSide(border.bottom),
        right: resolveBorderSide(border.right),
      );

    final Color inactive = CupertinoDynamicColor.resolve(inactiveColor, context);
    Widget result = DecoratedBox(
      decoration: BoxDecoration(
        border: resolvedBorder,
        color: backgroundColor,
      ),
      child: SizedBox(
        height: _kTabBarHeight + bottomPadding,
        child: IconTheme.merge( // Default with the inactive state.
          data: IconThemeData(color: inactive, size: iconSize),
          child: DefaultTextStyle( // Default with the inactive state.
            style: CupertinoTheme.of(context).textTheme.tabLabelTextStyle.copyWith(color: inactive),
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Row(
                // Align bottom since we want the labels to be aligned.
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _buildTabItems(context),
              ),
            ),
          ),
        ),
      ),
    );

    if (!opaque(context)) {
      // For non-opaque backgrounds, apply a blur effect.
      result = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: result,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];

    for (int index = 0; index < items.length; index += 1) {
      final bool active = index == currentIndex;
      result.add(
        _wrapActiveItem(
          context,
          Expanded(
            child: Semantics(
              selected: active,
              // TODO(xster): This needs localization support. https://github.com/flutter/flutter/issues/13452
              hint: 'tab, ${index + 1} of ${items.length}',
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap == null ? null : () { onTap(index); },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildSingleTabItem(items[index], active),
                  ),
                ),
              ),
            ),
          ),
          active: active,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildSingleTabItem(BottomNavigationBarItem item, bool active) {
    // icon can be null
    final List<Widget> components = <Widget>[];
    if (item.icon != null) {
      components.add(Expanded(
        child: Center(child: active ? item.activeIcon : item.icon),
      ));
    }
    if (item.title != null) {
      if (components.isEmpty) {
        components.add(Expanded(
          child: Center(
            child: DefaultTextStyle.merge(
              style: const TextStyle(fontSize: 17.0),
              child: item.title,
            ),
          ),
        ));
        if (showIndicator && active) {
          components.add(
            Container(
              decoration: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: activeColor,
                  width: 2,
                ),
                insets: const EdgeInsets.symmetric(horizontal: 30.0),
              ),
            ),
          );
        }
      } else {
        components.add(item.title);
      }
    }
    return components;
  }

  /// Change the active tab item's icon and title colors to active.
  Widget _wrapActiveItem(BuildContext context, Widget item, { @required bool active }) {
    if (!active)
      return item;

    final Color activeColor = CupertinoDynamicColor.resolve(
      this.activeColor ?? CupertinoTheme.of(context).primaryColor,
      context,
    );
    return IconTheme.merge(
      data: IconThemeData(color: activeColor),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: activeColor),
        child: item,
      ),
    );
  }

  /// Create a clone of the current [CupertinoTabBar] but with provided
  /// parameters overridden.
  CupertinoTabBar copyWith({
    Key key,
    List<BottomNavigationBarItem> items,
    Color backgroundColor,
    Color activeColor,
    Color inactiveColor,
    double iconSize,
    Border border,
    int currentIndex,
    ValueChanged<int> onTap,
    bool showIndicator,
  }) {
    return CupertinoTabBar(
      key: key ?? this.key,
      items: items ?? this.items,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      iconSize: iconSize ?? this.iconSize,
      border: border ?? this.border,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
      showIndicator: showIndicator ?? this.showIndicator,
    );
  }
}

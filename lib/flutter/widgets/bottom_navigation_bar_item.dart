// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// modify from https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/bottom_navigation_bar_item.dart
/// lastest push: 2019.02.22
/// lastest update: flutter v1.5.9-pre.109 2019.05.02
/// commit https://github.com/flutter/flutter/commit/617ca62709bfa0ce64f6ee90cab2e1e9d46aa173
/// #28159 https://github.com/flutter/flutter/pull/28159

import 'dart:ui' show Color;

import 'package:flutter/widgets.dart' show Widget;

/// An interactive button within either material's [BottomNavigationBar]
/// or the iOS themed [CupertinoTabBar] with an icon and title.
///
/// This class is rarely used in isolation. It is typically embedded in one of
/// the bottom navigation widgets above.
///
/// See also:
///
///  * [BottomNavigationBar]
///  * <https://material.io/design/components/bottom-navigation.html>
///  * [CupertinoTabBar]
///  * <https://developer.apple.com/ios/human-interface-guidelines/bars/tab-bars>
class BottomNavigationBarItem {
  /// Creates an item that is used with [BottomNavigationBar.items].
  ///
  /// The argument [icon] should not be null and the argument [title] should not be null when used in a Material Design's [BottomNavigationBar].
  const BottomNavigationBarItem({
    this.icon,
    this.title,
    Widget activeIcon,
    this.backgroundColor,
  }) : activeIcon = activeIcon ?? icon,
       assert(icon != null || title != null);

  /// The icon of the item.
  ///
  /// Typically the icon is an [Icon] or an [ImageIcon] widget. If another type
  /// of widget is provided then it should configure itself to match the current
  /// [IconTheme] size and color.
  ///
  /// If [activeIcon] is provided, this will only be displayed when the item is
  /// not selected.
  ///
  /// To make the bottom navigation bar more accessible, consider choosing an
  /// icon with a stroked and filled version, such as [Icons.cloud] and
  /// [Icons.cloud_queue]. [icon] should be set to the stroked version and
  /// [activeIcon] to the filled version.
  ///
  /// If a particular icon doesn't have a stroked or filled version, then don't
  /// pair unrelated icons. Instead, make sure to use a
  /// [BottomNavigationBarType.shifting].
  final Widget icon;

  /// An alternative icon displayed when this bottom navigation item is
  /// selected.
  ///
  /// If this icon is not provided, the bottom navigation bar will display
  /// [icon] in either state.
  ///
  /// See also:
  ///
  ///  * [BottomNavigationBarItem.icon], for a description of how to pair icons.
  final Widget activeIcon;

  /// The title of the item. If the title is not provided only the icon will be shown when not used in a Material Design [BottomNavigationBar].
  final Widget title;

  /// The color of the background radial animation for material [BottomNavigationBar].
  ///
  /// If the navigation bar's type is [BottomNavigationBarType.shifting], then
  /// the entire bar is flooded with the [backgroundColor] when this item is
  /// tapped. This will override [BottomNavigationBar.backgroundColor].
  ///
  /// Not used for [CupertinoTabBar]. Control the invariant bar color directly
  /// via [CupertinoTabBar.backgroundColor].
  ///
  /// See also:
  ///
  ///  * [Icon.color] and [ImageIcon.color] to control the foreground color of
  ///     the icons themselves.
  final Color backgroundColor;
}

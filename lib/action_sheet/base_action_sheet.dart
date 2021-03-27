import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_constants.dart';
import '../base_stateless_widget.dart';
import '../platform/platform.dart';

/// BaseActionSheet
/// use CupertinoActionSheet by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use custom BottomSheet on cuperitno.
/// use custom BottomSheet by material
/// *** use material = { forceUseCupertino: true } force use CupertinoActionSheet on material.
///
/// CupertinoActionSheet: 2021.03.12
/// BottomSheet: 2021.03.06
/// modify 2021.03.22 by flutter 2.0.3
class BaseActionSheet extends BaseStatelessWidget {
  const BaseActionSheet({
    Key? key,
    this.title,
    this.message,
    this.actions,
    this.messageScrollController,
    this.actionScrollController,
    this.cancelButton,
    this.animationController,
    this.onClosing,
    this.backgroundColor,
    this.enableDrag = true,
    this.onDragStart,
    this.onDragEnd,
    this.elevation = 0.0,
    this.shape,
    this.clipBehavior,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  // *** general properties start ***

  /// [CupertinoActionSheet.title]
  final Widget? title;

  /// [CupertinoActionSheet.message]
  final Widget? message;

  /// [CupertinoActionSheet.actions]
  final List<Widget>? actions;

  /// [CupertinoActionSheet.messageScrollController]
  final ScrollController? messageScrollController;

  /// [CupertinoActionSheet.actionScrollController]
  final ScrollController? actionScrollController;

  /// [BaseActionSheetAction]
  final Widget? cancelButton;

  /// *** general properties end ***

  /// *** material properties start ***

  /// [BottomSheet.animationController]
  final AnimationController? animationController;

  /// [BottomSheet.onClosing]
  final VoidCallback? onClosing;

  /// [BottomSheet.enableDrag]
  final bool enableDrag;

  /// [BottomSheet.onDragStart]
  final BottomSheetDragStartHandler? onDragStart;

  /// [BottomSheet.onDragEnd]
  final BottomSheetDragEndHandler? onDragEnd;

  /// [BottomSheet.backgroundColor]
  final Color? backgroundColor;

  /// [BottomSheet.elevation], default is 0.0
  final double? elevation;

  /// [BottomSheet.shape]
  final ShapeBorder? shape;

  /// [BottomSheet.clipBehavior]
  final Clip? clipBehavior;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoActionSheet(
      title: valueFromCupertino('title', title),
      message: valueFromCupertino('message', message),
      actions: valueFromCupertino('actions', actions),
      messageScrollController: valueFromCupertino(
        'messageScrollController',
        messageScrollController,
      ),
      actionScrollController: valueFromCupertino(
        'actionScrollController',
        actionScrollController,
      ),
      cancelButton: valueFromCupertino('cancelButton', cancelButton),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return BottomSheet(
      animationController: animationController,
      onClosing: () {
        if (onClosing != null) {
          onClosing!();
        }
      },
      builder: (BuildContext context) {
        final List<Widget> children = <Widget>[
          _buildContent(),
          _buildActions(),
        ];
        return SafeArea(
          child: Semantics(
            namesRoute: true,
            scopesRoute: true,
            explicitChildNodes: true,
            child: Column(
              children: children,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ),
        );
      },
      enableDrag: enableDrag,
      onDragStart: onDragStart,
      onDragEnd: onDragEnd,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
    );
  }

  Future<T?> show<T>(
    BuildContext context, {
    Color? barrierColor,
    bool barrierDismissible = true,
    bool? useRootNavigator,
    bool? semanticsDismissible,
    RouteSettings? routeSettings,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    AnimationController? transitionAnimationController,
  }) {
    const Color _cupertinoDefaultBarrierColor = CupertinoDynamicColor.withBrightness(
      color: Color(0x33000000),
      darkColor: Color(0x7A000000),
    );
    if (useCupertino) {
      if (cupertino != null &&
          cupertino![forceUseMaterial] != null &&
          cupertino![forceUseMaterial]) {
        final bool _useRootNavigator = useRootNavigator ??= false;
        return _showByMaterial<T>(
          context,
          barrierColor: barrierColor,
          isScrollControlled: isScrollControlled,
          useRootNavigator: _useRootNavigator,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          routeSettings: routeSettings,
          transitionAnimationController: transitionAnimationController,
        );
      }
      final bool _useRootNavigator = useRootNavigator ??= true;
      return _showByCupertino<T>(
        context,
        barrierColor: barrierColor ?? _cupertinoDefaultBarrierColor,
        barrierDismissible: barrierDismissible,
        useRootNavigator: _useRootNavigator,
        semanticsDismissible: semanticsDismissible,
        routeSettings: routeSettings,
      );
    } else {
      if (material != null &&
          material![forceUseCupertino] != null &&
          material![forceUseCupertino]) {
        final bool _useRootNavigator = useRootNavigator ??= true;
        return _showByCupertino<T>(
          context,
          barrierColor: barrierColor ?? _cupertinoDefaultBarrierColor,
          barrierDismissible: barrierDismissible,
          useRootNavigator: _useRootNavigator,
          semanticsDismissible: semanticsDismissible,
          routeSettings: routeSettings,
        );
      }
      final bool _useRootNavigator = useRootNavigator ??= false;
        return _showByMaterial<T>(
          context,
          barrierColor: barrierColor,
          isScrollControlled: isScrollControlled,
          useRootNavigator: _useRootNavigator,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          routeSettings: routeSettings,
          transitionAnimationController: transitionAnimationController,
        );
    }
  }

  Future<T?> _showByCupertino<T>(
    BuildContext context, {
    required Color barrierColor,
    required bool barrierDismissible,
    required bool useRootNavigator,
    bool? semanticsDismissible,
    RouteSettings? routeSettings,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      semanticsDismissible: semanticsDismissible,
      routeSettings: routeSettings,
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  Future<T?> _showByMaterial<T>(
    BuildContext context, {
    Color? barrierColor,
    required bool isScrollControlled,
    required bool useRootNavigator,
    required bool isDismissible,
    required bool enableDrag,
    required RouteSettings? routeSettings,
    required AnimationController? transitionAnimationController,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  Widget _buildContent() {
    final List<Widget> content = <Widget>[];
    if (title != null || message != null) {
      final Widget titleSection = _MaterialAlertContentSection(
        title: title,
        message: message,
        scrollController: messageScrollController,
      );
      content.add(Flexible(child: titleSection));
    }

    return Container(
      color: _kBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: content,
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      color: _kBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _MaterialActionSection(
            actions: valueFromMaterial('actions', actions),
            cancelButton: valueFromMaterial('cancelButton', cancelButton),
            scrollController: valueFromMaterial(
              'actionScrollController',
              actionScrollController,
            ),
          )
        ],
      ),
    );
  }
}

const Color _kContentTextColor = Color(0xFF8F8F8F);
const Color _kBackgroundColor = Color(0xD1F8F8F8);
const double _kContentHorizontalPadding = 40.0;
const double _kContentVerticalPadding = 14.0;

class _MaterialAlertContentSection extends StatelessWidget {
  const _MaterialAlertContentSection({
    Key? key,
    this.title,
    this.message,
    this.scrollController,
  }) : super(key: key);

  final Widget? title;
  final Widget? message;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final List<Widget> titleContentGroup = <Widget>[];
    final TextStyle _contentStyle =
        (Theme.of(context).textTheme.headline6 ?? const TextStyle()).copyWith(
              inherit: false,
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: _kContentTextColor,
              textBaseline: TextBaseline.alphabetic,
            );
    if (title != null) {
      titleContentGroup.add(
        Padding(
          padding: const EdgeInsets.only(
            left: _kContentHorizontalPadding,
            right: _kContentHorizontalPadding,
            bottom: _kContentVerticalPadding,
            top: _kContentVerticalPadding,
          ),
          child: DefaultTextStyle(
            style: message == null
                ? _contentStyle
                : _contentStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            textAlign: TextAlign.center,
            child: title!,
          ),
        ),
      );
    }

    if (message != null) {
      titleContentGroup.add(
        Padding(
          padding: EdgeInsets.only(
            left: _kContentHorizontalPadding,
            right: _kContentHorizontalPadding,
            bottom: title == null ? _kContentVerticalPadding : 22.0,
            top: title == null ? _kContentVerticalPadding : 0.0,
          ),
          child: DefaultTextStyle(
            style: title == null
                ? _contentStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  )
                : _contentStyle,
            textAlign: TextAlign.center,
            child: message!,
          ),
        ),
      );
    }

    if (titleContentGroup.isEmpty) {
      return SingleChildScrollView(
        controller: scrollController,
        child: const SizedBox(
          width: 0.0,
          height: 0.0,
        ),
      );
    }
    if (titleContentGroup.length > 1) {
      titleContentGroup.insert(
        1,
        const Padding(padding: EdgeInsets.only(top: 8.0)),
      );
    }

    return Scrollbar(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: titleContentGroup,
        ),
      ),
    );
  }
}

class _MaterialActionSection extends StatelessWidget {
  const _MaterialActionSection({
    Key? key,
    this.actions = const <Widget>[],
    this.cancelButton,
    this.scrollController,
  }) : super(key: key);

  final List<Widget> actions;
  final Widget? cancelButton;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    final Divider contentDivider = Divider(
      height: 0.0,
      color: Colors.grey.withOpacity(.5),
    );
    final Divider actionDivider = Divider(
      height: 0.0,
      color: Colors.grey.withOpacity(.2),
    );
    final Divider cancelDivider = Divider(
      height: 0.0,
      color: Colors.grey.withOpacity(.8),
    );
    if (actions != null && actions.isNotEmpty) {
      children.add(contentDivider);
      for (int i = 0; i < actions.length; i++) {
        children.add(actions[i]);
        if (i != actions.length - 1) {
          children.add(actionDivider);
        }
      }
    }
    if (cancelButton != null) {
      children.add(cancelDivider);
      children.add(cancelButton!);
    }
    return Scrollbar(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

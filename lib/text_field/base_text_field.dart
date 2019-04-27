import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

import '../base_stateless_widget.dart';

// BaseIcon
/// use CupertinoTextField by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use TextField on cuperitno.
/// use TextField by material
/// *** use material = { forceUseCupertino: true } force use CupertinoTextField on material.
class BaseTextField extends BaseStatelessWidget {
  BaseTextField({
    Key baseKey,
    this.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius = const Radius.circular(2.0),
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    // cupertino
    this.cupertinoDecoration = const BoxDecoration(
      border: Border(
        top: _kDefaultRoundedBorderSide,
        bottom: _kDefaultRoundedBorderSide,
        left: _kDefaultRoundedBorderSide,
        right: _kDefaultRoundedBorderSide,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    this.padding = const EdgeInsets.all(6.0),
    this.placeholder,
    this.placeholderStyle = const TextStyle(
      fontWeight: FontWeight.w300,
      color: _kInactiveTextColor,
    ),
    this.prefix,
    this.prefixMode = OverlayVisibilityMode.always,
    this.suffix,
    this.suffixMode = OverlayVisibilityMode.always,
    this.clearButtonMode = OverlayVisibilityMode.never,
    // material
    this.materialDecoration = const InputDecoration(),
    this.textDirection,
    this.onTap,
    this.buildCounter,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  // general
  @override
  final Key key;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final int maxLines;
  final int minLines;
  final bool expands;
  final int maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;

  // cupertino
  final BoxDecoration cupertinoDecoration;
  final EdgeInsetsGeometry padding;
  final String placeholder;
  final TextStyle placeholderStyle;
  final Widget prefix;
  final OverlayVisibilityMode prefixMode;
  final Widget suffix;
  final OverlayVisibilityMode suffixMode;
  final OverlayVisibilityMode clearButtonMode;

  // material
  final InputDecoration materialDecoration;
  final TextDirection textDirection;
  final GestureTapCallback onTap;
  final InputCounterWidgetBuilder buildCounter;

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoTextField(
      key: valueFromCupertino('key', key),
      controller: valueFromCupertino('controller', controller),
      focusNode: valueFromCupertino('focusNode', focusNode),
      keyboardType: valueFromCupertino('keyboardType', keyboardType),
      textInputAction: valueFromCupertino('textInputAction', textInputAction),
      textCapitalization:
          valueFromCupertino('textCapitalization', textCapitalization),
      style: valueFromCupertino('style', style),
      strutStyle: valueFromCupertino('strutStyle', strutStyle),
      textAlign: valueFromCupertino('textAlign', textAlign),
      autofocus: valueFromCupertino('autofocus', autofocus),
      obscureText: valueFromCupertino('obscureText', obscureText),
      autocorrect: valueFromCupertino('autocorrect', autocorrect),
      maxLines: valueFromCupertino('maxLines', maxLines),
      minLines: valueFromCupertino('minLines', minLines),
      expands: valueFromCupertino('expands', expands),
      maxLength: valueFromCupertino('maxLength', maxLength),
      maxLengthEnforced:
          valueFromCupertino('maxLengthEnforced', maxLengthEnforced),
      onChanged: valueFromCupertino('onChanged', onChanged),
      onEditingComplete:
          valueFromCupertino('onEditingComplete', onEditingComplete),
      onSubmitted: valueFromCupertino('onSubmitted', onSubmitted),
      inputFormatters: valueFromCupertino('inputFormatters', inputFormatters),
      enabled: valueFromCupertino('enabled', enabled),
      cursorWidth: valueFromCupertino('cursorWidth', cursorWidth),
      cursorRadius: valueFromCupertino('cursorRadius', cursorRadius),
      cursorColor: valueFromCupertino('cursorColor', cursorColor),
      keyboardAppearance:
          valueFromCupertino('keyboardAppearance', keyboardAppearance),
      scrollPadding: valueFromCupertino('scrollPadding', scrollPadding),
      dragStartBehavior:
          valueFromCupertino('dragStartBehavior', dragStartBehavior),
      // cupertino
      decoration: cupertinoDecoration,
      padding: padding,
      placeholder: placeholder,
      placeholderStyle: placeholderStyle,
      prefix: prefix,
      prefixMode: prefixMode,
      suffix: suffix,
      suffixMode: suffixMode,
      clearButtonMode: clearButtonMode,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return TextField(
      key: valueFromMaterial('key', key),
      controller: valueFromMaterial('controller', controller),
      focusNode: valueFromMaterial('focusNode', focusNode),
      keyboardType: valueFromMaterial('keyboardType', keyboardType),
      textInputAction: valueFromMaterial('textInputAction', textInputAction),
      textCapitalization:
          valueFromMaterial('textCapitalization', textCapitalization),
      style: valueFromMaterial('style', style),
      strutStyle: valueFromMaterial('strutStyle', strutStyle),
      textAlign: valueFromMaterial('textAlign', textAlign),
      autofocus: valueFromMaterial('autofocus', autofocus),
      obscureText: valueFromMaterial('obscureText', obscureText),
      autocorrect: valueFromMaterial('autocorrect', autocorrect),
      maxLines: valueFromMaterial('maxLines', maxLines),
      minLines: valueFromMaterial('minLines', minLines),
      expands: valueFromMaterial('expands', expands),
      maxLength: valueFromMaterial('maxLength', maxLength),
      maxLengthEnforced:
          valueFromMaterial('maxLengthEnforced', maxLengthEnforced),
      onChanged: valueFromMaterial('onChanged', onChanged),
      onEditingComplete:
          valueFromMaterial('onEditingComplete', onEditingComplete),
      onSubmitted: valueFromMaterial('onSubmitted', onSubmitted),
      inputFormatters: valueFromMaterial('inputFormatters', inputFormatters),
      enabled: valueFromMaterial('enabled', enabled),
      cursorWidth: valueFromMaterial('cursorWidth', cursorWidth),
      cursorRadius: valueFromMaterial('cursorRadius', cursorRadius),
      cursorColor: valueFromMaterial('cursorColor', cursorColor),
      keyboardAppearance:
          valueFromMaterial('keyboardAppearance', keyboardAppearance),
      scrollPadding: valueFromMaterial('scrollPadding', scrollPadding),
      dragStartBehavior:
          valueFromMaterial('dragStartBehavior', dragStartBehavior),
      // material
      decoration: materialDecoration,
      textDirection: textDirection,
      onTap: onTap,
      buildCounter: buildCounter,
    );
  }
}

const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoColors.lightBackgroundGray,
  style: BorderStyle.solid,
  width: 0.0,
);
const Color _kInactiveTextColor = Color(0xFFC2C2C2);

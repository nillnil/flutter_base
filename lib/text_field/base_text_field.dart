import 'package:flutter/cupertino.dart'
    show CupertinoColors, CupertinoTextField, OverlayVisibilityMode;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

import '../base_stateless_widget.dart';

// BaseTextField
/// use CupertinoTextField by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use TextField on cuperitno.
/// use TextField by material
/// *** use material = { forceUseCupertino: true } force use CupertinoTextField on material.
class BaseTextField extends BaseStatelessWidget {
  const BaseTextField({
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

  /// *** general properties start ***

  @override
  final Key key;

  /// [CupertinoTextField.controller]
  /// or
  /// [TextField.controller]
  final TextEditingController controller;

  /// [CupertinoTextField.focusNode]
  /// or
  /// [TextField.focusNode]
  final FocusNode focusNode;

  /// [CupertinoTextField.keyboardType]
  /// or
  /// [TextField.keyboardType]
  final TextInputType keyboardType;

  /// [CupertinoTextField.textInputAction]
  /// or
  /// [TextField.textInputAction]
  final TextInputAction textInputAction;

  /// [CupertinoTextField.textCapitalization]
  /// or
  /// [TextField.textCapitalization]
  final TextCapitalization textCapitalization;

  /// [CupertinoTextField.style]
  /// or
  /// [TextField.style]
  final TextStyle style;

  /// [CupertinoTextField.strutStyle]
  /// or
  /// [TextField.strutStyle]
  final StrutStyle strutStyle;

  /// [CupertinoTextField.textAlign]
  /// or
  /// [TextField.textAlign]
  final TextAlign textAlign;

  /// [CupertinoTextField.autofocus]
  /// or
  /// [TextField.autofocus]
  final bool autofocus;

  /// [CupertinoTextField.]
  /// or
  /// [TextField.]
  final bool obscureText;

  /// [CupertinoTextField.autocorrect]
  /// or
  /// [TextField.autocorrect]
  final bool autocorrect;

  /// [CupertinoTextField.maxLines]
  /// or
  /// [TextField.maxLines]
  final int maxLines;

  /// [CupertinoTextField.minLines]
  /// or
  /// [TextField.minLines]
  final int minLines;

  /// [CupertinoTextField.expands]
  /// or
  /// [TextField.expands]
  final bool expands;

  /// [CupertinoTextField.maxLength]
  /// or
  /// [TextField.maxLength]
  final int maxLength;

  /// [CupertinoTextField.maxLengthEnforced]
  /// or
  /// [TextField.maxLengthEnforced]
  final bool maxLengthEnforced;

  /// [CupertinoTextField.onChanged]
  /// or
  /// [TextField.onChanged]
  final ValueChanged<String> onChanged;

  /// [CupertinoTextField.onEditingComplete]
  /// or
  /// [TextField.onEditingComplete]
  final VoidCallback onEditingComplete;

  /// [CupertinoTextField.onSubmitted]
  /// or
  /// [TextField.onSubmitted]
  final ValueChanged<String> onSubmitted;

  /// [CupertinoTextField.inputFormatters]
  /// or
  /// [TextField.inputFormatters]
  final List<TextInputFormatter> inputFormatters;

  /// [CupertinoTextField.enabled]
  /// or
  /// [TextField.enabled]
  final bool enabled;

  /// [CupertinoTextField.cursorWidth]
  /// or
  /// [TextField.cursorWidth]
  final double cursorWidth;

  /// [CupertinoTextField.cursorRadius]
  /// or
  /// [TextField.cursorRadius]
  final Radius cursorRadius;

  /// [CupertinoTextField.cursorColor]
  /// or
  /// [TextField.cursorColor]
  final Color cursorColor;

  /// [CupertinoTextField.keyboardAppearance]
  /// or
  /// [TextField.keyboardAppearance]
  final Brightness keyboardAppearance;

  /// [CupertinoTextField.scrollPadding]
  /// or
  /// [TextField.scrollPadding]
  final EdgeInsets scrollPadding;

  /// [CupertinoTextField.dragStartBehavior]
  /// or
  /// [TextField.dragStartBehavior]
  final DragStartBehavior dragStartBehavior;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoTextField.cupertinoDecoration]
  final BoxDecoration cupertinoDecoration;

  /// [CupertinoTextField.padding]
  final EdgeInsetsGeometry padding;

  /// [CupertinoTextField.placeholder]
  final String placeholder;

  /// [CupertinoTextField.placeholderStyle]
  final TextStyle placeholderStyle;

  /// [CupertinoTextField.prefix]
  final Widget prefix;

  /// [CupertinoTextField.prefixMode]
  final OverlayVisibilityMode prefixMode;

  /// [CupertinoTextField.suffix]
  final Widget suffix;

  /// [CupertinoTextField.suffixMode]
  final OverlayVisibilityMode suffixMode;

  /// [CupertinoTextField.clearButtonMode]
  final OverlayVisibilityMode clearButtonMode;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [TextField.materialDecoration]
  final InputDecoration materialDecoration;

  /// [TextField.textDirection]
  final TextDirection textDirection;

  /// [TextField.onTap]
  final GestureTapCallback onTap;

  /// [TextField.buildCounter]
  final InputCounterWidgetBuilder buildCounter;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoTextField(
      key: valueFromCupertino('key', key),
      controller: valueFromCupertino('controller', controller),
      focusNode: valueFromCupertino('focusNode', focusNode),
      keyboardType: valueFromCupertino('keyboardType', keyboardType),
      textInputAction: valueFromCupertino('textInputAction', textInputAction),
      textCapitalization: valueFromCupertino(
        'textCapitalization',
        textCapitalization,
      ),
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
      maxLengthEnforced: valueFromCupertino(
        'maxLengthEnforced',
        maxLengthEnforced,
      ),
      onChanged: valueFromCupertino('onChanged', onChanged),
      onEditingComplete: valueFromCupertino(
        'onEditingComplete',
        onEditingComplete,
      ),
      onSubmitted: valueFromCupertino('onSubmitted', onSubmitted),
      inputFormatters: valueFromCupertino('inputFormatters', inputFormatters),
      enabled: valueFromCupertino('enabled', enabled),
      cursorWidth: valueFromCupertino('cursorWidth', cursorWidth),
      cursorRadius: valueFromCupertino('cursorRadius', cursorRadius),
      cursorColor: valueFromCupertino('cursorColor', cursorColor),
      keyboardAppearance: valueFromCupertino(
        'keyboardAppearance',
        keyboardAppearance,
      ),
      scrollPadding: valueFromCupertino('scrollPadding', scrollPadding),
      dragStartBehavior: valueFromCupertino(
        'dragStartBehavior',
        dragStartBehavior,
      ),
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
      textCapitalization: valueFromMaterial(
        'textCapitalization',
        textCapitalization,
      ),
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
      maxLengthEnforced: valueFromMaterial(
        'maxLengthEnforced',
        maxLengthEnforced,
      ),
      onChanged: valueFromMaterial('onChanged', onChanged),
      onEditingComplete: valueFromMaterial(
        'onEditingComplete',
        onEditingComplete,
      ),
      onSubmitted: valueFromMaterial('onSubmitted', onSubmitted),
      inputFormatters: valueFromMaterial('inputFormatters', inputFormatters),
      enabled: valueFromMaterial('enabled', enabled),
      cursorWidth: valueFromMaterial('cursorWidth', cursorWidth),
      cursorRadius: valueFromMaterial('cursorRadius', cursorRadius),
      cursorColor: valueFromMaterial('cursorColor', cursorColor),
      keyboardAppearance: valueFromMaterial(
        'keyboardAppearance',
        keyboardAppearance,
      ),
      scrollPadding: valueFromMaterial('scrollPadding', scrollPadding),
      dragStartBehavior: valueFromMaterial(
        'dragStartBehavior',
        dragStartBehavior,
      ),
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

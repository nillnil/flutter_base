import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoDynamicColor, CupertinoTextField, OverlayVisibilityMode;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart' hide SmartDashesType, SmartQuotesType;
import 'package:flutter/rendering.dart' show MouseCursor;
import 'package:flutter/services.dart' show MaxLengthEnforcement, TextInputFormatter, SmartDashesType, SmartQuotesType;

import '../base_param.dart';
import '../base_stateless_widget.dart';

// BaseTextField
/// use CupertinoTextField by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use TextField on cuperitno.
/// use TextField by material
/// *** use material = { forceUseCupertino: true } force use CupertinoTextField on material.
///
/// CupertinoTextField: 2021.04.03
/// TextField: 2021.04.03
/// modify 2021.06.25 by flutter 2.2.2
class BaseTextField extends BaseStatelessWidget {
  const BaseTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.readOnly = false,
    this.showCursor,
    this.toolbarOptions,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius = const Radius.circular(2.0),
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.restorationId,
    this.maxLengthEnforcement,
    this.onTap,
    // cupertino
    this.cupertinoDecoration = _kDefaultRoundedBorderDecoration,
    this.padding = const EdgeInsets.all(6.0),
    this.placeholder,
    this.placeholderStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      color: CupertinoColors.placeholderText,
    ),
    this.prefix,
    this.prefixMode = OverlayVisibilityMode.always,
    this.suffix,
    this.suffixMode = OverlayVisibilityMode.always,
    this.clearButtonMode = OverlayVisibilityMode.never,
    // material
    this.materialDecoration = const InputDecoration(),
    this.textDirection,
    this.buildCounter,
    this.mouseCursor,
    this.selectionControls,
    this.onAppPrivateCommand,
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  /// *** general properties start ***

  /// [CupertinoTextField.controller]
  /// or
  /// [TextField.controller]
  final TextEditingController? controller;

  /// [CupertinoTextField.focusNode]
  /// or
  /// [TextField.focusNode]
  final FocusNode? focusNode;

  /// [CupertinoTextField.keyboardType]
  /// or
  /// [TextField.keyboardType]
  final TextInputType? keyboardType;

  /// [CupertinoTextField.textInputAction]
  /// or
  /// [TextField.textInputAction]
  final TextInputAction? textInputAction;

  /// [CupertinoTextField.textCapitalization]
  /// or
  /// [TextField.textCapitalization]
  final TextCapitalization textCapitalization;

  /// [CupertinoTextField.style]
  /// or
  /// [TextField.style]
  final TextStyle? style;

  /// [CupertinoTextField.strutStyle]
  /// or
  /// [TextField.strutStyle]
  final StrutStyle? strutStyle;

  /// [CupertinoTextField.textAlign]
  /// or
  /// [TextField.textAlign]
  final TextAlign textAlign;

  /// [CupertinoTextField.toolbarOptions]
  /// or
  /// [TextField.toolbarOptions]
  final ToolbarOptions? toolbarOptions;

  /// [CupertinoTextField.textAlignVertical]
  /// or
  /// [TextField.textAlignVertical]
  final TextAlignVertical? textAlignVertical;

  /// [CupertinoTextField.readOnly]
  /// or
  /// [TextField.readOnly]
  final bool readOnly;

  /// [CupertinoTextField.showCursor]
  /// or
  /// [TextField.showCursor]
  final bool? showCursor;

  /// [CupertinoTextField.autofocus]
  /// or
  /// [TextField.autofocus]
  final bool autofocus;

  /// [CupertinoTextField.obscureText]
  /// or
  /// [TextField.obscureText]
  final bool obscureText;

  /// [CupertinoTextField.autocorrect]
  /// or
  /// [TextField.autocorrect]
  final bool autocorrect;

  /// [CupertinoTextField.smartDashesType]
  /// or
  /// [TextField.smartDashesType]
  final SmartDashesType? smartDashesType;

  /// [CupertinoTextField.smartQuotesType]
  /// or
  /// [TextField.smartQuotesType]
  final SmartQuotesType? smartQuotesType;

  /// [CupertinoTextField.enableSuggestions]
  /// or
  /// [TextField.enableSuggestions]
  final bool enableSuggestions;

  /// [CupertinoTextField.maxLines]
  /// or
  /// [TextField.maxLines]
  final int maxLines;

  /// [CupertinoTextField.minLines]
  /// or
  /// [TextField.minLines]
  final int? minLines;

  /// [CupertinoTextField.expands]
  /// or
  /// [TextField.expands]
  final bool expands;

  /// [CupertinoTextField.maxLength]
  /// or
  /// [TextField.maxLength]
  final int? maxLength;

  /// [CupertinoTextField.maxLengthEnforcement]
  /// or
  /// [TextField.maxLengthEnforcement]
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// [CupertinoTextField.onChanged]
  /// or
  /// [TextField.onChanged]
  final ValueChanged<String>? onChanged;

  /// [CupertinoTextField.onEditingComplete]
  /// or
  /// [TextField.onEditingComplete]
  final VoidCallback? onEditingComplete;

  /// [CupertinoTextField.onSubmitted]
  /// or
  /// [TextField.onSubmitted]
  final ValueChanged<String>? onSubmitted;

  /// [CupertinoTextField.inputFormatters]
  /// or
  /// [TextField.inputFormatters]
  final List<TextInputFormatter>? inputFormatters;

  /// [CupertinoTextField.enabled]
  /// or
  /// [TextField.enabled]
  final bool? enabled;

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
  final Color? cursorColor;

  /// [CupertinoTextField.keyboardAppearance]
  /// or
  /// [TextField.keyboardAppearance]
  final Brightness? keyboardAppearance;

  /// [CupertinoTextField.scrollPadding]
  /// or
  /// [TextField.scrollPadding]
  final EdgeInsets scrollPadding;

  /// [CupertinoTextField.dragStartBehavior]
  /// or
  /// [TextField.dragStartBehavior]
  final DragStartBehavior dragStartBehavior;

  /// [CupertinoTextField.enableInteractiveSelection]
  /// or
  /// [TextField.enableInteractiveSelection]
  final bool enableInteractiveSelection;

  /// [CupertinoTextField.selectionControls]
  /// or
  /// [TextField.selectionControls]
  final TextSelectionControls? selectionControls;

  /// [CupertinoTextField.scrollController]
  /// or
  /// [TextField.scrollController]
  final ScrollController? scrollController;

  /// [CupertinoTextField.scrollPhysics]
  /// or
  /// [TextField.scrollPhysics]
  final ScrollPhysics? scrollPhysics;

  /// [CupertinoTextField.obscuringCharacter]
  /// or
  /// [TextField.obscuringCharacter]
  final String obscuringCharacter;

  /// [CupertinoTextField.selectionHeightStyle]
  /// or
  /// [TextField.selectionHeightStyle]
  final ui.BoxHeightStyle selectionHeightStyle;

  /// [CupertinoTextField.selectionWidthStyle]
  /// or
  /// [TextField.selectionWidthStyle]
  final ui.BoxWidthStyle selectionWidthStyle;

  /// [CupertinoTextField.cursorHeight]
  /// or
  /// [TextField.cursorHeight]
  final double? cursorHeight;

  /// [CupertinoTextField.autofillHints]
  /// or
  /// [TextField.autofillHints]
  final Iterable<String>? autofillHints;

  /// [CupertinoTextField.restorationId]
  /// or
  /// [TextField.restorationId]
  final String? restorationId;

  /// [CupertinoTextField.onTap]
  /// or
  /// [TextField.onTap]
  final GestureTapCallback? onTap;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoTextField.cupertinoDecoration]
  final BoxDecoration cupertinoDecoration;

  /// [CupertinoTextField.padding]
  final EdgeInsetsGeometry padding;

  /// [CupertinoTextField.placeholder]
  final String? placeholder;

  /// [CupertinoTextField.placeholderStyle]
  final TextStyle placeholderStyle;

  /// [CupertinoTextField.prefix]
  final Widget? prefix;

  /// [CupertinoTextField.prefixMode]
  final OverlayVisibilityMode prefixMode;

  /// [CupertinoTextField.suffix]
  final Widget? suffix;

  /// [CupertinoTextField.suffixMode]
  final OverlayVisibilityMode suffixMode;

  /// [CupertinoTextField.clearButtonMode]
  final OverlayVisibilityMode clearButtonMode;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [TextField.materialDecoration]
  final InputDecoration materialDecoration;

  /// [TextField.textDirection]
  final TextDirection? textDirection;

  /// [TextField.buildCounter]
  final InputCounterWidgetBuilder? buildCounter;

  /// [TextField.onAppPrivateCommand]
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// [TextField.buildCmouseCursorounter]
  final MouseCursor? mouseCursor;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoTextField(
      controller: valueOf('controller', controller),
      focusNode: valueOf('focusNode', focusNode),
      keyboardType: valueOf('keyboardType', keyboardType),
      textInputAction: valueOf('textInputAction', textInputAction),
      textCapitalization: valueOf('textCapitalization', textCapitalization),
      style: valueOf('style', style),
      strutStyle: valueOf('strutStyle', strutStyle),
      textAlign: valueOf('textAlign', textAlign),
      textAlignVertical: valueOf('textAlignVertical', textAlignVertical),
      readOnly: valueOf('readOnly', readOnly),
      toolbarOptions: valueOf('toolbarOptions', toolbarOptions),
      showCursor: valueOf('showCursor', showCursor),
      autofocus: valueOf('autofocus', autofocus),
      obscuringCharacter: valueOf('obscuringCharacter', obscuringCharacter),
      obscureText: valueOf('obscureText', obscureText),
      autocorrect: valueOf('autocorrect', autocorrect),
      smartDashesType: valueOf('smartDashesType', smartDashesType),
      smartQuotesType: valueOf('smartQuotesType', smartQuotesType),
      enableSuggestions: valueOf('enableSuggestions', enableSuggestions),
      maxLines: valueOf('maxLines', maxLines),
      minLines: valueOf('minLines', minLines),
      expands: valueOf('expands', expands),
      maxLength: valueOf('maxLength', maxLength),
      maxLengthEnforcement: valueOf('maxLengthEnforcement', maxLengthEnforcement),
      onChanged: valueOf('onChanged', onChanged),
      onEditingComplete: valueOf('onEditingComplete', onEditingComplete),
      onSubmitted: valueOf('onSubmitted', onSubmitted),
      inputFormatters: valueOf('inputFormatters', inputFormatters),
      enabled: valueOf('enabled', enabled),
      cursorWidth: valueOf('cursorWidth', cursorWidth),
      cursorHeight: valueOf('cursorHeight', cursorHeight),
      cursorRadius: valueOf('cursorRadius', cursorRadius),
      cursorColor: valueOf('cursorColor', cursorColor),
      selectionHeightStyle: valueOf('selectionHeightStyle', selectionHeightStyle),
      selectionWidthStyle: valueOf('selectionWidthStyle', selectionWidthStyle),
      keyboardAppearance: valueOf('keyboardAppearance', keyboardAppearance),
      scrollPadding: valueOf('scrollPadding', scrollPadding),
      dragStartBehavior: valueOf('dragStartBehavior', dragStartBehavior),
      enableInteractiveSelection: valueOf('enableInteractiveSelection', enableInteractiveSelection),
      selectionControls: valueOf('selectionControls', selectionControls),
      onTap: valueOf('onTap', onTap),
      scrollController: valueOf('scrollController', scrollController),
      scrollPhysics: valueOf('scrollPhysics', scrollPhysics),
      autofillHints: valueOf('autofillHints', autofillHints),
      restorationId: valueOf('restorationId', restorationId),
      // cupertino
      decoration: valueOf('cupertinoDecoration', cupertinoDecoration),
      padding: valueOf('padding', padding),
      placeholder: valueOf('placeholder', placeholder),
      placeholderStyle: valueOf('placeholderStyle', placeholderStyle),
      prefix: valueOf('prefix', prefix),
      prefixMode: valueOf('prefixMode', prefixMode),
      suffix: valueOf('suffix', suffix),
      suffixMode: valueOf('suffixMode', suffixMode),
      clearButtonMode: valueOf('clearButtonMode', clearButtonMode),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return TextField(
      controller: valueOf('controller', controller),
      focusNode: valueOf('focusNode', focusNode),
      keyboardType: valueOf('keyboardType', keyboardType),
      textInputAction: valueOf('textInputAction', textInputAction),
      textCapitalization: valueOf('textCapitalization', textCapitalization),
      style: valueOf('style', style),
      strutStyle: valueOf('strutStyle', strutStyle),
      textAlign: valueOf('textAlign', textAlign),
      textAlignVertical: valueOf('textAlignVertical', textAlignVertical),
      readOnly: valueOf('readOnly', readOnly),
      toolbarOptions: valueOf('toolbarOptions', toolbarOptions),
      showCursor: valueOf('showCursor', showCursor),
      autofocus: valueOf('autofocus', autofocus),
      obscuringCharacter: valueOf('obscuringCharacter', obscuringCharacter),
      obscureText: valueOf('obscureText', obscureText),
      autocorrect: valueOf('autocorrect', autocorrect),
      smartDashesType: valueOf('smartDashesType', smartDashesType),
      smartQuotesType: valueOf('smartQuotesType', smartQuotesType),
      enableSuggestions: valueOf('enableSuggestions', enableSuggestions),
      maxLines: valueOf('maxLines', maxLines),
      minLines: valueOf('minLines', minLines),
      expands: valueOf('expands', expands),
      maxLength: valueOf('maxLength', maxLength),
      maxLengthEnforcement: valueOf('maxLengthEnforcement', maxLengthEnforcement),
      onChanged: valueOf('onChanged', onChanged),
      onEditingComplete: valueOf('onEditingComplete', onEditingComplete),
      onSubmitted: valueOf('onSubmitted', onSubmitted),
      onAppPrivateCommand: valueOf('onAppPrivateCommand', onAppPrivateCommand),
      inputFormatters: valueOf('inputFormatters', inputFormatters),
      enabled: valueOf('enabled', enabled),
      cursorWidth: valueOf('cursorWidth', cursorWidth),
      cursorHeight: valueOf('cursorHeight', cursorHeight),
      cursorRadius: valueOf('cursorRadius', cursorRadius),
      cursorColor: valueOf('cursorColor', cursorColor),
      selectionHeightStyle: valueOf('selectionHeightStyle', selectionHeightStyle),
      selectionWidthStyle: valueOf('selectionWidthStyle', selectionWidthStyle),
      keyboardAppearance: valueOf('keyboardAppearance', keyboardAppearance),
      scrollPadding: valueOf('scrollPadding', scrollPadding),
      dragStartBehavior: valueOf('dragStartBehavior', dragStartBehavior),
      enableInteractiveSelection: valueOf('enableInteractiveSelection', enableInteractiveSelection),
      selectionControls: valueOf('selectionControls', selectionControls),
      mouseCursor: valueOf('mouseCursor', mouseCursor),
      scrollController: valueOf('scrollController', scrollController),
      scrollPhysics: valueOf('scrollPhysics', scrollPhysics),
      autofillHints: valueOf('autofillHints', autofillHints),
      restorationId: valueOf('scrollPhysics', restorationId),
      // material
      decoration: valueOf('materialDecoration', materialDecoration),
      textDirection: valueOf('textDirection', textDirection),
      onTap: valueOf('onTap', onTap),
      buildCounter: valueOf('buildCounter', buildCounter),
    );
  }
}

// Value inspected from Xcode 11 & iOS 13.0 Simulator.
const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  style: BorderStyle.solid,
  width: 0.0,
);

const Border _kDefaultRoundedBorder = Border(
  top: _kDefaultRoundedBorderSide,
  bottom: _kDefaultRoundedBorderSide,
  left: _kDefaultRoundedBorderSide,
  right: _kDefaultRoundedBorderSide,
);

const BoxDecoration _kDefaultRoundedBorderDecoration = BoxDecoration(
  color: CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.white,
    darkColor: CupertinoColors.black,
  ),
  border: _kDefaultRoundedBorder,
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);

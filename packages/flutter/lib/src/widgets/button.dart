// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show Color;

import 'basic.dart';
import 'constants.dart';
import 'container.dart';
import 'framework.dart';
import 'gesture_detector.dart';
import 'text.dart';

/// An interface defining the base attributes for a button.
///
/// This is used in both [CupertinoButton]s and [MaterialButton]s. Additionally,
/// this can be used to create your own completely custom buttons.
abstract class ButtonAttributes {
  // This class is intended to be used as an interface, and should not be
  // extended directly; this constructor prevents instantiation and extension.
  // ignore: unused_element
  factory ButtonAttributes._() => null;

  /// Called when the user taps the button.
  ///
  /// If [onPressed] is set, then this callback will be called when the user
  /// taps on button. If [onPressed] is null, then the button will be disabled.
  VoidCallback get onPressed;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget child;
}

/// A basic button that does not follow any specific platform styling.
///
/// See also:
///
///  * [CupertinoButton]
///  * [MaterialButton]
class Button extends StatefulWidget implements ButtonAttributes {
  /// Creates a basic button.
  const Button({
    Key key,
    this.padding,
    this.color,
    this.textStyle,
    this.borderRadius,
    this.onPressed,
    this.child,
  }) : super(key: key);

  /// The amount of space to surround the child inside the bounds of the button.
  ///
  /// Defaults to 8.0 pixels.
  final EdgeInsetsGeometry padding;

  /// The background color of the button.
  final Color color;

  /// The text style of the button.
  final TextStyle textStyle;

  /// The radius of the button's corners.
  ///
  /// Defaults to corners of 0 pixels.
  final BorderRadius borderRadius;

  @override
  final VoidCallback onPressed;

  @override
  final Widget child;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool get _enabled => widget.onPressed != null;
  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      setState(() {
        _buttonHeldDown = true;
      });
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      setState(() {
        _buttonHeldDown = false;
      });
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      setState(() {
        _buttonHeldDown = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = widget.color ?? const Color(0xFF666666);
    final Color pressedColor = resolvedColor.withOpacity(0.6);
    const Color disabledColor = Color(0x66666666);
    final TextStyle resolvedTextStyle = widget.textStyle ?? const TextStyle(fontSize: 18, color: Color(0xFFFFFFFF));
    return GestureDetector(
      onTapDown: _enabled ? _handleTapDown : null,
      onTapUp: _enabled ? _handleTapUp : null,
      onTapCancel: _enabled ? _handleTapCancel : null,
      onTap: widget.onPressed,
      child: Semantics(
        button: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: kMinInteractiveDimension,
            minHeight: kMinInteractiveDimension,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              color: _enabled ? (_buttonHeldDown ? pressedColor : resolvedColor) : disabledColor,
            ),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(8.0),
              child: Center(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: DefaultTextStyle(
                  style: resolvedTextStyle,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


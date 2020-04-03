// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';

/// Defines the visual properties of the widget displayed with [showTimePicker].
///
/// Descendant widgets obtain the current [TimePickerThemeData] object using
/// `TimePickerTheme.of(context)`. Instances of [TimePickerThemeData]
/// can be customized with [TimePickerThemeData.copyWith].
///
/// Typically a [TimePickerThemeData] is specified as part of the overall
/// [Theme] with [ThemeData.timePickerTheme].
///
/// All [TimePickerThemeData] properties are `null` by default. When null,
/// [showTimePicker] will provide its own defaults.
///
/// See also:
///
///  * [ThemeData], which describes the overall theme information for the
///    application.
class TimePickerThemeData with Diagnosticable {

  /// Creates a theme that can be used for [TimePickerTheme] or
  /// [ThemeData.timePickerTheme].
  const TimePickerThemeData({
    this.backgroundColor,
    this.headerColor,
    this.dialHandColor,
    this.dialBackgroundColor,
    this.activeDayPeriodColor,
    this.hourMinuteTextStyle,
    this.dayPeriodTextStyle,
    this.helpTextStyle,
    this.shape,
    this.hourMinuteShape,
    this.dayPeriodShape,
    this.inputDecorationTheme,
  });

  /// The background color of a time picker.
  ///
  /// If this is null, the time picker defaults to [ColorScheme.background].
  final Color backgroundColor;

  /// The color used in the header of a time picker.
  ///
  /// This determines the active color of the header segments that represent
  /// hours and minutes.
  ///
  /// If this is null, the time picker defaults to [ColorScheme.primary].
  final Color headerColor;

  /// The color of the time picker dial's hand.
  ///
  /// If this is null, the time picker defaults to [ColorScheme.primary].
  final Color dialHandColor;

  /// The background color of the time picker dial.
  ///
  /// If this is null, the time picker defaults to [ColorScheme.primary].
  final Color dialBackgroundColor;

  /// The background color of the active day period in the time picker.
  ///
  /// If this is null, the time picker defaults to [ColorScheme.surface].
  final Color activeDayPeriodColor;

  /// Used to configure the [TextStyle]s for the hour/minute controls.
  ///
  /// If this is null, the time picker defaults to
  /// `Theme.of(context).textTheme.headline3`.
  final TextStyle hourMinuteTextStyle;

  /// Used to configure the [TextStyle]s for the day period control.
  ///
  /// If this is null, the time picker defaults to
  /// `Theme.of(context).primaryTextTheme.subtitle1`.
  final TextStyle dayPeriodTextStyle;

  /// Used to configure the [TextStyle]s for the helper text in the header.
  ///
  /// If this is null, the time picker defaults to
  /// `Theme.of(context).textTheme.overline`.
  final TextStyle helpTextStyle;

  /// The shape of the [Dialog] that the time picker is presented in.
  ///
  /// If this is null, the time picker defaults to
  /// `RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))`.
  final ShapeBorder shape;

  /// The shape of the hour and minute controls that the time picker uses.
  ///
  /// If this is null, the time picker defaults to
  /// `RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))`.
  final ShapeBorder hourMinuteShape;

  /// The shape of the day period that the time picker uses.
  ///
  /// If this is null, the time picker defaults to:
  /// ```
  /// RoundedRectangleBorder(
  ///   borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ///   side: BorderSide(color: Theme.of(context).dividerColor),
  /// )
  /// ```
  final ShapeBorder dayPeriodShape;

  /// The input decoration theme for the [TextField]s in the time picker.
  /// 
  /// If this is null, the time picker provides its own defaults.
  final InputDecorationTheme inputDecorationTheme;

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  TimePickerThemeData copyWith({
    Color backgroundColor,
    Color headerColor,
    Color dialHandColor,
    Color dialBackgroundColor,
    Color activeDayPeriodColor,
    TextStyle hourMinuteTextStyle,
    TextStyle dayPeriodTextStyle,
    TextStyle helpTextStyle,
    ShapeBorder shape,
    ShapeBorder hourMinuteShape,
    ShapeBorder dayPeriodShape,
    InputDecorationTheme inputDecorationTheme,
  }) {
    return TimePickerThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerColor: headerColor ?? this.headerColor,
      dialHandColor: dialHandColor ?? this.dialHandColor,
      dialBackgroundColor: dialBackgroundColor ?? this.dialBackgroundColor,
      activeDayPeriodColor: activeDayPeriodColor ?? this.activeDayPeriodColor,
      hourMinuteTextStyle: hourMinuteTextStyle ?? this.hourMinuteTextStyle,
      dayPeriodTextStyle: dayPeriodTextStyle ?? this.dayPeriodTextStyle,
      helpTextStyle: helpTextStyle ?? this.helpTextStyle,
      shape: shape ?? this.shape,
      hourMinuteShape: hourMinuteShape ?? this.hourMinuteShape,
      dayPeriodShape: dayPeriodShape ?? this.dayPeriodShape,
      inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
    );
  }

  /// Linearly interpolate between two time picker themes.
  ///
  /// The argument `t` must not be null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static TimePickerThemeData lerp(TimePickerThemeData a, TimePickerThemeData b, double t) {
    assert(t != null);
    return TimePickerThemeData(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      headerColor: Color.lerp(a?.headerColor, b?.headerColor, t),
      dialHandColor: Color.lerp(a?.dialHandColor, b?.dialHandColor, t),
      dialBackgroundColor: Color.lerp(a?.dialBackgroundColor, b?.dialBackgroundColor, t),
      activeDayPeriodColor: Color.lerp(a?.activeDayPeriodColor, b?.activeDayPeriodColor, t),
      hourMinuteTextStyle: TextStyle.lerp(a?.hourMinuteTextStyle, b?.hourMinuteTextStyle, t),
      dayPeriodTextStyle: TextStyle.lerp(a?.dayPeriodTextStyle, b?.dayPeriodTextStyle, t),
      helpTextStyle: TextStyle.lerp(a?.helpTextStyle, b?.helpTextStyle, t),
      shape: ShapeBorder.lerp(a?.shape, b?.shape, t),
      hourMinuteShape: ShapeBorder.lerp(a?.hourMinuteShape, b?.hourMinuteShape, t),
      dayPeriodShape: ShapeBorder.lerp(a?.dayPeriodShape, b?.dayPeriodShape, t),
      inputDecorationTheme: t < 0.5 ? a.inputDecorationTheme : b.inputDecorationTheme,
    );
  }

  @override
  int get hashCode {
    return hashValues(
      backgroundColor,
      headerColor,
      dialHandColor,
      dialBackgroundColor,
      activeDayPeriodColor,
      hourMinuteTextStyle,
      dayPeriodTextStyle,
      helpTextStyle,
      shape,
      hourMinuteShape,
      dayPeriodShape,
      inputDecorationTheme,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other))
      return true;
    if (other.runtimeType != runtimeType)
      return false;
    return other is TimePickerThemeData
        && other.backgroundColor == backgroundColor
        && other.headerColor == headerColor
        && other.dialHandColor == dialHandColor
        && other.dialBackgroundColor == dialBackgroundColor
        && other.activeDayPeriodColor == activeDayPeriodColor
        && other.hourMinuteTextStyle == hourMinuteTextStyle
        && other.dayPeriodTextStyle == dayPeriodTextStyle
        && other.helpTextStyle == helpTextStyle
        && other.shape == shape
        && other.hourMinuteShape == hourMinuteShape
        && other.dayPeriodShape == dayPeriodShape
        && other.inputDecorationTheme == inputDecorationTheme;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor, defaultValue: null));
    properties.add(ColorProperty('headerColor', headerColor, defaultValue: null));
    properties.add(ColorProperty('dialHandColor', dialHandColor, defaultValue: null));
    properties.add(ColorProperty('dialBackgroundColor', dialBackgroundColor, defaultValue: null));
    properties.add(ColorProperty('activeDayPeriodColor', activeDayPeriodColor, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('hourMinuteTextStyle', hourMinuteTextStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('dayPeriodTextStyle', dayPeriodTextStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('helpTextStyle', helpTextStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('hourMinuteShape', hourMinuteShape, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('dayPeriodShape', dayPeriodShape, defaultValue: null));
    properties.add(DiagnosticsProperty<InputDecorationTheme>('inputDecorationTheme', inputDecorationTheme, defaultValue: null));
  }
}

/// An inherited widget that defines the configuration for time pickers
/// displayed in this widget's subtree.
///
/// Values specified here are used for time picker properties that are not
/// given an explicit non-null value.
class TimePickerTheme extends InheritedTheme {
  /// Creates a time picker theme that controls the configurations for
  /// time pickers displayed in its widget subtree.
  const TimePickerTheme({
    Key key,
    this.data,
    Widget child,
  }) : super(key: key, child: child);

  /// The properties for descendant time picker widgets.
  final TimePickerThemeData data;

  /// The closest instance of this class's [data] value that encloses the given
  /// context.
  ///
  /// If there is no ancestor, it returns [ThemeData.timePickerTheme].
  /// Applications can assume that the returned value will not be null.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// TimePickerThemeData theme = TimePickerTheme.of(context);
  /// ```
  static TimePickerThemeData of(BuildContext context) {
    final TimePickerTheme timePickerTheme = context.dependOnInheritedWidgetOfExactType<TimePickerTheme>();
    return timePickerTheme?.data ?? Theme.of(context).timePickerTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final TimePickerTheme ancestorTheme = context.findAncestorWidgetOfExactType<TimePickerTheme>();
    return identical(this, ancestorTheme) ? child : TimePickerTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(TimePickerTheme oldWidget) => data != oldWidget.data;
}

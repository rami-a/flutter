// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'text_theme.dart';
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
class TimePickerThemeData extends Diagnosticable {

  /// Creates a theme that can be used for [TimePickerTheme] or
  /// [ThemeData.timePickerTheme].
  const TimePickerThemeData({
    this.backgroundColor,
    this.headerColor,
    this.dialHandColor,
    this.dialBackgroundColor,
    this.activeDayPeriodColor,
    this.headerTextTheme,
    this.shape,
    this.hourMinuteShape,
    this.dayPeriodShape,
    this.use2018Style,
  });

  /// The background color of a time picker.
  ///
  /// If this is null, the time picker defaults to [Dialog]'s default.
  final Color backgroundColor;

  /// The color used in the header of a time picker.
  ///
  /// If [use2018Style] is true, this determines the active color of the header
  /// segments that represent hours and minutes. If [use2018Style] is false,
  /// this determines the background color of the header.
  ///
  /// If this is null and [use2018Style] is true, the time picker defaults to
  /// [ColorScheme.primary].
  ///
  /// If this is null and [use2018Style] is false, the time picker defaults to
  /// [ThemeData.primaryColor] in light theme and [ThemeData.backgroundColor] in
  /// dark theme.
  final Color headerColor;

  /// The color of the time picker dial's hand.
  ///
  /// If this is null and [use2018Style] is true, the time picker defaults to
  /// [ColorScheme.primary].
  ///
  /// If this is null and [use2018Style] is false, the time picker defaults to
  /// [ThemeData.accentColor].
  final Color dialHandColor;

  /// The background color of the time picker dial.
  ///
  /// If this is null and [use2018Style] is true, the time picker defaults to
  /// [ColorScheme.primary].
  ///
  /// If this is null and [use2018Style] is false, the time picker defaults to
  /// `Colors.grey[200]` in light theme and [ThemeData.backgroundColor] in
  /// dark theme.
  final Color dialBackgroundColor;

  /// The background color of the active day period in the time picker.
  ///
  /// This is only used when [use2018Style] is true.
  ///
  /// If this is null, the time picker defaults to [ColorScheme.surface].
  final Color activeDayPeriodColor;

  /// Used to configure the [TextStyle]s for the header of the time picker.
  ///
  /// If this is null and [use2018Style] is true, the time picker defaults to
  /// values from [ThemeData.textTheme].
  ///
  /// If this is null and [use2018Style] is false, the time picker defaults to
  /// values from [ThemeData.primaryTextTheme].
  final TextTheme headerTextTheme;

  /// The shape of the [Dialog] that the time picker is presented in.
  ///
  /// If [use2018Style] is true, this also adjusts the shape of the header
  /// segments that represent hours, minutes, and time of day.
  ///
  /// If this is null and [use2018Style] is true, the time picker defaults to
  /// `RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))`.
  ///
  /// If this is null and [use2018Style] is false, the time picker defaults to
  /// [Dialog]'s default shape.
  final ShapeBorder shape;

  /// The shape of the hour and minute controls that the time picker uses.
  ///
  /// This is only used when [use2018Style] is true.
  ///
  /// If this is null, the time picker defaults to
  /// `RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))`.
  final ShapeBorder hourMinuteShape;

  /// The shape of the day period that the time picker uses.
  ///
  /// This is only used when [use2018Style] is true.
  ///
  /// If this is null, the time picker defaults to:
  /// ```
  /// RoundedRectangleBorder(
  ///   borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ///   side: BorderSide(color: Theme.of(context).dividerColor),
  /// )
  /// ```
  final ShapeBorder dayPeriodShape;

  /// Whether the time picker uses the updated 2018 Material Design style.
  ///
  /// If this is null, the time picker defaults to false.
  final bool use2018Style;

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  TimePickerThemeData copyWith({
    Color backgroundColor,
    Color headerColor,
    Color dialHandColor,
    Color dialBackgroundColor,
    Color activeDayPeriodColor,
    TextTheme headerTextTheme,
    ShapeBorder shape,
    ShapeBorder hourMinuteShape,
    ShapeBorder dayPeriodShape,
    bool use2018Style,
  }) {
    return TimePickerThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerColor: headerColor ?? this.headerColor,
      dialHandColor: dialHandColor ?? this.dialHandColor,
      dialBackgroundColor: dialBackgroundColor ?? this.dialBackgroundColor,
      activeDayPeriodColor: activeDayPeriodColor ?? this.activeDayPeriodColor,
      headerTextTheme: headerTextTheme ?? this.headerTextTheme,
      shape: shape ?? this.shape,
      hourMinuteShape: hourMinuteShape ?? this.hourMinuteShape,
      dayPeriodShape: dayPeriodShape ?? this.dayPeriodShape,
      use2018Style: use2018Style ?? this.use2018Style,
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
      headerTextTheme: TextTheme.lerp(a?.headerTextTheme, b?.headerTextTheme, t),
      shape: ShapeBorder.lerp(a?.shape, b?.shape, t),
      hourMinuteShape: ShapeBorder.lerp(a?.hourMinuteShape, b?.hourMinuteShape, t),
      dayPeriodShape: ShapeBorder.lerp(a?.dayPeriodShape, b?.dayPeriodShape, t),
      use2018Style: t < 0.5 ? a.use2018Style : b.use2018Style,
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
      headerTextTheme,
      shape,
      hourMinuteShape,
      dayPeriodShape,
      use2018Style,
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
        && other.headerTextTheme == headerTextTheme
        && other.shape == shape
        && other.hourMinuteShape == hourMinuteShape
        && other.dayPeriodShape == dayPeriodShape
        && other.use2018Style == use2018Style;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor, defaultValue: null));
    properties.add(ColorProperty('headerColor', headerColor, defaultValue: null));
    properties.add(ColorProperty('dialHandColor', dialHandColor, defaultValue: null));
    properties.add(ColorProperty('dialBackgroundColor', dialBackgroundColor, defaultValue: null));
    properties.add(ColorProperty('activeDayPeriodColor', activeDayPeriodColor, defaultValue: null));
    properties.add(DiagnosticsProperty<TextTheme>('headerTextTheme', headerTextTheme, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('hourMinuteShape', hourMinuteShape, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('dayPeriodShape', dayPeriodShape, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('use2018Style', use2018Style, defaultValue: null));
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

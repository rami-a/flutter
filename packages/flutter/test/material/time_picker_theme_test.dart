// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../rendering/mock_canvas.dart';

void main() {
  test('TimePickerThemeData copyWith, ==, hashCode basics', () {
    expect(const TimePickerThemeData(), const TimePickerThemeData().copyWith());
    expect(const TimePickerThemeData().hashCode, const TimePickerThemeData().copyWith().hashCode);
  });

  test('TimePickerThemeData null fields by default', () {
    const TimePickerThemeData timePickerTheme = TimePickerThemeData();
    expect(timePickerTheme.backgroundColor, null);
    expect(timePickerTheme.headerColor, null);
    expect(timePickerTheme.dialHandColor, null);
    expect(timePickerTheme.dialBackgroundColor, null);
    expect(timePickerTheme.hourMinuteTextStyle, null);
    expect(timePickerTheme.dayPeriodTextStyle, null);
    expect(timePickerTheme.helpTextStyle, null);
    expect(timePickerTheme.shape, null);
    expect(timePickerTheme.hourMinuteShape, null);
    expect(timePickerTheme.dayPeriodShape, null);
    expect(timePickerTheme.inputDecorationTheme, null);
  });

  testWidgets('Default TimePickerThemeData debugFillProperties', (WidgetTester tester) async {
    final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
    const TimePickerThemeData().debugFillProperties(builder);

    final List<String> description = builder.properties
        .where((DiagnosticsNode node) => !node.isFiltered(DiagnosticLevel.info))
        .map((DiagnosticsNode node) => node.toString())
        .toList();

    expect(description, <String>[]);
  });

  testWidgets('TimePickerThemeData implements debugFillProperties', (WidgetTester tester) async {
    final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
    const TimePickerThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      headerColor: Color(0xFFFFFFFF),
      dialHandColor: Color(0xFFFFFFFF),
      dialBackgroundColor: Color(0xFFFFFFFF),
      hourMinuteTextStyle: TextStyle(),
      dayPeriodTextStyle: TextStyle(),
      helpTextStyle: TextStyle(),
      shape: RoundedRectangleBorder(),
      hourMinuteShape: RoundedRectangleBorder(),
      dayPeriodShape: RoundedRectangleBorder(),
    ).debugFillProperties(builder);

    final List<String> description = builder.properties
        .where((DiagnosticsNode node) => !node.isFiltered(DiagnosticLevel.info))
        .map((DiagnosticsNode node) => node.toString())
        .toList();

    expect(description, <String>[
      'backgroundColor: Color(0xffffffff)',
      'headerColor: Color(0xffffffff)',
      'dialHandColor: Color(0xffffffff)',
      'dialBackgroundColor: Color(0xffffffff)',
      'hourMinuteTextStyle: TextStyle(<all styles inherited>)',
      'dayPeriodTextStyle: TextStyle(<all styles inherited>)',
      'helpTextStyle: TextStyle(<all styles inherited>)',
      'shape: RoundedRectangleBorder(BorderSide(Color(0xff000000), 0.0, BorderStyle.none), BorderRadius.zero)',
      'hourMinuteShape: RoundedRectangleBorder(BorderSide(Color(0xff000000), 0.0, BorderStyle.none), BorderRadius.zero)',
      'dayPeriodShape: RoundedRectangleBorder(BorderSide(Color(0xff000000), 0.0, BorderStyle.none), BorderRadius.zero)',
    ]);
  });

  testWidgets('Passing no TimePickerThemeData uses defaults', (WidgetTester tester) async {
    final ThemeData defaultTheme = ThemeData.fallback();
    await tester.pumpWidget(const _TimePickerLauncher());
    await tester.tap(find.text('X'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final Material dialogMaterial = _dialogMaterial(tester);
    expect(dialogMaterial.color, defaultTheme.colorScheme.surface);
    expect(dialogMaterial.shape, const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))));

    final RenderBox dial = tester.firstRenderObject<RenderBox>(find.byType(CustomPaint));
    expect(
      dial,
      paints
        ..circle(color: defaultTheme.colorScheme.onBackground.withOpacity(0.12)) // Dial background color.
        ..circle(color: Color(defaultTheme.colorScheme.primary.value)), // Dial hand color.
    );

    final RenderParagraph hourText = _textRenderParagraph(tester, '7');
    expect(
      hourText.text.style,
      Typography.material2014().englishLike.headline2
          .merge(Typography.material2014().black.headline2)
          .copyWith(color: defaultTheme.colorScheme.primary),
    );

    final RenderParagraph amText = _textRenderParagraph(tester, 'AM');
    expect(
      amText.text.style,
      Typography.material2014().englishLike.subtitle1
          .merge(Typography.material2014().black.subtitle1)
          .copyWith(color: defaultTheme.colorScheme.onBackground),
    );

    final RenderParagraph helperText = _textRenderParagraph(tester, 'SELECT TIME');
    expect(
      helperText.text.style,
      Typography.material2014().englishLike.overline
          .merge(Typography.material2014().black.overline),
    );

    final Material hourMaterial = _textMaterial(tester, '7');
    expect(hourMaterial.color, defaultTheme.colorScheme.primary.withOpacity(0.12));
    expect(hourMaterial.shape, const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))));

    final Material dayPeriodMaterial = _dayPeriodMaterial(tester);
    expect(
      dayPeriodMaterial.shape,
      RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        side: BorderSide(color: defaultTheme.dividerColor),
      ),
    );
  });


  testWidgets('Passing no TimePickerThemeData uses defaults - input mode', (WidgetTester tester) async {
    final ThemeData defaultTheme = ThemeData.fallback();
    await tester.pumpWidget(const _TimePickerLauncher(entryMode: TimePickerEntryMode.input));
    await tester.tap(find.text('X'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final InputDecoration hourDecoration = _textField(tester, '7').decoration;
    expect(hourDecoration.filled, true);
    expect(hourDecoration.fillColor, defaultTheme.colorScheme.onBackground.withOpacity(0.12));
    expect(hourDecoration.enabledBorder, const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)));
    expect(hourDecoration.errorBorder, OutlineInputBorder(borderSide: BorderSide(color: defaultTheme.colorScheme.error, width: 2)));
    expect(hourDecoration.focusedBorder, OutlineInputBorder(borderSide: BorderSide(color: defaultTheme.colorScheme.primary, width: 2)));
    expect(hourDecoration.focusedErrorBorder, OutlineInputBorder(borderSide: BorderSide(color: defaultTheme.colorScheme.error, width: 2)));
    expect(
      hourDecoration.hintStyle,
      Typography.material2014().englishLike.headline2
          .merge(defaultTheme.textTheme.headline2.copyWith(color: defaultTheme.colorScheme.onBackground.withOpacity(0.36))),
    );
  });

  testWidgets('Time picker uses values from TimePickerThemeData', (WidgetTester tester) async {
    final TimePickerThemeData timePickerTheme = _timePickerTheme();
    final ThemeData theme = ThemeData(timePickerTheme: timePickerTheme);
    await tester.pumpWidget(_TimePickerLauncher(themeData: theme,));
    await tester.tap(find.text('X'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final Material dialogMaterial = _dialogMaterial(tester);
    expect(dialogMaterial.color, timePickerTheme.backgroundColor);
    expect(dialogMaterial.shape, timePickerTheme.shape);

    final RenderBox dial = tester.firstRenderObject<RenderBox>(find.byType(CustomPaint));
    expect(
      dial,
      paints
        ..circle(color: Color(timePickerTheme.dialBackgroundColor.value)) // Dial background color.
        ..circle(color: Color(timePickerTheme.dialHandColor.value)), // Dial hand color.
    );

    final RenderParagraph hourText = _textRenderParagraph(tester, '7');
    expect(
      hourText.text.style,
      Typography.material2014().englishLike.bodyText2
          .merge(Typography.material2014().black.bodyText2)
          .merge(timePickerTheme.hourMinuteTextStyle)
          .copyWith(color: timePickerTheme.headerColor),
    );

    final RenderParagraph amText = _textRenderParagraph(tester, 'AM');
    expect(
      amText.text.style,
      Typography.material2014().englishLike.subtitle1
          .merge(Typography.material2014().black.subtitle1)
          .merge(timePickerTheme.dayPeriodTextStyle)
          .copyWith(color: theme.colorScheme.onBackground),
    );

    final RenderParagraph helperText = _textRenderParagraph(tester, 'SELECT TIME');
    expect(
      helperText.text.style,
      Typography.material2014().englishLike.bodyText2
          .merge(Typography.material2014().black.bodyText2)
          .merge(timePickerTheme.helpTextStyle),
    );

    final Material hourMaterial = _textMaterial(tester, '7');
    expect(hourMaterial.color, timePickerTheme.headerColor.withOpacity(0.12));
    expect(hourMaterial.shape, timePickerTheme.hourMinuteShape);

    final Material dayPeriodMaterial = _dayPeriodMaterial(tester);
    expect(dayPeriodMaterial.shape, timePickerTheme.dayPeriodShape);
  });

  testWidgets('Time picker uses values from TimePickerThemeData - input mode', (WidgetTester tester) async {
    final TimePickerThemeData timePickerTheme = _timePickerTheme();
    final ThemeData theme = ThemeData(timePickerTheme: timePickerTheme);
    await tester.pumpWidget(_TimePickerLauncher(themeData: theme, entryMode: TimePickerEntryMode.input));
    await tester.tap(find.text('X'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final InputDecoration hourDecoration = _textField(tester, '7').decoration;
    expect(hourDecoration.filled, timePickerTheme.inputDecorationTheme.filled);
    expect(hourDecoration.fillColor, timePickerTheme.inputDecorationTheme.fillColor);
    expect(hourDecoration.enabledBorder, timePickerTheme.inputDecorationTheme.enabledBorder);
    expect(hourDecoration.errorBorder, timePickerTheme.inputDecorationTheme.errorBorder);
    expect(hourDecoration.focusedBorder, timePickerTheme.inputDecorationTheme.focusedBorder);
    expect(hourDecoration.focusedErrorBorder, timePickerTheme.inputDecorationTheme.focusedErrorBorder);
    expect(hourDecoration.hintStyle, timePickerTheme.inputDecorationTheme.hintStyle);
  });
}

TimePickerThemeData _timePickerTheme() {
  return const TimePickerThemeData(
    backgroundColor: Colors.orange,
    headerColor: Colors.green,
    dialHandColor: Colors.brown,
    dialBackgroundColor: Colors.pinkAccent,
    hourMinuteTextStyle: TextStyle(fontSize: 8.0),
    dayPeriodTextStyle: TextStyle(fontSize: 8.0),
    helpTextStyle: TextStyle(fontSize: 8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    hourMinuteShape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    dayPeriodShape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.purple,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      hintStyle: TextStyle(fontSize: 8),
    ),
  );
}

class _TimePickerLauncher extends StatelessWidget {
  const _TimePickerLauncher({
    Key key,
    this.themeData,
    this.entryMode = TimePickerEntryMode.dial,
  }) : super(key: key);

  final ThemeData themeData;
  final TimePickerEntryMode entryMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Material(
        child: Center(
          child: Builder(
              builder: (BuildContext context) {
                return RaisedButton(
                  child: const Text('X'),
                  onPressed: () async {
                    await showTimePicker(
                      context: context,
                      initialEntryMode: entryMode,
                      initialTime: const TimeOfDay(hour: 7, minute: 0),
                    );
                  },
                );
              }
          ),
        ),
      ),
    );
  }
}

Material _dialogMaterial(WidgetTester tester) {
  return tester.widget<Material>(find.descendant(of: find.byType(Dialog), matching: find.byType(Material)).first);
}

Material _textMaterial(WidgetTester tester, String text) {
  return tester.widget<Material>(find.ancestor(of: find.text(text), matching: find.byType(Material)).first);
}

TextField _textField(WidgetTester tester, String text) {
  return tester.widget<TextField>(find.ancestor(of: find.text(text), matching: find.byType(TextField)).first);
}

Material _dayPeriodMaterial(WidgetTester tester) {
  return tester.widget<Material>(find.descendant(of: find.byWidgetPredicate((Widget w) => '${w.runtimeType}' == '_DayPeriodControl'), matching: find.byType(Material)).first);
}

RenderParagraph _textRenderParagraph(WidgetTester tester, String text) {
  return tester.element<StatelessElement>(find.text(text).first).renderObject as RenderParagraph;
}

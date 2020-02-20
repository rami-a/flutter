// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

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
    expect(timePickerTheme.activeDayPeriodColor, null);
    expect(timePickerTheme.headerTextTheme, null);
    expect(timePickerTheme.shape, null);
    expect(timePickerTheme.hourMinuteShape, null);
    expect(timePickerTheme.dayPeriodShape, null);
    expect(timePickerTheme.use2018Style, null);
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
      activeDayPeriodColor: Color(0xFFFFFFFF),
      headerTextTheme: TextTheme(),
      shape: RoundedRectangleBorder(),
      hourMinuteShape: RoundedRectangleBorder(),
      dayPeriodShape: RoundedRectangleBorder(),
      use2018Style: true,
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
    'activeDayPeriodColor: Color(0xffffffff)',
    'headerTextTheme: TextTheme#6fb5d(headline1: null, headline2: null, headline3: null, headline4: null, headline5: null, headline6: null, subtitle1: null, subtitle2: null, bodyText1: null, bodyText2: null, caption: null, button: null, overline: null)',
    'shape: RoundedRectangleBorder(BorderSide(Color(0xff000000), 0.0, BorderStyle.none), BorderRadius.zero)',
    'hourMinuteShape: RoundedRectangleBorder(BorderSide(Color(0xff000000), 0.0, BorderStyle.none), BorderRadius.zero)',
    'dayPeriodShape: RoundedRectangleBorder(BorderSide(Color(0xff000000), 0.0, BorderStyle.none), BorderRadius.zero)',
    'use2018Style: true'
    ]);
  });

  testWidgets('Passing no TimePickerThemeData uses defaults', (WidgetTester tester) async {
  });

  testWidgets('Passing no TimePickerThemeData uses defaults - 2018', (WidgetTester tester) async {
  });

  testWidgets('Time picker uses values from TimePickerThemeData', (WidgetTester tester) async {
    final TimePickerThemeData timePickerTheme = _timePickerTheme();
  });

  testWidgets('Time picker uses values from TimePickerThemeData - 2018', (WidgetTester tester) async {
    final TimePickerThemeData timePickerTheme = _timePickerTheme(use2018Style: true);
  });
}

TimePickerThemeData _timePickerTheme({bool use2018Style = false}) {
  return TimePickerThemeData(
    backgroundColor: Colors.orange,
    headerColor: Colors.green,
    dialHandColor: Colors.brown,
    dialBackgroundColor: Colors.pinkAccent,
    activeDayPeriodColor: Colors.teal,
    headerTextTheme: ThemeData.light().textTheme,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    hourMinuteShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    dayPeriodShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    use2018Style: use2018Style,
  );
}

Container _getContainerFromBanner(WidgetTester tester) {
  return tester.widget<Container>(_containerFinder());
}

Finder _containerFinder() {
  return find.descendant(of: find.byType(MaterialBanner), matching: find.byType(Container)).first;
}

RenderParagraph _getTextRenderObjectFromDialog(WidgetTester tester, String text) {
  return tester.element<StatelessElement>(_textFinder(text)).renderObject as RenderParagraph;
}

Finder _textFinder(String text) {
  return find.descendant(of: find.byType(MaterialBanner), matching: find.text(text));
}

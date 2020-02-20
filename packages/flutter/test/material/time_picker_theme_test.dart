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
      'use2018Style: true',
    ]);
  });

  testWidgets('Passing no TimePickerThemeData uses defaults', (WidgetTester tester) async {
    final ThemeData defaultTheme = ThemeData.fallback();
    await tester.pumpWidget(const _TimePickerLauncher());
    await tester.tap(find.text('X'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final Material dialogMaterial = _dialogMaterial(tester);
    expect(dialogMaterial.color, Colors.white);
    expect(dialogMaterial.shape, const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))));

    final RenderBox dial = tester.firstRenderObject<RenderBox>(find.byType(CustomPaint));
    expect(
      dial,
      paints
        ..circle(color: Colors.grey[200]) // Dial background color.
        ..circle(color: defaultTheme.accentColor), // Dial hand color.
    );

    final Container headerContainer = _headerContainer(tester);
    expect(headerContainer.decoration, const BoxDecoration(color: Colors.blue));

    final RenderParagraph content = _getTextRenderObjectFromDialog(tester, '7');
    expect(
      content.text.style,
      Typography.material2014().englishLike.headline3.merge(Typography.material2014().black.headline3).copyWith(fontSize: 50, color: Colors.white),
    );
  });

  testWidgets('Passing no TimePickerThemeData uses defaults - 2018', (WidgetTester tester) async {
    final ThemeData defaultTheme = ThemeData.fallback();
    await tester.pumpWidget(const _TimePickerLauncher(use2018Style: true,));
    await tester.tap(find.text('X'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final Material dialogMaterial = _dialogMaterial(tester);
    expect(dialogMaterial.color, Colors.white);
    expect(dialogMaterial.shape, const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))));

    final RenderBox dial = tester.firstRenderObject<RenderBox>(find.byType(CustomPaint));
    expect(
      dial,
      paints
        ..circle(color: Colors.grey[200]) // Dial background color.
        ..circle(color: Color(defaultTheme.colorScheme.primary.value)), // Dial hand color.
    );

    final RenderParagraph content = _getTextRenderObjectFromDialog(tester, '7');
    expect(
      content.text.style,
      Typography.material2014().englishLike.headline3.merge(Typography.material2014().black.headline3).copyWith(color: defaultTheme.colorScheme.primary),
    );

    final Material hourMaterial = _textMaterial(tester, '7');
    expect(hourMaterial.color, defaultTheme.colorScheme.primary.withOpacity(0.12));
    expect(hourMaterial.shape, const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))));

    final Material amMaterial = _textMaterial(tester, 'AM');
    expect(amMaterial.color, defaultTheme.colorScheme.surface);

    final Material dayPeriodMaterial = _dayPeriodMaterial(tester);
    expect(
      dayPeriodMaterial.shape,
      RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        side: BorderSide(color: defaultTheme.dividerColor),
      ),
    );
  });

  testWidgets('Time picker uses values from TimePickerThemeData', (WidgetTester tester) async {
    final TimePickerThemeData timePickerTheme = _timePickerTheme();
    await tester.pumpWidget(_TimePickerLauncher(themeData: ThemeData(timePickerTheme: timePickerTheme)));
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

    final Container headerContainer = _headerContainer(tester);
    expect(headerContainer.decoration, BoxDecoration(color: timePickerTheme.headerColor));

    final RenderParagraph content = _getTextRenderObjectFromDialog(tester, '7');
    expect(
      content.text.style,
      Typography.material2014().englishLike.bodyText2
          .merge(Typography.material2014().black.bodyText2)
          .merge(timePickerTheme.headerTextTheme.headline3)
          .copyWith(fontSize: 50, color: Colors.white),
    );
  });

  testWidgets('Time picker uses values from TimePickerThemeData - 2018', (WidgetTester tester) async {
    final TimePickerThemeData timePickerTheme = _timePickerTheme(use2018Style: true);
    await tester.pumpWidget(_TimePickerLauncher(themeData: ThemeData(timePickerTheme: timePickerTheme), use2018Style: true,));
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

    final RenderParagraph content = _getTextRenderObjectFromDialog(tester, '7');
    expect(
      content.text.style,
      Typography.material2014().englishLike.bodyText2
          .merge(Typography.material2014().black.bodyText2)
          .merge(timePickerTheme.headerTextTheme.headline3)
          .copyWith(color: timePickerTheme.headerColor),
    );

    final Material hourMaterial = _textMaterial(tester, '7');
    expect(hourMaterial.color, timePickerTheme.headerColor.withOpacity(0.12));
    expect(hourMaterial.shape, timePickerTheme.hourMinuteShape);

    final Material amMaterial = _textMaterial(tester, 'AM');
    expect(amMaterial.color, timePickerTheme.activeDayPeriodColor);

    final Material dayPeriodMaterial = _dayPeriodMaterial(tester);
    expect(dayPeriodMaterial.shape, timePickerTheme.dayPeriodShape);
  });
}

TimePickerThemeData _timePickerTheme({bool use2018Style = false}) {
  return TimePickerThemeData(
    backgroundColor: Colors.orange,
    headerColor: Colors.green,
    dialHandColor: Colors.brown,
    dialBackgroundColor: Colors.pinkAccent,
    activeDayPeriodColor: Colors.teal,
    headerTextTheme: Typography.englishLike2018,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    hourMinuteShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    dayPeriodShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    use2018Style: use2018Style,
  );
}

class _TimePickerLauncher extends StatelessWidget {
  const _TimePickerLauncher({ Key key, this.themeData, this.use2018Style = false }) : super(key: key);

  final ThemeData themeData;
  final bool use2018Style;

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
                      initialTime: const TimeOfDay(hour: 7, minute: 0),
                      use2018Style: use2018Style,
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

Material _dayPeriodMaterial(WidgetTester tester) {
  return tester.widget<Material>(find.descendant(of: find.byWidgetPredicate((Widget w) => '${w.runtimeType}' == '_DayPeriodControl2018'), matching: find.byType(Material)).first);
}

Container _headerContainer(WidgetTester tester) {
  return tester.widget<Container>(find.descendant(of: find.byWidgetPredicate((Widget w) => '${w.runtimeType}' == '_TimePickerHeader'), matching: find.byType(Container)).first);
}

RenderParagraph _getTextRenderObjectFromDialog(WidgetTester tester, String text) {
  return tester.element<StatelessElement>(find.text(text)).renderObject as RenderParagraph;
}

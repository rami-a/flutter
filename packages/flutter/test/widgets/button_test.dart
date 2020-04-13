// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'semantics_tester.dart';

void main() {
  testWidgets('Button takes taps', (WidgetTester tester) async {
    bool value = false;
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return boilerplate(
            child: Button(
              child: const Text('Tap me'),
              onPressed: () {
                setState(() {
                  value = true;
                });
              },
            ),
          );
        },
      ),
    );

    expect(value, isFalse);
    await tester.tap(find.byType(Button));
    expect(value, isTrue);
  });

  testWidgets('Button has correct semantics', (WidgetTester tester) async {
    final SemanticsTester semantics = SemanticsTester(tester);
    await tester.pumpWidget(
      boilerplate(
        child: Center(
          child: Button(
            onPressed: () { },
            child: const Text('ABC'),
          ),
        ),
      ),
    );

    expect(semantics, hasSemantics(
      TestSemantics.root(
        children: <TestSemantics>[
          TestSemantics.rootChild(
            actions: SemanticsAction.tap.index,
            label: 'ABC',
            flags: SemanticsFlag.isButton.index,
          ),
        ],
      ),
      ignoreId: true,
      ignoreRect: true,
      ignoreTransform: true,
    ));

    semantics.dispose();
  });

  testWidgets('Can customize button', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplate(child: Button(
      child: const Text('ABC'),
      color: const Color(0x000000FF),
      textStyle: const TextStyle(color: Color(0x0000FF00)),
      borderRadius: BorderRadius.circular(16.0),
      onPressed: () { },
    )));

    final RenderParagraph text = tester.element<StatelessElement>(
      find.descendant(of: find.byType(Button), matching: find.text('ABC')),
    ).renderObject as RenderParagraph;
    final BoxDecoration boxDecoration = tester.widget<DecoratedBox>(
        find.widgetWithText(DecoratedBox, 'ABC')
    ).decoration as BoxDecoration;

    expect(boxDecoration.color, const Color(0x000000FF));
    expect(boxDecoration.borderRadius, BorderRadius.circular(16.0));
    expect(text.text.style, const TextStyle(color: Color(0x0000FF00)));
  });

  testWidgets('Disabled button color', (WidgetTester tester) async {
    // Default color
    await tester.pumpWidget(boilerplate(child: const Button(
      child: Text('ABC'),
      onPressed: null,
    )));

    BoxDecoration boxDecoration = tester.widget<DecoratedBox>(
        find.widgetWithText(DecoratedBox, 'ABC')
    ).decoration as BoxDecoration;

    expect(boxDecoration.color, const Color(0x33666666));

    // Custom disabled color
    await tester.pumpWidget(boilerplate(child: const Button(
      child: Text('ABC'),
      disabledColor: Color(0xFF0000FF),
      onPressed: null,
    )));

    boxDecoration = tester.widget<DecoratedBox>(
        find.widgetWithText(DecoratedBox, 'ABC')
    ).decoration as BoxDecoration;

    expect(boxDecoration.color, const Color(0xFF0000FF));
  });
}

Widget boilerplate({ Widget child }) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Center(child: child),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_dropdown.dart';

void main() {
  group('Android dropdown', () {
    setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.android);

    testWidgets('should show material dropdown', (WidgetTester tester) async {
      final options = givenAnOptions();
      final selectedOption = options[3];

      await renderWidget(tester, options, selectedOption);

      expect(find.byType(typeOf<DropdownButton<Option>>()), findsOneWidget);
      expect(find.byType(CupertinoButton), findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });
    testWidgets('should show selected option', (WidgetTester tester) async {
      final options = givenAnOptions();
      final selectedOption = options[3];

      await renderWidget(tester, options, selectedOption);

      final dropdown =
          tester.widget(find.byType(typeOf<DropdownButton<Option>>()))
              as DropdownButton<Option>;

      expect(dropdown.value, selectedOption);

      debugDefaultTargetPlatformOverride = null;
    });
    testWidgets('should select an option in dropdown',
        (WidgetTester tester) async {
      final options = givenAnOptions();
      final selectedOption = options[3];
      final optionToSelect = options[6];

      await renderWidget(tester, options, selectedOption, onChanged: (option) {
        if (option != selectedOption) {
          expect(option, optionToSelect);
        }
      });

      await tester.tap(find.byType(typeOf<DropdownButton<Option>>()));
      await tester.pumpAndSettle();

      final itemFinder = find.bySemanticsLabel(optionToSelect.name);
      await tester.ensureVisible(itemFinder);
      await tester.tap(itemFinder);
      await tester.pumpAndSettle();

      debugDefaultTargetPlatformOverride = null;
    });
  });
  group('iOS dropdown', () {
    setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.iOS);

    testWidgets('should show cupertino dropdown', (WidgetTester tester) async {
      final options = givenAnOptions();
      final selectedOption = options[3];

      await renderWidget(tester, options, selectedOption);

      expect(find.byType(CupertinoButton), findsOneWidget);
      expect(find.byType(typeOf<DropdownButton<Option>>()), findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });
    testWidgets('should show selected option', (WidgetTester tester) async {
      final options = givenAnOptions();
      final selectedOption = options[3];

      await renderWidget(tester, options, selectedOption);

      final button =
          tester.widget(find.byType(CupertinoButton)) as CupertinoButton;
      final text = tester.widget(find.byWidget(button.child)) as Text;

      expect(text.data, selectedOption.name);

      debugDefaultTargetPlatformOverride = null;
    });
    testWidgets('should select an option in cupertino picker',
        (WidgetTester tester) async {
      final options = givenAnOptions();
      final selectedOption = options[3];
      final optionToSelect = options[6];

      await renderWidget(tester, options, selectedOption, onChanged: (option) {
        expect(option, optionToSelect);
      });

      await tester.tap(find.byType(CupertinoButton));
      await tester.pumpAndSettle();

      await tester.ensureVisible(
          find.bySemanticsLabel(optionToSelect.name, skipOffstage: false));

      debugDefaultTargetPlatformOverride = null;
    });
  });
}

Future<void> renderWidget(
    WidgetTester tester, List<Option> options, Option selectedOption,
    {ValueChanged<Option?>? onChanged}) async {
  await tester.pumpWidget(MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          body: PlatformDropdown(
              options: options, value: selectedOption, onChanged: onChanged))));
}

Type typeOf<T>() => T;

List<Option> givenAnOptions({int count = 10}) {
  return Iterable<int>.generate(count)
      .map((int n) => Option(n.toString(), 'Name $n'))
      .toList();
}

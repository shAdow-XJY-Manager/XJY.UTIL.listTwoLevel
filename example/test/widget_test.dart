import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_twolevel_demo/main.dart';

void main() {
  testWidgets(
    'category selection, second-level callback, empty state and return stay connected',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Flutter · 界面与交互'));
      await tester.pumpAndSettle();
      expect(find.text('已进入：Flutter · 界面与交互'), findsOneWidget);
      await tester.tap(find.text('示例一 · 点击整行显示结果'));
      await tester.pumpAndSettle();
      expect(find.text('已选择：示例一 · 点击整行显示结果'), findsOneWidget);
      await tester.tap(find.widgetWithText(SwitchListTile, '显示空列表'));
      await tester.pumpAndSettle();
      expect(find.text('暂无内容'), findsOneWidget);
      expect(find.text('示例一 · 点击整行显示结果'), findsNothing);
      await tester.tap(find.byTooltip('返回分类'));
      await tester.pumpAndSettle();
      expect(find.text('Two Level · 分类列表'), findsOneWidget);
      await tester.tap(find.widgetWithText(SwitchListTile, '显示空列表'));
      await tester.pumpAndSettle();
      expect(find.text('Flutter · 界面与交互'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}

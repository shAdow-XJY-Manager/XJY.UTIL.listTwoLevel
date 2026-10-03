import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_twolevel/list_B.dart';

void main() {
  testWidgets('selecting a second-level item returns its title', (tester) async {
    String? selected;
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: BListBuilder(
      levelObj: [{'title': 'Chapter 1'}, {'title': 'Chapter 2'}],
      onPressed: (title) => selected = title,
    ))));
    await tester.tap(find.text('Chapter 2'));
    expect(selected, 'Chapter 2');
  });
}

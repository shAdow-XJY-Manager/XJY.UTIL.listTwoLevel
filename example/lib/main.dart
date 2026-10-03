import 'package:flutter/material.dart';
import 'package:list_twolevel/list_A.dart';
import 'package:list_twolevel/list_B.dart';

void main() => runApp(const MyApp());
ThemeData _theme() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF111315),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFD6EF36),
    onPrimary: Color(0xFF111315),
    secondary: Color(0xFFFFB23F),
    surface: Color(0xFF1B1E20),
    onSurface: Color(0xFFF4F2E9),
    outline: Color(0xFF41484B),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: '两级列表演示', theme: _theme(), home: const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _category;
  String _feedback = '点击分类进入第二级列表';
  bool _empty = false;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(_category ?? 'Two Level · 分类列表'),
      leading: _category == null
          ? null
          : IconButton(
              tooltip: '返回分类',
              icon: const Icon(Icons.arrow_back),
              onPressed: () => setState(() => _category = null),
            ),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Semantics(liveRegion: true, child: Text(_feedback)),
        ),
        SwitchListTile(
          title: const Text('显示空列表'),
          value: _empty,
          onChanged: (value) => setState(() => _empty = value),
        ),
        Expanded(
          child: _category == null
              ? AListBuilder(
                  levelObj: _empty
                      ? []
                      : [
                          {
                            'title': 'Flutter · 界面与交互',
                            'image': 'assets/Flutter.png',
                          },
                          {
                            'title': 'Web · 长标题会自然换行，字体放大后仍可阅读',
                            'image': 'assets/Web.png',
                          },
                          {'title': '缺少图片的分类'},
                        ],
                  onPressed: (title) => setState(() {
                    _category = title;
                    _feedback = '已进入：$title';
                  }),
                )
              : BListBuilder(
                  levelObj: _empty
                      ? []
                      : [
                          {'title': '示例一 · 点击整行显示结果'},
                          {'title': '示例二 · 键盘 Tab 聚焦，Enter 打开'},
                          {'title': '示例三 · 多行文字和较大字号不会裁切内容'},
                        ],
                  itemHeight: 56,
                  onPressed: (title) =>
                      setState(() => _feedback = '已选择：$title'),
                ),
        ),
      ],
    ),
  );
}

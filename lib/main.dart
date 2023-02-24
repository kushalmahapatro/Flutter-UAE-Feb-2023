// import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3_7/global_selection_screen.dart';
import 'package:flutter_3_7/menus_screen.dart';
import 'package:flutter_3_7/text_magnifier_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter v3.7',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: CupertinoColors.activeGreen,
      ),
      home: const MyHomePage(title: 'Flutter v3.7'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _cupertinoList(),
    );
  }

  Widget _cupertinoList() {
    return CupertinoListSection.insetGrouped(
      header: Text(
        'Updates',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      children: <CupertinoListTile>[
        CupertinoListTile.notched(
          title: const Text('Global Selection'),
          leading: Container(color: CupertinoColors.activeGreen),
          trailing: const CupertinoListTileChevron(),
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (_) => const GlobalSelectionScreen())),
        ),
        CupertinoListTile.notched(
          title: const Text('Menus'),
          leading: Container(color: CupertinoColors.activeBlue),
          trailing: const CupertinoListTileChevron(),
          onTap: () => Navigator.push(
              context, CupertinoPageRoute(builder: (_) => const MenusScreen())),
        ),
        CupertinoListTile.notched(
          title: const Text('Text magnifier'),
          leading: Container(color: CupertinoColors.activeOrange),
          trailing: const CupertinoListTileChevron(),
          onTap: () => Navigator.push(context,
              CupertinoPageRoute(builder: (_) => const TextMagnifierScreen())),
        ),
      ],
    );
  }
}

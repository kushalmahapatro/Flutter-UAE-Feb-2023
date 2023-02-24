import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3_7/global_selection_screen.dart';
import 'package:flutter_3_7/text_magnifier_screen.dart';

enum MenuSelection {
  increment('Increment', shortcut: 'i'),
  decrement('Decrement', shortcut: 'd');

  final String value;
  final String shortcut;
  const MenuSelection(this.value, {this.shortcut = ''});
}

class MenusScreen extends StatefulWidget {
  const MenusScreen({super.key});

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  void _decrementCounter() {
    setState(() => _counter--);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: CupertinoColors.activeBlue,
      ),
      child: Scaffold(
        appBar:
            AppBar(title: const Text('Menus Screen'), actions: [_menuBar()]),
        // body: _menuBar(),
        body: PlatformMenuBar(
          menus: _platformMenu(),
          child: _counterText(context),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: MenuSelection.increment.value,
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Center _counterText(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          _countWithContextMenu(context),
        ],
      ),
    );
  }

  SelectableText _countWithContextMenu(BuildContext context) {
    return SelectableText(
      '$_counter',
      contextMenuBuilder: (context, editableTextState) {
        return AdaptiveTextSelectionToolbar.buttonItems(
            anchors: editableTextState.contextMenuAnchors,
            buttonItems: _getMenu<ContextMenuButtonItem>());
      },
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _menuBar() {
    return MenuBar(
      style: const MenuStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
          elevation: MaterialStatePropertyAll(0),
          fixedSize: MaterialStatePropertyAll(Size.fromWidth(50))),
      children: [
        SubmenuButton(
          menuChildren: [
            ..._getMenu<MenuItemButton>(),
            ..._getNavigationMenuItem()
          ],
          style: const ButtonStyle(visualDensity: VisualDensity.compact),
          child: const Icon(Icons.more_vert),
        )
      ],
    );
  }

  List<PlatformMenuItem> _platformMenu() {
    return <PlatformMenuItem>[
      PlatformMenu(
        label: 'Platform Menu',
        menus: <PlatformMenuItem>[
          PlatformMenuItemGroup(
            members: _getMenu<PlatformMenuItem>(),
          ),
          if (PlatformProvidedMenuItem.hasMenu(
              PlatformProvidedMenuItemType.quit))
            const PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.quit),
        ],
      ),
    ];
  }

  void handleMenuSelection(MenuSelection value) {
    switch (value) {
      case MenuSelection.increment:
        _incrementCounter();
        break;
      case MenuSelection.decrement:
        _decrementCounter();
        break;
    }
  }

  List<Widget> _getNavigationMenuItem() {
    return [
      SubmenuButton(menuChildren: [
        MenuItemButton(
          onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (_) => const GlobalSelectionScreen())),
          child: const Text('Global Selection'),
        ),
        MenuItemButton(
          onPressed: () => Navigator.push(context,
              CupertinoPageRoute(builder: (_) => const TextMagnifierScreen())),
          child: const Text('Text Magnifier'),
        )
      ], child: const Text('Navigate'))
    ];
  }

  List<T> _getMenu<T extends Object>() {
    return <T>[
      _getMenuItem<T>(MenuSelection.increment),
      _getMenuItem<T>(MenuSelection.decrement)
    ];
  }

  T _getMenuItem<T extends Object>(MenuSelection selection) {
    switch (T) {
      case PlatformMenuItem:
        return PlatformMenuItem(
          label: selection.value,
          onSelected: () => handleMenuSelection(selection),
          shortcut: CharacterActivator(selection.shortcut),
        ) as T;

      case ContextMenuButtonItem:
        return ContextMenuButtonItem(
            onPressed: () => handleMenuSelection(selection),
            label: selection.value) as T;

      case MenuItemButton:
        return MenuItemButton(
          onPressed: () => handleMenuSelection(selection),
          child: Text(selection.value),
        ) as T;

      default:
        return Container() as T;
    }
  }
}

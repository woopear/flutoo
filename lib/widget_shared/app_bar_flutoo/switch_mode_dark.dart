import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';

class SwitchModeDark extends StatefulWidget {
  const SwitchModeDark({Key? key}) : super(key: key);

  @override
  State<SwitchModeDark> createState() => _SwitchModeDarkState();
}

class _SwitchModeDarkState extends State<SwitchModeDark> {
  /// init icon
  Widget imgMode = WooThemeProvider().isDarkMode
      ? const Icon(Icons.brightness_3)
      : const Icon(Icons.brightness_7);

  /// si true on passe à false et on active le mode claire
  /// sinon on active le mode dark
  void changeModeTheme(BuildContext context) {
    bool value = context.read<WooThemeProvider>().isDarkMode;
    if (value) {
      context.read<WooThemeProvider>().changeTheme(false);
      setState(() {
        imgMode = const Icon(Icons.brightness_3);
      });
    } else {
      context.read<WooThemeProvider>().changeTheme(true);
      setState(() {
        imgMode = const Icon(Icons.brightness_7);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => changeModeTheme(context),
      icon: imgMode,
    );
  }
}

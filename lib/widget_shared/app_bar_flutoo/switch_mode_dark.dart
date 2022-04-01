import 'package:flutoo/config/themes/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchModeDark extends ConsumerStatefulWidget {
  const SwitchModeDark({Key? key}) : super(key: key);

  @override
  _SwitchModeDarkState createState() => _SwitchModeDarkState();
}

class _SwitchModeDarkState extends ConsumerState<SwitchModeDark> {
  @override
  Widget build(BuildContext context) {
    final trueDark = ref.watch(themeState).isDark;
    return IconButton(
      onPressed: () => ref.watch(themeState).changeDark(!trueDark),
      icon: ref.watch(themeState).themeMode == ThemeMode.light ||
              MediaQuery.platformBrightnessOf(context) == Brightness.light
          ? const Icon(Icons.brightness_3)
          : const Icon(Icons.brightness_7),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/config/themes/themes.dart';
import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutoo/utils/services/firebase/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WooThemeProvider()),
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => ConditionProvider()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutoo',
      // utilisation du context pour recuperer
      // le themeMode qui ce charge de modifier votre theme
      // via votre bouton switch ou du theme du systeme 
      themeMode: context.watch<WooThemeProvider>().themeMode,
      // nom de votre variable dans le fichier themes.dart
      theme: themeClair,
      // nom de votre variable dans le fichier themes.dart
      darkTheme: themeDark,
      initialRoute: Routes().home,
      routes: Routes().urls(),
    );
  }
}
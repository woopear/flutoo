
import 'package:firebase_core/firebase_core.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/config/themes/theme_state.dart';
import 'package:flutoo/config/themes/themes.dart';
import 'package:flutoo/utils/services/firebase/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    /*MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WooThemeProvider()),
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => ConditionProvider()),
        ChangeNotifierProvider(create: (context) => ArticleProvider()),
        ChangeNotifierProvider(create: (context) => ContentArticleProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const App(),
    ),*/
    const ProviderScope(child: App())
  );
}

class App extends ConsumerStatefulWidget  {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutoo',
      // utilisation du context pour recuperer
      // le themeMode qui ce charge de modifier votre theme
      // via votre bouton switch ou du theme du systeme 
      themeMode: ref.watch(themeState).themeMode,
      // nom de votre variable dans le fichier themes.dart
      theme: themeClair,
      // nom de votre variable dans le fichier themes.dart
      darkTheme: themeDark,
      initialRoute: Routes().home,
      routes: Routes().urls(),
    );
  }
}
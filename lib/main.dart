import 'package:flutter/material.dart';
import 'package:nhl_tournament/core/viewmodels/matches_viewmodel.dart';
import 'package:nhl_tournament/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'helpers/dependency_assembly.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyAssembler();

  bool isInRelease = true;
  assert(() {
    isInRelease = false;
    return true;
  }());

  if (isInRelease) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MatchesViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF212121),
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

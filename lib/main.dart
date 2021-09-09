import 'package:flutter/material.dart';
import 'package:nhl_tournament/ui/home_page.dart';
import 'package:nhl_tournament/viewmodels/matches_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

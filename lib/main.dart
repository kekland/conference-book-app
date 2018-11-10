import 'package:conference/create_page.dart';
import 'package:conference/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(new SystemUiOverlayStyle(
        statusBarColor: const Color(0x00FFFFFF),
        statusBarIconBrightness: Brightness.light));
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blueAccent,
      ),
      home: MainPage(),
    );
  }
}
